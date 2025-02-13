-- p.291 11�� Ʈ�����
-- Ʈ�����: �� �̻� ������ �� ���� �ּ� �������
-- �ѹ��� �����Ͽ�, �۾��� �Ϸ��ϰų� ��� �������� �ʰų�(�۾� ���) �� �� �ϳ��� �Ǿ�� ��
-- All or Nothing (COMMIT / ROLLBACK)
-- TCL(Transaction Control Language)

-- Ʈ�����(ACID)
-- A: ���ڼ�(Atomaticity) - �۾��� �ּҴ������� �ǹ�.
-- C: �ϰ���(Consistency) - �ϰ������� DB ���°� �����Ǿ�� �ϴ� ���� �����.
-- I: �ݸ���(Isolation) - Ʈ����� ���� �� �ٸ� Ʈ������� �۾��� ������� ���ϵ��� �����ϴ� ���� �����.
-- D: ���Ӽ�(Durability) - ���������� ����� Ʈ������� ������ �ݿ��Ǵ� ���� �ǹ���.

-- p.298 �б� �ϰ���(Read Consistency)
-- �ݸ� ���� (���� �ٸ� ���ǿ��� ������ ��ȸ���� �� �󸶸�ŭ �ϰ����� �ֳ�)
--  Oracle: Read Commited - Ʈ������� ���� ���� ���¿��� ��ȸ�ϸ� ������ ������ �޶��� �� ����
--  MySQL: Repeatable Commited - Ʈ����� �������� ��ȸ�� ������ ������ �׻� ����
INSERT INTO test2(no, name)
VALUES(3, 'ȫ�浿');

RENAME test2 TO test;

UPDATE test
SET name = 'ȫ�浿22'
WHERE no = 3;
COMMIT;

-- p.327 13�� �����ͻ���(Data Dictionary)
-- �� �����ͺ��̽��� �����ϰ� ��ϴµ� �ʿ��� �ڿ�
-- �� Ư���� ���̺�� �����ͺ��̽��� �����Ǵ� ������ �ڵ� ����
--  USER_: ���� �����ͺ��̽��� ������ ����ڰ� ������ ��ü ����
--  ALL_: ��밡���� ��� ��ü ����
--  DBA_: �����ͺ��̽� ������ ���� ����(sys, system ����ڸ� ���� ����)
--  V$_: �����ͺ��̽� ���ɿ� ���õ� ����
-- ��ü ������ ��ųʸ�
SELECT * FROM dictionary;
-- ���� ������ ����(scott)�� ������ �ִ� ��� ���̺� ��ȸ
SELECT table_name
FROM user_tables;
-- scott ������ ������ �ִ� ��� ��ü ���� ��ȸ
SELECT owner, table_name
FROM all_tables;
-- SELECT * FROM dba_tables; �������� ������ ���� ���� �߻�

-- p.336 �ε���(Index)
-- ����
CREATE INDEX idx_emp_sal
ON emp(sal);
-- ����
DROP INDEX idx_emp_sal;

-- p.341 ��(View): ���������� �ڸ��� ���������� �ʴ� ������ ���̺�(���Ǽ�, ���ȼ�)
-- ����
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
-- emp ���̺� ��ü ������ v_emp1 ��� ����
CREATE OR REPLACE VIEW v_emp1
AS (
    SELECT *
    FROM emp
    );
SELECT * FROM user_views;
-- v_emp1 �信 (3000, 'ȫ�浿', sysdate) �߰�
INSERT INTO v_emp1(empno, ename, hiredate)
VALUES(3000, 'ȫ�浿', sysdate);
SELECT * FROM v_emp1;
SELECT * FROM emp; -- ������ ���̺�(��)�� ���� �����ص� �⺻ ���̺� �Ȱ��� ���� ���Ե�
-- emp ���̺��� 3000�� ����
DELETE FROM emp WHERE empno = 3000; -- �⺻ ���̺��� ���� �����Ǹ� �信���� �翬�� ���� ������
COMMIT;
-- v_emp1 �信�� 3000�� ����
DELETE FROM v_emp1 WHERE empno = 3000; -- ������ ���̺�(��)�� ���� �����Ǹ� �⺻ ���̺����� �Ȱ��� ���� ���Ե�
COMMIT;
-- �� �信 ���������۾ ����ϸ� �⺻ ���̺����� �Ȱ��� �����. ���� �信 ���������۾ ����ϴ°� ���� ��õ���� ����
-- �� ����
DROP VIEW v_emp1;

-- emp ���̺� ��ü ������ v_emp1 ��� ����(��, ��� �б� ������)
CREATE OR REPLACE VIEW v_emp1
AS (
    SELECT *
    FROM emp
    )
WITH READ ONLY;
--INSERT INTO v_emp1(empno, ename, hiredate)
--VALUES(3000, 'ȫ�浿', sysdate); <- �б� ���� ��� ���� ������ ����

====

