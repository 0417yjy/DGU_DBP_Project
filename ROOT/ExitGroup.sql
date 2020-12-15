CREATE OR REPLACE PROCEDURE EXITGROUP  (
    sMemberID IN VARCHAR2,
    sGroupID IN VARCHAR2,
    result OUT VARCHAR2
    )
    IS
    nMemberID NUMBER;
    nGroupID NUMBER;
    nAdminID NUMBER;
    nFaID NUMBER;
    nPermission NUMBER;
BEGIN
    result := '';
    /* ID들은 NUMBER로 변환 */
    nMemberID := TO_NUMBER(sMemberID);
    nGroupID := TO_NUMBER(sGroupID);

    /* 해당 그룹의 관리자, 총무 ID를 먼저 저장 */
    SELECT ADMINID, FINANCIALAGENTID
    INTO nAdminID, nFaID
    FROM FISHY_GROUP
    WHERE GROUPID=nGroupID;


    /* 일반 회원 / 참여 대기중인 경우, 그냥 삭제 */
    /* 퍼미션 계산 */
    SELECT PERMISSIONLEVEL
    INTO nPermission
    FROM FISHY_MEMBERGROUP
    WHERE GROUPID=nGroupID AND MEMBERID=nMemberID;


    IF nPermission <= 1 THEN
        DELETE FROM FISHY_MEMBERGROUP
        WHERE GROUPID=nGroupID AND MEMBERID=nMemberID;
        COMMIT;
    END IF;

    /* 총무인 경우, 삭제와 함께 총무를 공석으로 지정 */
    IF nMemberID = nFaID THEN
        UPDATE FISHY_GROUP
        SET FINANCIALAGENTID=NULL
        WHERE GROUPID=nGroupID;

        DELETE FROM FISHY_MEMBERGROUP
        WHERE GROUPID=nGroupID AND MEMBERID=nMemberID;
        COMMIT;
    END IF;
    result := 'Exit complete.';

    /* 관리자인 경우, 그룹 전체를 삭제 */
    IF nMemberID = nAdminID THEN
        DELETE FROM FISHY_GROUP
        WHERE GROUPID=nGroupID;
        COMMIT;
        result := 'Your group has been deleted.';
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/