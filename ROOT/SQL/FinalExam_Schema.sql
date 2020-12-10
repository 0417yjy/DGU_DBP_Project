/* 실습 테이블 */
/*
학생(student) : 학번, 이름, 주소,학년, Department, 전공, 패스워드
과목(course) : 과목번호, 분반, 과목명, 학점
교수(professor) : 교수번호, 교수이름, 전공, 학과, 패스워드
등록(enroll) : 학번, 과목번호, 분반, 등록시기, 등록학기, 성적
강의(teach) : 교수번호, 과목번호, 분반, 강의시기, 교시, 장소, 수강최대IN원
*/

DROP TABLE student CASCADE CONSTRAINTS;  
DROP TABLE course CASCADE CONSTRAINTS;  
DROP TABLE professor CASCADE CONSTRAINTS;  
DROP TABLE enroll CASCADE CONSTRAINTS;  
DROP TABLE teach CASCADE CONSTRAINTS;  

CREATE TABLE student
(
    s_id	    VARCHAR2(10),
    s_name  VARCHAR2(50)   not null,
    s_addr    VARCHAR2(200),
    s_year     NUMBER(1)   not null,
    s_college    VARCHAR2(50)   not null,
    s_major   VARCHAR2(50)   not null,
    s_pwd       VARCHAR2(10)   not null,
    CONSTRAINT s_pk PRIMARY KEY (s_id)
);


INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011234', 'Kyounghwa Shin','540-2, Gojeong-1-li, Songsan-myeon, Hwaseong-gun, Gyeonggi-do, Republic of Korea', 4, 'IT Department', 'Computer Science Engineering','1234');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011235', 'Yongman Seo','San 24, Nongseo-Li, Kiheung-eup, Yongin-si, Gyeonggi-do, Republic of Korea', 4, 'IT Department', 'Computer Science Engineering','1235');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011236', 'Chuyoung Jeong','Kkachimaeul, 79 beonji, Gumi-dong, Bundang-gu, Seongnam-si, Gyeonggi-do, Republic of Korea', 4, 'IT Department', 'Computer Science Engineering','1236');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20011237', 'Jeonghwan Ko','416 beonji, Maetan 3-dong, Paldal-gu, Suwon-si, Gyeonggi-do, Republic of Korea', 4, 'IT Department', 'Computer Science Engineering','1237');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021245', 'Yongho Jeon','1234-5 beonji, Yongsang-dong, Andong-si, Gyeongsangbuk-do, Republic of Korea', 3, 'IT Department', 'Computer Science Engineering','3123');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021246', 'Sindong Han','81, Susong-dong, Jongno-gu, Seoul, Republic of Korea', 3, 'IT Department', 'Computer Science Engineering','3124');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20021247', 'Hohyeon Noh','183-2, Sadang 3-dong, Dongjak-gu, Seoul, Republic of Korea', 3, 'IT Department', 'Computer Science Engineering','3125');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20023451', 'Youngcheol Kim','101-6, Hoegi-dong, Dongdaemun-gu, Seoul, Republic of Korea', 3, 'IT Department', 'Multimedia Engineering','3451');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20012454', 'Taewung Jeong','80-3, Garak-dong, Songpa-gu, Seoul, Republic of Korea', 4, 'IT Department', 'Multimedia Engineering','3454');
INSERT INTO student (s_id, s_name, s_addr, s_year, s_college, s_major, s_pwd) VALUES
('20012456', 'Jinyoung Jeong','400-5, Galsan 2-dong, Bupyeong-gu, Incheon-si, Republic of Korea', 4, 'IT Department', 'Multimedia Engineering','3456');

CREATE TABLE course
(
    c_id   	VARCHAR2(10),
    c_id_no  NUMBER(1),
    c_name  VARCHAR2(50),
    c_unit     NUMBER(1),
    CONSTRAINT c_pk PRIMARY KEY (c_id, c_id_no)
);