-- �μ��� �ִ�޿��� �޴� ����� �μ���ȣ, �μ���, �޿�
-- dept, emp ���̺� �̿�
SELECT deptno, dname, sal
FROM emp NATURAL JOIN dept
WHERE sal IN (
    SELECT max(sal)
    FROM emp
    GROUP BY deptno
    )
ORDER BY deptno;

-- p.344 �ζ��� �� - SQL������ ��ȸ������ ����� ����ϴ� �� => ��������, WITH�� ���
SELECT deptno, dname, sal
FROM (
    SELECT deptno, max(sal) sal
    FROM emp
    GROUP BY deptno
    ) e
        NATURAL JOIN dept
ORDER BY deptno;

-- emp ���̺��� ename���� ���������Ͽ� ������ 3���� ���
SELECT ROWNUM, emp.* -- ����Ŭ�� �����ִ� ROWNUM�̶�� ���� ����Ҷ��� *�� �ݵ�� ��ü �̸��� ��������
FROM emp
WHERE ROWNUM <= 3
ORDER BY ename DESC;
-- �� �������� �ζ��� ��� �ٽ� ���ٸ�?
SELECT ROWNUM, e.*
FROM (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    ) e 
WHERE ROWNUM <= 3;

-- ename���� ���������Ͽ� ������ 3��° ~ 5��° ���̸� ���
SELECT *
FROM (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    )
WHERE ROWNUM BETWEEN 3 AND 5; -- �̰� �� �� ����: ((ROWNUM = 1) >= 3) = false���� �̹� ���� ���ǹ��� ������ ���ϱ� ����
SELECT *
FROM (
    SELECT ROWNUM rn, e.*
    FROM (
        SELECT *
        FROM emp
        ORDER BY ename DESC
        ) e 
    ) -- ROWNUM������ column���� ������ �ζ��� �並 ���������� �Է�����
WHERE rn BETWEEN 3 AND 5; -- �׷��� ���� ��ȸ�� ������

-- ename���� ���������Ͽ� ������ 3�� ���
SELECT *
FROM (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    )
WHERE ROWNUM <= 3;
-- p.259 WITH ���
-- p.347
WITH e
AS (
    SELECT *
    FROM emp
    ORDER BY ename DESC
    ) -- ���������� ����ϰ� ���� ���� ����
SELECT ROWNUM, e.*
FROM e
WHERE ROWNUM <= 3;


=====
-- p.348 ������
-- ������(Sequence) ����
CREATE SEQUENCE dept_seq
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
NOCACHE;
SELECT * FROM user_sequences;
-- ���̺� ���� (dept ���̺��� ������ �̿��� dept_sequence ���̺� ����)
CREATE TABLE dept_sequence
AS
SELECT *
FROM dept
WHERE 0 = 1;
-- ������ �߰�
INSERT INTO dept_sequence(dname, loc)
VALUES('DATABASE', 'SEOUL');
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE2', 'SEOUL2');
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE3', 'SEOUL3');
SELECT dept_seq.NEXTVAL FROM dual; -- �̶� �������� 30�� �̹� �߻�
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE4', 'SEOUL4'); -- �׷��� ���� NEXTVAL�� 40�� �߻��ϰ� ��
SELECT dept_seq.CURRVAL FROM dual; -- CURRVAL�� �翬�� 40
DELETE FROM dept_sequence WHERE dname = 'DATABASE';
COMMIT;
INSERT INTO dept_sequence(deptno, dname, loc)
VALUES(dept_seq.NEXTVAL, 'DATABASE5', 'SEOUL5');
-- ������, ���̺� ����
DROP SEQUENCE dept_seq;
DROP TABLE dept_sequence;

=====

-- ������ ����: emp_seq / 1���� ���� / 1�� ���� / ĳ�� ���� / ����Ŭ ���� / �ּҰ� 1
-- ���̺� ����: emp_temp(num ����(3), name ���ڿ�(20), phone ���ڿ�(20), address ���ڿ�(70))
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
-- ������ ����: (������ ��밪, ȫ�浿, 010-1111-2222, �λ�)
-- ������ ����: (������ ��밪, �̼���, 010-2222-3333, �λ�)
-- ������ ����: (������ ��밪, ������, 010-4444-5555, ����)
INSERT INTO emp_temp
VALUES(emp_seq.NEXTVAL, 'ȫ�浿', '010-1111-2222', '�λ�');
INSERT INTO emp_temp
VALUES(emp_seq.NEXTVAL, '�̼���', '010-2222-3333', '�λ�');
INSERT INTO emp_temp
VALUES(emp_seq.NEXTVAL, '������', '010-4444-5555', '����');

-- ������ ����
ALTER SEQUENCE emp_seq
INCREMENT BY 20
CYCLE;

-- ������, ���̺� ����
DROP TABLE emp_temp;
DROP SEQUENCE emp_seq;

=====

-- p.360 14�� ���Ἲ ���� ����
-- NOT NULL: null�� ��� X
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

