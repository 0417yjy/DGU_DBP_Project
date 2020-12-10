CREATE OR REPLACE PROCEDURE UPDATECLASS (
    sProfessorId IN VARCHAR2,
    sCourseId IN VARCHAR2,
    nCourseIdNo IN NUMBER,
    sWhere IN VARCHAR2,
    nTime IN NUMBER,
    result OUT VARCHAR2
    )
    IS
    nothing_changed EXCEPTION;
    duplicate_course EXCEPTION;
    
    oldWhere VARCHAR2(50);
    oldTime NUMBER;
    nYear NUMBER;
    nSemester NUMBER;
    sDuplicated VARCHAR2(50);

    CURSOR c IS
        SELECT c.c_name
        FROM teach t INNER JOIN course c ON t.c_id=c.c_id AND t.c_id_no=c.c_id_no
        WHERE t_time=nTime AND t_where=sWhere AND t_year=nYear AND t_semester=nSemester;
BEGIN
    result := '';
    nYear := Date2EnrollYear(SYSDATE);
    nSemester := Date2EnrollSemester(SYSDATE);

    /* 예외 1: 바꾼 것이 없음 */
    SELECT t_where, t_time
    INTO oldWhere, oldTime
    FROM teach
    WHERE p_id=sProfessorId AND c_id=sCourseID AND c_id_no=nCourseIdNo;
    
    IF sWhere=oldWhere AND nTime=oldTime THEN
        RAISE nothing_changed;
    END IF;

    /* 예외 2: 겹치는 것 존재 */
    OPEN c;
    FETCH c INTO sDuplicated;

    IF c%FOUND THEN
        RAISE duplicate_course;
    END IF;
    CLOSE c;

    /* teach 업데이트 */
    UPDATE teach SET t_time=nTime, t_where=sWhere WHERE p_id=sProfessorId AND c_id=sCourseId AND c_id_no=nCourseIdNo AND t_year=nYear AND t_semester=nSemester;
    COMMIT;
    result := 'Updated course info.';

    EXCEPTION
    WHEN nothing_changed THEN 
    result := 'Nothing changed.';
    WHEN duplicate_course THEN 
    result := 'Cannot update because of ' || sDuplicated;
    WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/