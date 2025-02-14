--p.360 14�� ���Ἲ ��������
--NOT NULL
--UNIQUE
--PRIMARY KEY

--FOREIGN KEY(�ܷ� Ű)
--  ��� 1
--  �μ� ���̺�
CREATE TABLE dept_fk(
        deptno NUMBER(5) CONSTRAINT dept_fk_deptno_pk PRIMARY KEY,
        dname VARCHAR2(20),
        loc VARCHAR2(50)
    );
--  ��� ���̺�
CREATE TABLE emp_fk(
        empno NUMBER(2) CONSTRAINT emp_fk_empno_pk PRIMARY KEY,
        ename VARCHAR2(20),
        job VARCHAR2(20),
        deptno NUMBER(5)
    );
--  ������ �߰�
INSERT INTO dept_fk
VALUES(10, '����', '�λ�');
INSERT INTO dept_fk
VALUES(20, '����2', '�λ�2');
INSERT INTO emp_fk
VALUES(1, 'ȫ�浿', '���', 10);
INSERT INTO emp_fk
VALUES(2, '�̼���', '���', 30); -- Ʋ�� �� �ƴ�����, �μ� ���̺� ���� �μ���ȣ 30���� ��� ���̺� �����ϴ� �� �������� ������ ����
COMMIT;

--��� 2(�ܷ� Ű ���)
--�μ� ���̺�
CREATE TABLE dept_fk1(
    deptno NUMBER(5) CONSTRAINT dept_fk1_deptno_pk PRIMARY KEY,
        dname VARCHAR2(20),
        loc VARCHAR2(50)
    );
--��� ���̺�
CREATE TABLE emp_fk1(
        empno NUMBER(2) CONSTRAINT emp_fk1_empno_pk PRIMARY KEY,
        ename VARCHAR2(20),
        job VARCHAR2(20),
        deptno NUMBER(5) CONSTRAINT emp_fk1_deptno_fk REFERENCES dept_fk1(deptno)
    );
--������ ����
INSERT INTO dept_fk1
VALUES(10, '����', '�λ�');
INSERT INTO dept_fk1
VALUES(20, '����2', '�λ�2');
INSERT INTO emp_fk1
VALUES(1, 'ȫ�浿', '���', 10);
INSERT INTO emp_fk1
VALUES(2, '�̼���', '���', 30); --���� �ܷ� Ű ��������, �� ���� ���Ἲ�� ����Ǿ� ���Ե��� ����
INSERT INTO emp_fk1
VALUES(2, '�̼���', '���', NULL); --��, null���� �� �� ����
INSERT INTO emp_fk1
VALUES(3, '������', '����', 10);
COMMIT;
--1�� ��� ����
DELETE FROM emp_fk1
WHERE empno = 1;
COMMIT;
--20�� �μ� ����
DELETE FROM dept_fk1
WHERE deptno = 20;
COMMIT;
--10�� �μ� ����
DELETE FROM dept_fk1
WHERE deptno = 10; --�ܷ� Ű ��������, �ڽ� ���ڵ尡 �߰ߵǾ��� ������ ������ �� ����
--��� ���� ������Ʈ
UPDATE emp_fk1
SET deptno = 30
WHERE empno = 2; --�ܷ� Ű ��������, ���� ���Ἲ�� ����Ǿ� ������ �� ����
--�ܷ� Ű �������� ����
ALTER TABLE emp_fk1
DROP CONSTRAINT emp_fk1_deptno_fk;
INSERT INTO emp_fk1
VALUES(4, 'aaa', '����', 30); --���� �������� ������ �߻����� ����
COMMIT;
DELETE FROM emp_fk1
WHERE empno = 4;
COMMIT;
--�ܷ� Ű �������� �߰�
ALTER TABLE emp_fk1
ADD
    CONSTRAINT emp_fk1_deptno_fk
        FOREIGN KEY(deptno)
        REFERENCES dept_fk1(deptno)
        ON DELETE CASCADE;
--10�� �μ� ����
DELETE FROM dept_fk1
WHERE deptno = 10; --ON DELETE CASCADE: ON DELETE ��(�θ� Ű�� �������� ��) �ڳ� ���ڵ嵵 ���� �������ν� ���� ���Ἲ�� ��Ŵ
--ON DELETE SET NULL: ON DELETE�� NULL�� �ο�

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
--������ �߰�
INSERT INTO table_check
VALUES('aa', '1234', '010-1111-2222'); --üũ �������� ����
INSERT INTO table_check
VALUES('aa', '123456', '010-1111-2222');
COMMIT;

=====

--���� 1.
CREATE TABLE member(
        userid VARCHAR2(20)
            CONSTRAINT pk_member
                PRIMARY KEY,
        username VARCHAR2(20),
        tel VARCHAR2(20)
    );
--���� 2.
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
    
--���� 3.
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
    
--member �߰�
INSERT INTO member
VALUES('a1', 'ȫ�浿', '010-1111-2222');
--board �߰�
INSERT INTO board(title, content, userid)
VALUES('���� 1', '���� 1', 'a1');
COMMIT;
--comments �߰�
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '��� 1', 'a1');
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '��� 2', 'a1');
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '��� 3', 'a1');
INSERT INTO comments(bnum, msg, userid)
VALUES(1, '��� 4', 'a1');
COMMIT;

--1�� �Խñ��� �� ����� �̸��� ���
SELECT username
FROM board
    NATURAL JOIN member
WHERE num = 1;

--������ �߰�
--member �߰�
INSERT INTO member
VALUES('b1', '�̼���', '010-1111-3333');
--board �߰�
INSERT INTO board(title, content, userid)
VALUES('���� 2', '���� 2', 'b1');
--comments �߰�
INSERT INTO comments(bnum, msg, userid)
VALUES(2, '��� 1', 'b1');
INSERT INTO comments(bnum, msg, userid)
VALUES(2, '��� 2', 'b1');
INSERT INTO comments(bnum, msg, userid)
VALUES(2, '��� 3', 'b1');
COMMIT;

--member�� ��� ���� ���
SELECT userid, COUNT(*)
FROM comments
GROUP BY userid;

--member�� ��� ���� �ش� member�� �̸��� ���
SELECT userid, COUNT(*), username
FROM comments
    NATURAL JOIN member
GROUP BY userid, username;

--member ���̺��� a1 ����
DELETE FROM member WHERE userid = 'a1'; --�ڽ� ���ڵ� ����� ON DELETE�� NO ACTION(�⺻��)�߻�

=====

--student ���̺�� professor ���̺�, �׸��� department ���̺��� ���� ���踦 ������ �������� �߰��ϱ�
--student ���̺� �ܷ�Ű �ο�
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

--p.396 15�� �����, ����, �� ����
--����� / �����ͺ��̽� ��Ű��
--��) scott: �����
--scott�� ������ ���̺�, ��������, ������ �� �����ͺ��̽����� ���� ��� ��ü�� '��Ű��'��� �θ�
--����� ���� => ������ ����

--p.416 15�� ��������
--2. scott �������� prev_hw�� emp, dept, salgrade ���̺� ���� SELECT ���� �ο�
--(���̺� ��ü�� scott���� ������ scott�� ����� ��)
GRANT SELECT
ON emp
TO prev_hw;
GRANT SELECT ON dept TO prev_hw;
GRANT SELECT ON salgrade TO prev_hw;

--3. 2������ ��� ���� ��Ż
REVOKE SELECT ON emp FROM prev_hw;
REVOKE SELECT ON dept FROM prev_hw;
REVOKE SELECT ON salgrade FROM prev_hw;