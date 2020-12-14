CREATE OR REPLACE PROCEDURE INSERTTRANSACTION  (
    sToWhom IN VARCHAR2,
    sFromWho IN VARCHAR2,
    sAriseDate IN VARCHAR2,
    sDueDate IN VARCHAR2,
    sDescription IN VARCHAR2,
    sAmount IN VARCHAR2,
    sCurrencyID IN VARCHAR2,
    sGroupID IN VARCHAR2,
    result OUT VARCHAR2
    )
    IS
    null_inserted EXCEPTION;
    space_included EXCEPTION;
    not_number_detected EXCEPTION;
    range_exception EXCEPTION;

    nBlank NUMBER;
    nAmount NUMBER;
    dAriseDate DATE;
    dDueDate DATE;
    nCurrentMaxTxid NUMBER;
BEGIN
    result := '';

    /* 예외 1: NULL 값을 입력할 수 없음 */
    IF sAmount IS NULL THEN
        RAISE null_inserted;
    END IF;

    /* 예외 2: 공백값을 입력할 수 없음 */
    SELECT instr(sAmount, ' ')
    INTO nBlank
    FROM DUAL;
    IF(nBlank > 0) THEN
        RAISE space_included;
    END IF;

    /* 예외 3: 숫자 외 다른 문자가 포함됨 */
    IF NOT REGEXP_LIKE(sAmount, '^[[:digit:]]+$') THEN
        RAISE not_number_detected;
    END IF;

    /* 예외 4: 양수만 입력할 수 있음 */
    nAmount := TO_NUMBER(sAmount);
    IF nAmount <= 0 THEN
        RAISE range_exception;
    END IF;

    /* 정상 작동 */
    /* 다음 트랜잭션 ID 구하기 */
    SELECT MAX(TRANSACTIONID) INTO nCurrentMaxTxid FROM FISHY_TRANSACTION;

    /* DATE 변환 */
    dAriseDate := TO_DATE(sAriseDate, 'YYYY-MM-DD');
    dDueDate := TO_DATE(sDueDate, 'YYYY-MM-DD');


    INSERT INTO FISHY_TRANSACTION VALUES 
    (TO_NUMBER(sToWhom), 
    TO_NUMBER(sFromWho), 
    nCurrentMaxTxid + 1, 
    dAriseDate, dDueDate, 
    sDescription, 
    'Requested', 
    nAmount, 
    TO_NUMBER(sCurrencyID),
    TO_NUMBER(sGroupID));
    COMMIT;
    result := 'New transaction is added';

    EXCEPTION
    WHEN null_inserted THEN 
    result := 'Adding Impossible(Reason: Amount is not inserted)';
    WHEN space_included THEN
    result := 'Adding Impossible(Reason: You cannot insert space into amount)';
    WHEN not_number_detected THEN
    result := 'Adding Impossible(Reason: You cannot insert other character into amount)';
    WHEN range_exception THEN
    result := 'Adding Impossible(Reason: Amount should be from 0 to 100)';
    WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/