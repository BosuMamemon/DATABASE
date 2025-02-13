-- p.291 11장 트랜잭션
-- 트랜잭션: 더 이상 분할할 수 없는 최소 수행단위
-- 한번에 수행하여, 작업을 완료하거나 모두 수행하지 않거나(작업 취소) 둘 중 하나는 되어야 함
-- All or Nothing (COMMIT / ROLLBACK)
-- TCL(Transaction Control Language)

-- 트랜잭션(ACID)
-- A: 원자성(Atomaticity) - 작업의 최소단위임을 의미.
-- C: 일관성(Consistency) - 일관적으로 DB 상태가 유지되어야 하는 것을 얘기함.
-- I: 격리성(Isolation) - 트랜잭션 수행 시 다른 트랜잭션의 작업이 끼어들지 못하도록 보장하는 것을 얘기함.
-- D: 영속성(Durability) - 성공적으로 수행된 트랜잭션은 영원히 반영되는 것을 의미함.

-- p.298 읽기 일관성(Read Consistency)
-- 격리 수준 (서로 다른 세션에서 정보를 조회했을 때 얼마만큼 일관성이 있나)
--  Oracle: Read Commited - 트랜잭션을 하지 않은 상태에서 조회하면 데이터 내용이 달라질 수 있음
--  MySQL: Repeatable Commited - 트랜잭션 범위에서 조회한 데이터 내용은 항상 동일
INSERT INTO test2(no, name)
VALUES(3, '홍길동');

RENAME test2 TO test;

UPDATE test
SET name = '홍길동22'
WHERE no = 3;
COMMIT;

-- p.327 13장 데이터사전(Data Dictionary)
-- ㄴ 데이터베이스를 구성하고 운영하는데 필요한 자원
-- ㄴ 특수한 테이블로 데이터베이스가 생성되는 시점에 자동 생성
--  USER_: 현재 데이터베이스에 접속한 사용자가 소유한 객체 정보
--  ALL_: 사용가능한 모든 객체 정보
--  DBA_: 데이터베이스 관리를 위한 정보(sys, system 사용자만 열람 가능)
--  V$_: 데이터베이스 성능에 관련된 정보
-- 전체 데이터 딕셔너리
SELECT * FROM dictionary;
-- 현재 접속한 계정(scott)이 가지고 있는 모든 테이블 조회
SELECT table_name
FROM user_tables;
-- scott 계정이 가지고 있는 모든 객체 정보 조회
SELECT owner, table_name
FROM all_tables;
-- SELECT * FROM dba_tables; 쿼리문은 관리자 권한 오류 발생

-- p.336 인덱스(Index)
-- 생성
CREATE INDEX idx_emp_sal
ON emp(sal);
-- 삭제
DROP INDEX idx_emp_sal;

-- p.341 뷰(View): 물리적으로 자리를 차지하지는 않는 가상의 테이블(편의성, 보안성)
-- 생성
CREATE VIEW vw_emp20
AS (
    SELECT empno, ename, job, deptno
    FROM emp
    WHERE deptno > 20
    );
SELECT * FROM vw_emp20;
SELECT * FROM user_views;

CREATE OR REPLACE VIEW vw_emp20
AS (
    SELECT empno, ename, job, deptno
    FROM emp
    WHERE deptno > 20
    );
-- emp 테이블 전체 내용을 v_emp1 뷰로 생성
CREATE OR REPLACE VIEW v_emp1
AS (
    SELECT *
    FROM emp
    );
SELECT * FROM user_views;
-- v_emp1 뷰에 (3000, '홍길동', sysdate) 추가
INSERT INTO v_emp1(empno, ename, hiredate)
VALUES(3000, '홍길동', sysdate);
SELECT * FROM v_emp1;
SELECT * FROM emp; -- 가상의 테이블(뷰)에 행을 삽입해도 기본 테이블에 똑같이 행이 삽입됨
-- emp 테이블에서 3000번 삭제
DELETE FROM emp WHERE empno = 3000; -- 기본 테이블에서 행이 삭제되면 뷰에서도 당연히 행이 지워짐
COMMIT;
-- v_emp1 뷰에서 3000번 삭제
DELETE FROM v_emp1 WHERE empno = 3000; -- 가상의 테이블(뷰)에 행을 삭제되면 기본 테이블에서도 똑같이 행이 삽입됨
COMMIT;
-- 즉 뷰에 데이터조작어를 사용하면 기본 테이블에서도 똑같이 적용됨. 따라서 뷰에 데이터조작어를 사용하는건 별로 추천하지 않음
-- 뷰 삭제
DROP VIEW v_emp1;

