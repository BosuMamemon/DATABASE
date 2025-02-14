--p.360 14장 무결성 제약조건
--NOT NULL
--UNIQUE
--PRIMARY KEY

--FOREIGN KEY(외래 키)
--  사례 1
--  부서 테이블
CREATE TABLE dept_fk(
        deptno NUMBER(5) CONSTRAINT dept_fk_deptno_pk PRIMARY KEY,
        dname VARCHAR2(20),
        loc VARCHAR2(50)
    );
--  사원 테이블
CREATE TABLE emp_fk(
        empno NUMBER(2) CONSTRAINT emp_fk_empno_pk PRIMARY KEY,
        ename VARCHAR2(20),
        job VARCHAR2(20),
        deptno NUMBER(5)
    );
--  데이터 추가
INSERT INTO dept_fk
VALUES(10, '영업', '부산');
INSERT INTO dept_fk
VALUES(20, '영업2', '부산2');
INSERT INTO emp_fk
VALUES(1, '홍길동', '사원', 10);
INSERT INTO emp_fk
VALUES(2, '이순신', '사원', 30); -- 틀린 건 아니지만, 부서 테이블에 없는 부서번호 30번을 사원 테이블에 삽입하는 게 논리적으로 맞지는 않음
COMMIT;

--사례 2(외래 키 사용)
--부서 테이블
CREATE TABLE dept_fk1(
    deptno NUMBER(5) CONSTRAINT dept_fk1_deptno_pk PRIMARY KEY,
        dname VARCHAR2(20),
        loc VARCHAR2(50)
    );
--사원 테이블
CREATE TABLE emp_fk1(
        empno NUMBER(2) CONSTRAINT emp_fk1_empno_pk PRIMARY KEY,
        ename VARCHAR2(20),
        job VARCHAR2(20),
        deptno NUMBER(5) CONSTRAINT emp_fk1_deptno_fk REFERENCES dept_fk1(deptno)
    );
--데이터 삽입
INSERT INTO dept_fk1
VALUES(10, '영업', '부산');
INSERT INTO dept_fk1
VALUES(20, '영업2', '부산2');
INSERT INTO emp_fk1
VALUES(1, '홍길동', '사원', 10);
INSERT INTO emp_fk1
VALUES(2, '이순신', '사원', 30); --이제 외래 키 제약조건, 즉 참조 무결성에 위배되어 삽입되지 않음
INSERT INTO emp_fk1
VALUES(2, '이순신', '사원', NULL); --단, null값은 들어갈 수 있음
INSERT INTO emp_fk1
VALUES(3, '강감찬', '팀장', 10);
COMMIT;
--1번 사원 삭제
DELETE FROM emp_fk1
WHERE empno = 1;
COMMIT;
--20번 부서 삭제
DELETE FROM dept_fk1
WHERE deptno = 20;
COMMIT;
--10번 부서 삭제
DELETE FROM dept_fk1
WHERE deptno = 10; --외래 키 제약조건, 자식 레코드가 발견되었기 때문에 삭제할 수 없음
--사원 정보 업데이트
UPDATE emp_fk1
SET deptno = 30
WHERE empno = 2; --외래 키 제약조건, 참조 무결성에 위배되어 수정할 수 없음
--외래 키 제약조건 삭제
ALTER TABLE emp_fk1
DROP CONSTRAINT emp_fk1_deptno_fk;
INSERT INTO emp_fk1
VALUES(4, 'aaa', '팀장', 30); --이제 제약조건 오류가 발생하지 않음
COMMIT;
DELETE FROM emp_fk1
WHERE empno = 4;
COMMIT;
--외래 키 제약조건 추가
ALTER TABLE emp_fk1
ADD
    CONSTRAINT emp_fk1_deptno_fk
        FOREIGN KEY(deptno)
        REFERENCES dept_fk1(deptno)
        ON DELETE CASCADE;
--10번 부서 삭제
DELETE FROM dept_fk1
WHERE deptno = 10; --ON DELETE CASCADE: ON DELETE 시(부모 키가 지워졌을 때) 자녀 레코드도 같이 지움으로써 참조 무결성을 지킴
--ON DELETE SET NULL: ON DELETE시 NULL값 부여

ALTER TABLE emp_fk
DROP CONSTRAINT EMP_FK_EMPNO_PK;
ALTER TABLE emp_fk1
DROP CONSTRAINT EMP_FK1_DEPTNO_FK;
ALTER TABLE emp_fk1
DROP CONSTRAINT EMP_FK1_EMPNO_PK;
ALTER TABLE dept_fk
DROP CONSTRAINT DEPT_FK_DEPTNO_PK;
ALTER TABLE dept_fk1
DROP CONSTRAINT DEPT_FK1_DEPTNO_PK;
DROP TABLE dept_fk;
DROP TABLE dept_fk1;
DROP TABLE emp_fk;
DROP TABLE emp_fk1;

=====