INSERT INTO course VALUES ('C100', 1, 'Computer Programming', 3) ;
INSERT INTO course VALUES ('C200', 1, 'Data Structure', 3) ;
INSERT INTO course VALUES ('C300', 1, 'Algorithms', 3) ;
INSERT INTO course VALUES ('C400', 1, 'Database Systems', 3) ;
INSERT INTO course VALUES ('C500', 1, 'Operating System', 3) ;
INSERT INTO course VALUES ('C600', 1, 'Software Engineering', 3) ;
INSERT INTO course VALUES ('C700', 1, 'Networks', 3) ;
INSERT INTO course VALUES ('C800', 1, 'Database Programming', 3) ;
INSERT INTO course VALUES ('C900', 1, 'Object-Oriented Windows Programming', 3) ;
INSERT INTO course VALUES ('M100', 1, 'Introduction To Multimedia', 3) ;
INSERT INTO course VALUES ('M200', 1, 'Linear Algebra', 3) ;
INSERT INTO course VALUES ('M300', 1, 'Graphics Application', 3) ;
INSERT INTO course VALUES ('M400', 1, 'Windows Programming', 3) ;
INSERT INTO course VALUES ('M500', 1, 'Computer Graphics', 3) ;
INSERT INTO course VALUES ('M600', 1, 'Multimedia Processing', 3) ;
INSERT INTO course VALUES ('M700', 1, 'Game Programming', 3) ;
INSERT INTO course VALUES ('C100', 2, 'Computer Programming', 3) ;
INSERT INTO course VALUES ('C400', 2, 'Database Systems', 3) ;
INSERT INTO course VALUES ('C700', 2, 'Networks', 3) ;
INSERT INTO course VALUES ('C900', 2, 'Object-Oriented Windows Programming', 3) ;
INSERT INTO course VALUES ('M100', 2, 'Introduction To Multimedia', 3) ;
INSERT INTO course VALUES ('M400', 2, 'Windows Programming', 3) ;
INSERT INTO course VALUES ('M700', 2, 'Game Programming', 3) ;



CREATE TABLE professor
(
    p_id	       VARCHAR2(10),
    p_name      VARCHAR2(50)   not null,
    p_college    VARCHAR2(50)   not null,
    p_major      VARCHAR2(50)   not null,
    p_pwd         VARCHAR2(10)   not null,
    CONSTRAINT p_pk PRIMARY KEY (p_id)
);

INSERT INTO professor VALUES ('CS4580', 'Gugon Park', 'IT Department', 'Computer Science Engineering','4580');
INSERT INTO professor VALUES ('CS4581', 'Gildong Hong', 'IT Department', 'Computer Science Engineering','4581');
INSERT INTO professor VALUES ('CS4582', 'Eunseon Lee', 'IT Department', 'Computer Science Engineering','4582');
INSERT INTO professor VALUES ('CS4583', 'Euihong Seo', 'IT Department', 'Computer Science Engineering','4583');
INSERT INTO professor VALUES ('CS4584', 'Simseon Kim', 'IT Department', 'Computer Science Engineering','4584');
INSERT INTO professor VALUES ('CS4585', 'Jiyong Jeon', 'IT Department', 'Computer Science Engineering','4585');
INSERT INTO professor VALUES ('MM4570', 'Jeongmi Kim', 'IT Department', 'Multimedia Engineering','4570');
INSERT INTO professor VALUES ('MM4571', 'Kiwung Shin', 'IT Department', 'Multimedia Engineering','4571');
INSERT INTO professor VALUES ('MM4572', 'Sangheon Lee', 'IT Department', 'Multimedia Engineering','4572');

ALTER TABLE professor ADD p_research VARCHAR2(100);


CREATE TABLE enroll
(
    s_id	     VARCHAR2(10),
    c_id	     VARCHAR2(10),
    c_id_no    NUMBER(1),
    e_year      NUMBER(4),
    e_semester    NUMBER(1),
    e_score    NUMBER(3),
    CONSTRAINT e_pk PRIMARY KEY (s_id, c_id, c_id_no),
    CONSTRAINT e_c_id_fk FOREIGN KEY (c_id, c_id_no) REFERENCES  course (c_id, c_id_no)
);

