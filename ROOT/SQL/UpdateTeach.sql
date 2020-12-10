CREATE OR REPLACE PROCEDURE UPDATETEACH (
    sProfessorId IN VARCHAR2,
    sCourseId IN VARCHAR2,
    sCourseIdNo IN VARCHAR2,
    sCourseUnit IN VARCHAR2,
    sTeachMax IN VARCHAR2,
    coursename OUT VARCHAR2,
    result OUT VARCHAR2
    )
    IS
    space_included EXCEPTION;
    not_number_detected EXCEPTION;
    range_exception EXCEPTION;
    null_inserted EXCEPTION;
    less_than_enrolled EXCEPTION;

    nYear NUMBER;
    nSemester NUMBER;
    nBlank NUMBER;
    nTeachMax NUMBER;
    nEnrollCount NUMBER;
BEGIN
    result := '';
    nYear := Date2EnrollYear(SYSDATE);
    nSemester := Date2EnrollSemester(SYSDATE);

    SELECT c_name
    INTO coursename
    FROM course
    WHERE c_id=sCourseId and c_id_no=TO_NUMBER(sCourseIdNo);

    /* 예외 4: NULL 값을 입력할 수 없음 */
    IF sTeachMax IS NULL THEN
        RAISE null_inserted;
    END IF;

    /* 예외 1: 공백값을 입력할 수 없음 */
    SELECT instr(sTeachMax, ' ')
    INTO nBlank
    FROM DUAL;
    IF(nBlank > 0) THEN
        RAISE space_included;
    END IF;

    /* 예외 2: 숫자 외 다른 문자가 포함됨 */
    IF NOT REGEXP_LIKE(sTeachMax, '^[[:digit:]]+$') THEN
        RAISE not_number_detected;
    END IF;

    /* 예외 3: 0 ~ 100 사이의 값만 입력할 수 있음 */
    nTeachMax := TO_NUMBER(sTeachMax);
    IF nTeachMax < 0 OR nTeachMax > 100 THEN
        RAISE range_exception;
    END IF;

    /* 예외 5: 현재 수강 신청 인원 미만으로 입력할 수 없음 */
    SELECT COUNT(*)
    INTO nEnrollCount
    FROM enroll
    WHERE c_id=sCourseId AND c_id_no=TO_NUMBER(sCourseIdNo) AND e_year=nYear AND e_semester=nSemester;

    IF nTeachMax < nEnrollCount THEN
        RAISE less_than_enrolled;
    END IF;

    /* 정상 작동 */
    UPDATE teach SET t_max=nTeachMax WHERE p_id=sProfessorId AND c_id=sCourseId AND c_id_no=TO_NUMBER(sCourseIdNo) AND t_year=nYear AND t_semester=nSemester;
    COMMIT;
    result := 'Update Complete';

    EXCEPTION
    WHEN null_inserted THEN 
    result := 'Update Impossible(Reason: Max number is not inserted)';
    WHEN space_included THEN
    result := 'Update Impossible(Reason: You cannot insert space into max number)';
    WHEN not_number_detected THEN
    result := 'Update Impossible(Reason: You cannot insert other character into max number)';
    WHEN range_exception THEN
    result := 'Update Impossible(Reason: Max number should be from 0 to 100)';
    WHEN less_than_enrolled THEN
    result := 'Update Failed(Reason: You should insert more than ' || TO_CHAR(nEnrollCount) || ' that is current enrolled number.';
    WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/