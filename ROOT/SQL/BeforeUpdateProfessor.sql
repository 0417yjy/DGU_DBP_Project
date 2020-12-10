CREATE OR REPLACE TRIGGER BEFOREUPDATEPROFESSOR
BEFORE UPDATE ON professor
FOR EACH ROW
DECLARE
    invalid_password EXCEPTION;
    invalid_research EXCEPTION;
    nothing_changed EXCEPTION;
BEGIN
    IF NOT REGEXP_LIKE(:new.p_pwd, '([a-zA-Z]+\d+)|(\d+[a-zA-Z]+)') THEN
        RAISE invalid_password;
    ELSIF :new.p_research NOT IN ('Database', 'Networks', 'Operating System') THEN
        RAISE invalid_research;
    ELSIF :old.p_pwd = :new.p_pwd AND :old.p_research = :new.p_research THEN
        RAISE nothing_changed;
    END IF;
EXCEPTION
    WHEN invalid_password THEN
        RAISE_APPLICATION_ERROR(-20002, 'Password should have combinations of characters and numbers.');
    WHEN invalid_research THEN
        RAISE_APPLICATION_ERROR(-20003, 'Please insert research field again.');
    WHEN nothing_changed THEN
        RAISE_APPLICATION_ERROR(-20004, 'New password cannot be the same as the old one.');
END;
/