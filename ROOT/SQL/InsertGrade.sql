CREATE OR REPLACE PROCEDURE INSERTGRADE  (
    sScore IN VARCHAR2,
    sStudentId IN VARCHAR2,
    sCourseId IN VARCHAR2,
    nCourseIdNo IN NUMBER,
    nYear IN NUMBER,
    nSemester IN NUMBER,
    result OUT VARCHAR2
    )
    IS
    not_current_semester EXCEPTION;
    not_in_vacation EXCEPTION;

    space_included EXCEPTION;
    not_number_detected EXCEPTION;
    range_exception EXCEPTION;
    null_inserted EXCEPTION;

    curYear NUMBER;
    curSemester NUMBER;
    dDate DATE;
    sMonth CHAR(2);
    nBlank NUMBER;
    nScore NUMBER;
BEGIN
    result := '';
    curYear := Date2GradeYear(SYSDATE);
    curSemester := Date2GradeSemester(SYSDATE);

    /* 예외 1: 현재 년도/학기의 성적만 처리할 수 있음 */
    IF nYear != curYear OR nSemester != curSemester THEN
        RAISE_APPLICATION_ERROR(20002, 'Insert Impossible(Reason: You can insert grades only in current semester.)');
    END IF;

    /* 예외 2: 방학 기간(7~8월, 1~2월)에는 성적을 처리할 수 없음 */
    SELECT TO_CHAR(dDate, 'MM')
    INTO sMonth
    FROM DUAL;
    IF sMonth='07' OR sMonth='08' OR sMonth='01' OR sMonth='02' THEN
        RAISE_APPLICATION_ERROR(20003, 'Insert Impossible(Reason: You can insert grades only during the semester.)');
    END IF;

    /* 예외 6: NULL 값을 입력할 수 없음 */
    IF sScore IS NULL THEN
        RAISE null_inserted;
    END IF;

    /* 예외 3: 공백값을 입력할 수 없음 */
    SELECT instr(sScore, ' ')
    INTO nBlank
    FROM DUAL;
    IF(nBlank > 0) THEN
        RAISE space_included;
    END IF;

    /* 예외 4: 숫자 외 다른 문자가 포함됨 */
    IF NOT REGEXP_LIKE(sScore, '^[[:digit:]]+$') THEN
        RAISE not_number_detected;
    END IF;

    /* 예외 5: 0 ~ 100 사이의 값만 입력할 수 있음 */
    nScore := TO_NUMBER(sScore);
    IF nScore < 0 OR nScore > 100 THEN
        RAISE range_exception;
    END IF;

    /* 정상 작동 */
    UPDATE enroll SET e_grade=ChangeGrade(nScore), e_score=nScore
    WHERE s_id=sStudentID AND c_id=sCourseId AND c_id_no=nCourseIdNo AND e_year=nYear AND e_semester=nSemester;
    COMMIT;
    result := 'Update Complete';

    EXCEPTION
    WHEN null_inserted THEN 
    result := 'Update Impossible(Reason: Score is not inserted)';
    WHEN space_included THEN
    result := 'Update Impossible(Reason: You cannot insert space into score)';
    WHEN not_number_detected THEN
    result := 'Update Impossible(Reason: You cannot insert other character into score)';
    WHEN range_exception THEN
    result := 'Update Impossible(Reason: Score should be from 0 to 100)';
    WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/