-- emp 테이블 전체 내용을 v_emp1 뷰로 생성(단, 뷰는 읽기 전용임)
CREATE OR REPLACE VIEW v_emp1
AS (
    SELECT *
    FROM emp
    )
WITH READ ONLY;
--INSERT INTO v_emp1(empno, ename, hiredate)
--VALUES(3000, '홍길동', sysdate); <- 읽기 전용 뷰라서 권한 오류가 생김

====

-- 부서별 최대급여를 받는 사원의 부서번호, 부서명, 급여
-- dept, emp 테이블 이용
SELECT deptno, dname, sal
FROM emp NATURAL JOIN dept
WHERE sal IN (
    SELECT max(sal)
    FROM emp
    GROUP BY deptno
    )
ORDER BY deptno;

-- p.344 인라인 뷰 - SQL문에서 일회성으로 만들어 사용하는 뷰 => 서브쿼리, WITH를 사용
SELECT deptno, dname, sal
FROM (
    SELECT deptno, max(sal) sal
    FROM emp
    GROUP BY deptno
    ) e
        NATURAL JOIN dept
ORDER BY deptno;

-- emp 테이블에서 ename으로 내림차순하여 위에서 3개만 출력
SELECT ROWNUM, emp.* -- 오라클이 갖고있는 ROWNUM이라는 열을 출력할때는 *에 반드시 객체 이름을 찝어줘야함
FROM emp
WHERE ROWNUM <= 3
ORDER BY ename DESC;
-- 위 쿼리문을 인라인 뷰로 다시 쓴다면?
SELECT ROWNUM, e.*
FROM (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    ) e 
WHERE ROWNUM <= 3;

-- ename으로 내림차순하여 위에서 3번째 ~ 5번째 사이를 출력
SELECT *
FROM (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    )
WHERE ROWNUM BETWEEN 3 AND 5; -- 이게 텅 빈 이유: ((ROWNUM = 1) >= 3) = false에서 이미 다음 조건문을 실행을 안하기 때문
SELECT *
FROM (
    SELECT ROWNUM rn, e.*
    FROM (
        SELECT *
        FROM emp
        ORDER BY ename DESC
        ) e 
    ) -- ROWNUM까지를 column으로 포함한 인라인 뷰를 서브쿼리로 입력해줌
WHERE rn BETWEEN 3 AND 5; -- 그러면 이제 조회가 가능함

-- ename으로 내림차순하여 위에서 3개 출력
SELECT *
FROM (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    )
WHERE ROWNUM <= 3;
-- p.259 WITH 사용
-- p.347
WITH e
AS (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    ) -- 서브쿼리를 깔끔하게 위로 빼는 거임
SELECT ROWNUM, e.*
FROM e
WHERE ROWNUM <= 3;


=====
-- p.348 시퀀스
-- 시퀀스(Sequence) 생성
CREATE SEQUENCE dept_seq
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
NOCACHE;
SELECT * FROM user_sequences;
-- 테이블 생성 (dept 테이블의 구조만 이용한 dept_sequence 테이블 생성)
CREATE TABLE dept_sequence
AS
SELECT *
FROM dept
WHERE 0 = 1;
-- 데이터 추가
INSERT INTO dept_sequence(dname, loc)
VALUES('DATABASE', 'SEOUL');
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE2', 'SEOUL2');
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE3', 'SEOUL3');
SELECT dept_seq.NEXTVAL FROM dual; -- 이때 시퀀스값 30이 이미 발생
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE4', 'SEOUL4'); -- 그래서 여기 NEXTVAL은 40이 발생하게 됨
SELECT dept_seq.CURRVAL FROM dual; -- CURRVAL은 당연히 40
DELETE FROM dept_sequence WHERE dname = 'DATABASE';
COMMIT;
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE5', 'SEOUL5');
-- 시퀀스, 테이블 삭제
DROP SEQUENCE dept_seq;
DROP TABLE dept_sequence;

