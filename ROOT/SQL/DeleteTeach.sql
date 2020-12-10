CREATE OR REPLACE PROCEDURE DELETETEACH (
    sProfessorId IN VARCHAR2,
    sCourseId IN VARCHAR2,
    nCourseIdNo IN NUMBER,
    result OUT VARCHAR2
    )
    IS
    too_many_enrolls EXCEPTION;

    nYear NUMBER;
    nSemester NUMBER;
    nEnrollCount NUMBER;
    nMaxEnroll NUMBER;
BEGIN
    result := '';
    nYear := Date2EnrollYear(SYSDATE);
    nSemester := Date2EnrollSemester(SYSDATE);

    SELECT COUNT(*)
    INTO nEnrollCount
    FROM enroll
    WHERE c_id=sCourseId AND c_id_no=nCourseIdNo AND e_year=nYear AND e_semester=nSemester;

    SELECT t_max
    INTO nMaxEnroll
    FROM teach
    WHERE p_id=sProfessorId AND c_id=sCourseId AND c_id_no=nCourseIdNo AND t_year=nYear AND t_semester=nSemester;
    
    /* 예외 처리: 정원의 절반 이상 등록하였으면 에러*/
    IF (nEnrollCount > nMaxEnroll / 2) THEN
        RAISE too_many_enrolls;
    END IF;

    /* teach 에서 삭제 */
    DELETE FROM teach WHERE p_id=sProfessorId AND c_id=sCourseId AND c_id_no=nCourseIdNo AND t_year=nYear AND t_semester=nSemester;
    COMMIT;
    result := 'Requested course has been cancelled.';

    EXCEPTION
    WHEN too_many_enrolls THEN 
    result := 'Requested course cannot be cancelled because the enrolled is more than 50% of maximum enrolls.';
    WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/