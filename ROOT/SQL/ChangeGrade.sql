CREATE OR REPLACE FUNCTION CHANGEGRADE(nScore IN NUMBER)
RETURN VARCHAR2
IS
    sGrade VARCHAR(5);
BEGIN
    IF nScore >= 90 THEN
        sGrade := 'A';
    ELSIF nScore >= 80 THEN
        sGrade := 'B';
    ELSIF nScore >= 70 THEN
        sGrade := 'C';
    ELSIF nScore >= 60 THEN
        sGrade := 'D';
    ELSE
        sGrade := 'F';
    END IF;
RETURN sGrade;
END;
/