=====

-- 시퀀스 생성: emp_seq / 1에서 시작 / 1씩 증가 / 캐시 없음 / 사이클 없음 / 최소값 1
-- 테이블 생성: emp_temp(num 숫자(3), name 문자열(20), phone 문자열(20), address 문자열(70))
CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE
MINVALUE 1;
CREATE TABLE emp_temp(
    num number(3),
    name varchar2(20),
    phone varchar2(20),
    address varchar2(70)
    );
-- 데이터 삽입: (시퀀스 사용값, 홍길동, 010-1111-2222, 부산)
-- 데이터 삽입: (시퀀스 사용값, 이순신, 010-2222-3333, 부산)
-- 데이터 삽입: (시퀀스 사용값, 강감찬, 010-4444-5555, 서울)
INSERT INTO emp_temp
VALUES(emp_seq.NEXTVAL, '홍길동', '010-1111-2222', '부산');
INSERT INTO emp_temp
VALUES(emp_seq.NEXTVAL, '이순신', '010-2222-3333', '부산');
INSERT INTO emp_temp
VALUES(emp_seq.NEXTVAL, '강감찬', '010-4444-5555', '서울');

-- 시퀀스 변경
ALTER SEQUENCE emp_seq
INCREMENT BY 20
CYCLE;

-- 시퀀스, 테이블 삭제
DROP TABLE emp_temp;
DROP SEQUENCE emp_seq;

=====

-- p.360 14장 무결성 제약 조건
-- NOT NULL: null값 허용 X
CREATE TABLE table_notnull(
        login_id varchar2(20) NOT NULL,
        login_pwd varchar2(20) NOT NULL,
        tel varchar2(20)
    );    
INSERT INTO table_notnull(login_id, login_pwd, tel)
VALUES('aa', '1111', '010-1111-2222');
INSERT INTO table_notnull(login_id, login_pwd, tel)
VALUES('bb', '2222', '010-1111-3333');
INSERT INTO table_notnull(login_id, login_pwd)
VALUES('CC', '3333');
COMMIT;

-- CONSTRAINT: 제약 조건에 이름을 달아줌
CREATE TABLE table_notnull2(
        login_id varchar2(20) CONSTRAINT tbl_nn2_loginID NOT NULL,
        login_pwd varchar2(20) CONSTRAINT tbl_nn2_loginPWD NOT NULL,
        tel varchar2(20)
    );
    
-- 제약조건 확인
SELECT * FROM user_constraints;
SELECT * FROM user_constraints WHERE table_name = 'TABLE_NOTNULL'; -- 테이블 이름은 대문자로 해야함
SELECT owner, constraint_name
FROM user_constraints
WHERE table_name = 'TABLE_NOTNULL2';

-- UNIQUE: 중복값 허용 X
INSERT INTO table_notnull2
VALUES('aa', '1111', '010-1111-2222'); -- n번 해도 n번 다 잘 들어감

-- 제약조건 변경
ALTER TABLE table_notnull2
MODIFY(tel CONSTRAINT tbl_nn2_tel NOT NULL);

INSERT INTO table_notnull2(login_id, login_pwd)
VALUES('cc', '3333'); -- NOT NULL 오류 발생

ALTER TABLE table_notnull2
MODIFY(login_id CONSTRAINT tbl_nn2_uniq_loginID UNIQUE); -- 이미 이 제약조건을 위배하는 데이터가 있다면 제약조건을 적용시킬 수 없음

-- 제약조건 삭제
ALTER TABLE table_notnull2
DROP CONSTRAINT tbl_nn2_nn_tel;

-- 제약조건 이름 변경
ALTER TABLE table_notnull2
RENAME CONSTRAINT tbl_nn2_uniq_loginID TO aaa;
ALTER TABLE table_notnull2
RENAME CONSTRAINT aaa TO tbl_nn2_uniq_loginID;

CREATE TABLE table_unique(
        login_id varchar2(20) CONSTRAINT tbl_uniq_uniq_login_id UNIQUE,
        login_pw varchar2(20) NOT NULL,
        tel varchar2(20)
    );
    
