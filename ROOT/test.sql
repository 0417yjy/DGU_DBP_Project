CREATE OR REPLACE PROCEDURE test(v_s_id IN VARCHAR2, result OUT VARCHAR2)
IS
    CURSOR cur (student_id VARCHAR2)
    IS
    SELECT *
    FROM student
    WHERE s_id = student_id;
BEGIN
    FOR cur_rec IN cur(v_s_id)
    LOOP
        BEGIN
        result := cur_rec.s_name;
        EXCEPTION
            WHEN OTHERS THEN   
                result := SQLERRM;
        END;
    END LOOP;
    EXCEPTION
        WHEN no_data_found THEN
            result := SQLERRM;
        WHEN OTHERS THEN
            result := SQLERRM;
END;
/