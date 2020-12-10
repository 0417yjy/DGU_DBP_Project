CREATE OR REPLACE FUNCTION DATE2GRADESEMESTER(dDate IN DATE)
RETURN NUMBER
IS
    nSemester NUMBER;
    sMonth CHAR(2);
BEGIN
    /* 3월 ~ 8월 : 1학기,   9월 ~ 2월  : 2학기  */
    SELECT TO_CHAR(dDate, 'MM')
    INTO sMonth
    FROM DUAL;
    IF (sMonth >= '03' and sMonth <= '08') THEN 
        nSemester := 1;
    ELSE
        nSemester := 2;
    END IF;
RETURN nSemester;
END;
/