INSERT INTO table_unique
VALUES('aa', '1111', '010-1111-2222');
INSERT INTO table_unique
VALUES('aa', '1111', '010-1111-2222'); -- 무결성 제약조건 위배(login_id 중복)
INSERT INTO table_unique
VALUES(null, '1111', '010-1111-2222'); -- null은 무결성 제약조건 위배 X

-- 테이블 삭제
DROP TABLE table_notnull;
DROP TABLE table_notnull2;
DROP TABLE table_unique; -- 단, 테이블이 지워진다고 제약조건까지 지워지는 것은 아님


-- PRIMARY KEY: 기본 키 제약 조건
CREATE TABLE table_pk(
    login_id varchar2(20) PRIMARY KEY,
    login_pw varchar2(20) NOT NULL,
    tel varchar2(20)
);
INSERT INTO table_pk
VALUES('aa', '1111', '010-1111-2222');
INSERT INTO table_pk
VALUES('aa', '1111', '010-1111-2222'); -- 기본 키(login_id)는 중복될 수 없음 (UNIQUE)
INSERT INTO table_pk
VALUES(null, '1111', '010-1111-2222'); -- 기본 키는 null이 될 수 없음 (NOT NULL)
-- 또한 기본 키는 기본적으로 인덱스가 들어감

DROP TABLE table_pk;

=====

-- 문제 1. 시퀀스 및 테이블 생성
CREATE TABLE board(
        num NUMBER DEFAULT board_seq.NEXTVAL PRIMARY KEY,
        title VARCHAR2(20),
        writer VARCHAR2(20),
        content VARCHAR2(200),
        regdate DATE DEFAULT SYSDATE
    );
CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCYCLE
NOCACHE;

-- 문제 2. 데이터 추가
INSERT INTO board(title, writer, content)
VALUES('board1', '홍길동', '1번 게시글');
INSERT INTO board(title, writer, content)
VALUES('board2', '이순신', '2번 게시글');
INSERT INTO board(title, writer, content)
VALUES('board2', '이순신1', '3번 게시글');
INSERT INTO board(title, writer, content)
VALUES('board2', '이순신2', '4번 게시글');
INSERT INTO board(title, writer, content)
VALUES('board2', '이순신3', '5번 게시글');
INSERT INTO board(title, writer, content)
VALUES('board2', '이순신4', '6번 게시글');
INSERT INTO board(title, writer, content)
VALUES('board2', '이순신5', '7번 게시글');
COMMIT;

-- board 테이블에서 num을 내림차순하여 위에서 5개 출력
SELECT *
FROM board
WHERE ROWNUM <= 5
ORDER BY num DESC;

-- board 테이블에서 num을 내림차순하여 위에서 3번째 ~ 5번째 출력
SELECT *
FROM (
        SELECT ROWNUM rn, board.*
        FROM board
        ORDER BY num DESC
    )
WHERE rn BETWEEN 3 AND 5;

--
CREATE TABLE table_name(
        col1 VARCHAR2(20) CONSTRAINT table_name_col1 PRIMARY KEY,
        col2 VARCHAR2(20) NOT NULL,
        col3 VARCHAR2(20)
    );
CREATE TABLE table_name2(
        col1 VARCHAR(20),
        col2 VARCHAR(20) NOT NULL,
        col3 VARCHAR(20),
        PRIMARY KEY(col1) -- 제약조건을 마지막에 적어줘도 상관없음
    );
CREATE TABLE table_name3(
        col1 VARCHAR(20),
        col2 VARCHAR(20) NOT NULL,
        col3 VARCHAR(20),
        CONSTRAINT table_name3_pk PRIMARY KEY(col1) -- 제약조건 이름까지 마지막에 적어줘도 상관없음
    );
CREATE TABLE table_name4(
        col1 VARCHAR(20),
        col2 VARCHAR(20) NOT NULL,
        col3 VARCHAR(20)
    );
ALTER TABLE table_name4
ADD CONSTRAINT table_name4_pk PRIMARY KEY(col1); -- 일단 테이블 만들고 나중에 ALTER에서 제약조건을 달아도 상관없음


-- FOREIGN KEY: 외래 키 제약 조건

-- CHECK: