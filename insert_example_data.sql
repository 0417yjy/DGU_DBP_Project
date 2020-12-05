INSERT INTO FISHY_MEMBER VALUES (1, 'Vapen', 'vapen', '0417yjy@naver.com');
INSERT INTO FISHY_MEMBER VALUES (2, 'Kolibri', 'kolibri', NULL);
INSERT INTO FISHY_MEMBER VALUES (3, 'Dasnil', 'dasnil', NULL);
INSERT INTO FISHY_MEMBER VALUES (4, 'rororol', 'rororol', NULL);
INSERT INTO FISHY_MEMBER VALUES (5, 'beltain', 'beltain', NULL);
INSERT INTO FISHY_MEMBER VALUES (6, 'AAAAAAAA', 'aaaaaaaa', NULL);
INSERT INTO FISHY_MEMBER VALUES (7, 'Merong', 'merong', NULL);
INSERT INTO FISHY_MEMBER VALUES (8, 'Groovy', 'groovy', NULL);
INSERT INTO FISHY_MEMBER VALUES (9, 'pep-e-boi', 'pepeboi', NULL);

INSERT INTO FISHY_CURRENCY VALUES (1, 'KRW', '₩', 1);
INSERT INTO FISHY_CURRENCY VALUES (2, 'USD', '$', 1086);

INSERT INTO FISHY_BANK VALUES (1, 'Newhan Bank');

INSERT INTO FISHY_BANKACCOUNT VALUES (1, '110-123-456789', 1, 1, 1);

INSERT INTO FISHY_GROUP VALUES (1, 'hpom', 2, 1, 'head per one million');
INSERT INTO FISHY_GROUP VALUES (2, 'quarantine', 1, NULL, 'quarantine tarantino');

INSERT INTO FISHY_MEMBERGROUP VALUES (1, 1, NULL, SYSDATE, 7);
INSERT INTO FISHY_MEMBERGROUP VALUES (1, 2, NULL, SYSDATE, 31);
INSERT INTO FISHY_MEMBERGROUP VALUES (2, 1, NULL, SYSDATE, 31);
INSERT INTO FISHY_MEMBERGROUP VALUES (3, 1, NULL, SYSDATE, 1);
INSERT INTO FISHY_MEMBERGROUP VALUES (4, 1, NULL, SYSDATE, 1);
INSERT INTO FISHY_MEMBERGROUP VALUES (5, 1, NULL, SYSDATE, 1);
INSERT INTO FISHY_MEMBERGROUP VALUES (6, 1, NULL, SYSDATE, 1);
INSERT INTO FISHY_MEMBERGROUP VALUES (7, 1, NULL, SYSDATE, 1);
INSERT INTO FISHY_MEMBERGROUP VALUES (8, 1, NULL, SYSDATE, 1);
INSERT INTO FISHY_MEMBERGROUP VALUES (9, 1, NULL, SYSDATE, 1);

INSERT INTO FISHY_TRANSACTION VALUES (1, 5, 1, TO_DATE('20190921', 'YYYYMMDDHH24MISS'), NULL, 'Remaining Dept', 'Requested', 25, 1);
INSERT INTO FISHY_TRANSACTION VALUES (1, 2, 2, TO_DATE('20191120', 'YYYYMMDDHH24MISS'), NULL, 'Remaining Dept', 'Requested', 1, 1);
INSERT INTO FISHY_TRANSACTION VALUES (1, 7, 3, TO_DATE('20201020', 'YYYYMMDDHH24MISS'), NULL, 'Netflix Fee', 'Requested', 100, 1);
INSERT INTO FISHY_TRANSACTION VALUES (1, 4, 4, TO_DATE('20201020', 'YYYYMMDDHH24MISS'), NULL, 'Netflix Fee', 'Requested', 2900, 1);
INSERT INTO FISHY_TRANSACTION VALUES (1, 2, 5, TO_DATE('20201020', 'YYYYMMDDHH24MISS'), NULL, 'Netflix Fee', 'Requested', 2900, 1);
INSERT INTO FISHY_TRANSACTION VALUES (1, 4, 6, TO_DATE('20201120', 'YYYYMMDDHH24MISS'), NULL, 'Netflix Fee', 'Requested', 2900, 1);
INSERT INTO FISHY_TRANSACTION VALUES (1, 2, 7, TO_DATE('20201120', 'YYYYMMDDHH24MISS'), NULL, 'Netflix Fee', 'Requested', 2900, 1);

COMMIT;