--CHECK
CREATE TABLE table_check(
        login_id VARCHAR2(20)
            CONSTRAINT tb_ch_login_id
                PRIMARY KEY,
        login_pw VARCHAR2(20)
            CONSTRAINT tb_ch_login_pw
                CHECK(LENGTH(login_pw) > 5),
        tel VARCHAR2(20)
    );
--데이터 추가
INSERT INTO table_check
VALUES('aa', '1234', '010-1111-2222'); --체크 제약조건 위배
INSERT INTO table_check
VALUES('aa', '123456', '010-1111-2222');
COMMIT;

=====

--문제 1.
CREATE TABLE member(
        userid VARCHAR2(20)
            CONSTRAINT pk_member
                PRIMARY KEY,
        username VARCHAR2(20),
        tel VARCHAR2(20)
    );
--문제 2.
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE
    NOCACHE;
CREATE TABLE board(
        num NUMBER
            DEFAULT board_seq.NEXTVAL
            CONSTRAINT pk_board
                PRIMARY KEY,
        title VARCHAR2(20),
        userid VARCHAR2(20)
            CONSTRAINT fk_board
                REFERENCES member(userid),
        content VARCHAR2(50),
        regdate DATE
            DEFAULT SYSDATE
    );
    
--문제 3.
CREATE SEQUENCE comments_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE
    NOCACHE;
CREATE TABLE comments(
        userid VARCHAR2(20)
            CONSTRAINT fk_comments_userid
                REFERENCES member(userid),
        bnum NUMBER
            CONSTRAINT fk_comments_bnum
                REFERENCES board(num),
        cnum NUMBER
            DEFAULT comments_seq.NEXTVAL
            CONSTRAINT pk_comments
                PRIMARY KEY,
        msg VARCHAR2(50),
        regdate DATE
            DEFAULT SYSDATE
    );
    
--member 추가
INSERT INTO member
VALUES('a1', '홍길동', '010-1111-2222');
--board 추가
INSERT INTO board(title, content, userid)
VALUES('제목 1', '내용 1', 'a1');
COMMIT;
--comments 추가
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '답글 1', 'a1');
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '답글 2', 'a1');
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '답글 3', 'a1');
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '답글 4', 'a1');
COMMIT;

--1번 게시글을 쓴 사람의 이름을 출력
SELECT username
FROM board
    NATURAL JOIN member
WHERE num = 1;

--데이터 추가
--member 추가
INSERT INTO member
VALUES('b1', '이순신', '010-1111-3333');
--board 추가
INSERT INTO board(title, content, userid)
VALUES('제목 2', '내용 2', 'b1');
--comments 추가
INSERT INTO comments(bnum, msg, userid)
VALUES(2, '댓글 1', 'b1');
INSERT INTO comments(bnum, msg, userid)
VALUES(2, '댓글 2', 'b1');
INSERT INTO comments(bnum, msg, userid)
VALUES(2, '댓글 3', 'b1');
COMMIT;

--member별 댓글 수를 출력
SELECT userid, COUNT(*)
FROM comments
GROUP BY userid;

--member별 댓글 수와 해당 member의 이름을 출력
SELECT userid, COUNT(*), username
FROM comments
    NATURAL JOIN member
GROUP BY userid, username;

--member 테이블의 a1 삭제
DELETE FROM member WHERE userid = 'a1'; --자식 레코드 존재로 ON DELETE시 NO ACTION(기본값)발생

=====

--student 테이블과 professor 테이블, 그리고 department 테이블이 서로 관계를 갖도록 제약조건 추가하기
--student 테이블에 외래키 부여
ALTER TABLE student
MODIFY(
        CONSTRAINT fk_student_profno
            FOREIGN KEY(profno)
            REFERENCES professor(profno)
            ON DELETE CASCADE
    );
ALTER TABLE professor
MODIFY(
        CONSTRAINT fk_professor_deptno
            FOREIGN KEY(deptno)
            REFERENCES department(deptno)
            ON DELETE CASCADE
    );

=====

--p.396 15장 사용자, 권한, 롤 관리
--사용자 / 데이터베이스 스키마
--예) scott: 사용자
--scott이 생성한 테이블, 제약조건, 시퀀스 등 데이터베이스에서 만든 모든 객체를 '스키마'라고 부름
--사용자 생성 => 관리자 권한

--p.416 15장 연습문제
--2. scott 계정에서 prev_hw에 emp, dept, salgrade 테이블에 대한 SELECT 권한 부여
--(테이블 자체가 scott꺼기 때문에 scott이 해줘야 함)
GRANT SELECT
ON emp
TO prev_hw;
GRANT SELECT ON dept TO prev_hw;
GRANT SELECT ON salgrade TO prev_hw;

--3. 2번에서 줬던 권한 박탈
REVOKE SELECT ON emp FROM prev_hw;
REVOKE SELECT ON dept FROM prev_hw;
REVOKE SELECT ON salgrade FROM prev_hw;