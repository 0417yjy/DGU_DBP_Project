CREATE OR REPLACE PROCEDURE UPDATEGROUP  (
    sGroupID IN VARCHAR2,
    sGroupName IN VARCHAR2,
    sNewAdminID IN VARCHAR2,
    sNewFaID IN VARCHAR2,
    sGroupDesc IN VARCHAR2,
    result OUT VARCHAR2
    )
    IS
    null_at_groupname EXCEPTION;
    duplicated_admin_fa EXCEPTION;

    nGroupID NUMBER;
    nNewAdminID NUMBER;
    nNewFaID NUMBER;
BEGIN
    result := '';

    /* 예외 1: 그룹명에 NULL 값을 입력할 수 없음 */
    IF sGroupName IS NULL THEN
        RAISE null_at_groupname;
    END IF;

    /* 예외 2: 관리자와 총무가 같음 */
    IF sNewAdminID = sNewFaID THEN
        RAISE duplicated_admin_fa;
    END IF;

    /* 정상 작동 */
    /* 먼저 permission level 조정 필요 */
    UPDATE FISHY_MEMBERGROUP SET
    permissionlevel=1
    WHERE groupid=TO_NUMBER(sGroupID) AND permissionlevel > 0;
    COMMIT;

    UPDATE FISHY_GROUP SET
    groupname=sGroupName,
    adminid=TO_NUMBER(sNewAdminID),
    financialagentid=TO_NUMBER(sNewFaID),
    groupdesc=sGroupDesc
    WHERE groupid=TO_NUMBER(sGroupID);
    COMMIT;

    UPDATE FISHY_MEMBERGROUP SET
    permissionlevel=31
    WHERE groupid=TO_NUMBER(sGroupID) AND memberid=TO_NUMBER(sNewAdminID);
    COMMIT;

    UPDATE FISHY_MEMBERGROUP SET
    permissionlevel=7
    WHERE groupid=TO_NUMBER(sGroupID) AND memberid=TO_NUMBER(sNewFaID);
    COMMIT;
    result := 'Group has been updated';
    

    EXCEPTION
    WHEN null_at_groupname THEN 
    result := 'Update Impossible(Reason: Amount is not inserted)';
    WHEN duplicated_admin_fa THEN
    result := 'Update Impossible(Reason: Admin and Financial Agent cannot be the same person)';
    WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
END;
/