INSERT INTO enroll VALUES ( '20011234', 'C100', 1, 2021, 1, 60);
INSERT INTO enroll VALUES ( '20011234', 'C200', 1, 2021, 1, 57);
INSERT INTO enroll VALUES ( '20011234', 'C300', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C400', 1, 2021, 1, 85);
INSERT INTO enroll VALUES ( '20011234', 'C500', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011234', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011234', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C100', 1, 2020, 2, 76);
INSERT INTO enroll VALUES ( '20011235', 'C200', 1, 2021, 1, 78);
INSERT INTO enroll VALUES ( '20011235', 'C300', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C400', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011235', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011236', 'C100', 1, 2020, 2, 67);
INSERT INTO enroll VALUES ( '20011236', 'C200', 1, 2021, 1, 95);
INSERT INTO enroll VALUES ( '20011236', 'C300', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C400', 1, 2021, 1, 95);
INSERT INTO enroll VALUES ( '20011236', 'C500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011236', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20011237', 'C100', 1, 2020, 2, 45);
INSERT INTO enroll VALUES ( '20011237', 'C200', 1, 2021, 1, 68);
INSERT INTO enroll VALUES ( '20011237', 'C300', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C400', 1, 2021, 1, 88);
INSERT INTO enroll VALUES ( '20011237', 'C500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C600', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C700', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011237', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20021245', 'C100', 1, 2020, 2, 75);
INSERT INTO enroll VALUES ( '20021245', 'C200', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011245', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20021246', 'C100', 1, 2020, 2, 91);
INSERT INTO enroll VALUES ( '20021246', 'C200', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20011246', 'C900', 1, 2021, 1, null);
INSERT INTO enroll VALUES ( '20021247', 'C100', 1, 2020, 2, 87);
INSERT INTO enroll VALUES ( '20021247', 'C200', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20012454', 'C100', 1, 2020, 2, 67);
INSERT INTO enroll VALUES ( '20012454', 'M100', 1, 2020, 2, 57);
INSERT INTO enroll VALUES ( '20012454', 'M200', 1, 2021, 1, 71);
INSERT INTO enroll VALUES ( '20012454', 'M300', 1, 2021, 1, 83);
INSERT INTO enroll VALUES ( '20012454', 'M400', 1, 2021, 1, 89);
INSERT INTO enroll VALUES ( '20012454', 'M500', 1, 2020, 2, null);
INSERT INTO enroll VALUES ( '20012456', 'C100', 1, 2020, 2, 96);
INSERT INTO enroll VALUES ( '20012456', 'C200', 1, 2021, 1, 87);
INSERT INTO enroll VALUES ( '20012456', 'M100', 1, 2020, 2, 63);
INSERT INTO enroll VALUES ( '20012456', 'M200', 1, 2021, 1, 68);
INSERT INTO enroll VALUES ( '20012456', 'M300', 1, 2021, 1, 98);
INSERT INTO enroll VALUES ( '20012456', 'M400', 1, 2021, 1, 85);
INSERT INTO enroll VALUES ( '20012456', 'M500', 1, 2020, 2, null);

ALTER TABLE enroll ADD e_grade VARCHAR2(5);

CREATE TABLE teach
(
    p_id	   VARCHAR2(10),
    c_id	   VARCHAR2(10),
    c_id_no  NUMBER(1),
    t_year    NUMBER(4),
    t_semester    NUMBER(1),
    t_time    NUMBER(1),
    t_where  VARCHAR2(50),
    t_max    NUMBER(2),
    CONSTRAINT t_pk PRIMARY KEY (p_id, c_id, c_id_no,t_year,t_semester ),
    CONSTRAINT t_c_id_fk FOREIGN KEY (c_id, c_id_no) REFERENCES  course (c_id, c_id_no)
 );

INSERT INTO teach VALUES ( 'CS4580', 'C100', 1 , 2021, 1, 4, 'IN-201', 5);
INSERT INTO teach VALUES ( 'CS4581', 'C200', 1 , 2021, 1, 5, 'IN-201', 6);
INSERT INTO teach VALUES ( 'CS4581', 'C200', 1 , 2020, 2, 5, 'IN-201', 5);
INSERT INTO teach VALUES ( 'CS4581', 'C300', 1 , 2021, 1, 2, 'IN-416', 7);
INSERT INTO teach VALUES ( 'CS4582', 'C400', 1 , 2021, 1, 6, 'IN-201', 5);
INSERT INTO teach VALUES ( 'CS4582', 'C400', 1 , 2020, 2, 6, 'IN-201', 7);
INSERT INTO teach VALUES ( 'CS4583', 'C500', 1 , 2021, 1, 3, 'IN-201', 5);
INSERT INTO teach VALUES ( 'CS4583', 'C700', 1 , 2020, 2, 4, 'IN-310', 7);
INSERT INTO teach VALUES ( 'CS4584', 'C600', 1 , 2020, 2, 1, 'IN-309', 6);
INSERT INTO teach VALUES ( 'CS4584', 'C800', 1 , 2021, 1, 7, 'IN-309', 5);
INSERT INTO teach VALUES ( 'MM4570', 'M100', 1 , 2021, 1, 5, 'SW-201', 8);
INSERT INTO teach VALUES ( 'MM4570', 'M400', 1 , 2021, 1, 5, 'SW-201', 5);
INSERT INTO teach VALUES ( 'MM4571', 'M200', 1 , 2021, 1, 3, 'SW-417', 7);
INSERT INTO teach VALUES ( 'MM4571', 'M200', 1 , 2020, 2, 3, 'SW-417', 8);
INSERT INTO teach VALUES ( 'MM4571', 'M500', 1 , 2020, 2, 6, 'SW-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'M300', 1 , 2021, 1, 3, 'SW-201', 9);
INSERT INTO teach VALUES ( 'MM4572', 'M300', 1 , 2020, 2, 3, 'SW-201', 6);
INSERT INTO teach VALUES ( 'MM4572', 'C900', 1 , 2021, 1, 2, 'SW-201', 5);
INSERT INTO teach VALUES ( 'MM4572', 'M700', 1 , 2021, 1, 8, 'SW-201', 8);

COMMIT;