-- CONSTRAINT: ���� ���ǿ� �̸��� �޾���
CREATE TABLE table_notnull2(
        login_id varchar2(20) CONSTRAINT tbl_nn2_loginID NOT NULL,
        login_pwd varchar2(20) CONSTRAINT tbl_nn2_loginPWD NOT NULL,
        tel varchar2(20)
    );
    
-- �������� Ȯ��
SELECT * FROM user_constraints;
SELECT * FROM user_constraints WHERE table_name = 'TABLE_NOTNULL'; -- ���̺� �̸��� �빮�ڷ� �ؾ���
SELECT owner, constraint_name
FROM user_constraints
WHERE table_name = 'TABLE_NOTNULL2';

-- UNIQUE: �ߺ��� ��� X
INSERT INTO table_notnull2
VALUES('aa', '1111', '010-1111-2222'); -- n�� �ص� n�� �� �� ��

-- �������� ����
ALTER TABLE table_notnull2
MODIFY(tel CONSTRAINT tbl_nn2_tel NOT NULL);

INSERT INTO table_notnull2(login_id, login_pwd)
VALUES('cc', '3333'); -- NOT NULL ���� �߻�

ALTER TABLE table_notnull2
MODIFY(login_id CONSTRAINT tbl_nn2_uniq_loginID UNIQUE); -- �̹� �� ���������� �����ϴ� �����Ͱ� �ִٸ� ���������� �����ų �� ����

-- �������� ����
ALTER TABLE table_notnull2
DROP CONSTRAINT tbl_nn2_nn_tel;

-- �������� �̸� ����
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
VALUES('aa', '1111', '010-1111-2222'); -- ���Ἲ �������� ����(login_id �ߺ�)
INSERT INTO table_unique
VALUES(null, '1111', '010-1111-2222'); -- null�� ���Ἲ �������� ���� X

-- ���̺� ����
DROP TABLE table_notnull;
DROP TABLE table_notnull2;
DROP TABLE table_unique; -- ��, ���̺��� �������ٰ� �������Ǳ��� �������� ���� �ƴ�


-- PRIMARY KEY: �⺻ Ű ���� ����
CREATE TABLE table_pk(
    login_id varchar2(20) PRIMARY KEY,
    login_pw varchar2(20) NOT NULL,
    tel varchar2(20)
);
INSERT INTO table_pk
VALUES('aa', '1111', '010-1111-2222');
INSERT INTO table_pk
VALUES('aa', '1111', '010-1111-2222'); -- �⺻ Ű(login_id)�� �ߺ��� �� ���� (UNIQUE)
INSERT INTO table_pk
VALUES(null, '1111', '010-1111-2222'); -- �⺻ Ű�� null�� �� �� ���� (NOT NULL)
-- ���� �⺻ Ű�� �⺻������ �ε����� ��

DROP TABLE table_pk;

=====

-- ���� 1. ������ �� ���̺� ����
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

-- ���� 2. ������ �߰�
INSERT INTO board(title, writer, content)
VALUES('board1', 'ȫ�浿', '1�� �Խñ�');
INSERT INTO board(title, writer, content)
VALUES('board2', '�̼���', '2�� �Խñ�');
INSERT INTO board(title, writer, content)
VALUES('board2', '�̼���1', '3�� �Խñ�');
INSERT INTO board(title, writer, content)
VALUES('board2', '�̼���2', '4�� �Խñ�');
INSERT INTO board(title, writer, content)
VALUES('board2', '�̼���3', '5�� �Խñ�');
INSERT INTO board(title, writer, content)
VALUES('board2', '�̼���4', '6�� �Խñ�');
INSERT INTO board(title, writer, content)
VALUES('board2', '�̼���5', '7�� �Խñ�');
COMMIT;

-- board ���̺��� num�� ���������Ͽ� ������ 5�� ���
SELECT *
FROM board
WHERE ROWNUM <= 5
ORDER BY num DESC;

-- board ���̺��� num�� ���������Ͽ� ������ 3��° ~ 5��° ���
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
        PRIMARY KEY(col1) -- ���������� �������� �����൵ �������
    );
CREATE TABLE table_name3(
        col1 VARCHAR(20),
        col2 VARCHAR(20) NOT NULL,
        col3 VARCHAR(20),
        CONSTRAINT table_name3_pk PRIMARY KEY(col1) -- �������� �̸����� �������� �����൵ �������
    );
CREATE TABLE table_name4(
        col1 VARCHAR(20),
        col2 VARCHAR(20) NOT NULL,
        col3 VARCHAR(20)
    );
ALTER TABLE table_name4
ADD CONSTRAINT table_name4_pk PRIMARY KEY(col1); -- �ϴ� ���̺� ����� ���߿� ALTER���� ���������� �޾Ƶ� �������


-- FOREIGN KEY: �ܷ� Ű ���� ����

-- CHECK: