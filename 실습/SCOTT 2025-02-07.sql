-- p.215(������ ��������)
-- IN, OR, ANY, EXIST
SELECT ename, sal, job
FROM emp
WHERE job = 'SALESMAN';
-- IN() <- �Է��� �μ��� ��� ����
SELECT ename, sal
FROM emp
WHERE sal IN (1600, 1250, 1500);
-- ANY() <- �μ��� ���� �� �ϳ��� ����
SELECT ename, sal
FROM emp
WHERE sal < ANY (1600, 1250, 1500);
SELECT ename, sal
FROM emp
WHERE
    sal < ANY (
        SELECT sal
        FROM emp
        WHERE job = 'SALESMAN'
        );
-- ALL() <- �μ��� ������ ��� ����
SELECT ename, sal
FROM emp
WHERE
    sal < ALL (
        SELECT sal
        FROM emp
        WHERE job = 'SALESMAN'
        );
        
-- emp ���̺�
-- 30�� �μ��� �ִ�޿����� ���� �޿��� �޴� ��� ���
-- (ANY, ALL) ���
SELECT *
FROM emp
WHERE
    sal < ANY(
        SELECT sal
        FROM emp
        WHERE deptno = 30
        );

-- 30�� �μ��� �ִ�޿����� ���� �޿��� �޴� ��� ���
-- (ANY, ALL) ���
SELECT *
FROM emp
WHERE
    sal > ALL(
        SELECT sal
        FROM emp
        WHERE deptno = 30
        );
-- EXISTS() <- �� ���� �����ϳ� ���ϳ� boolean
-- �Ʒ��� EXISTS()�� true�� �� SELECT�� ��� ���
SELECT *
FROM dept
WHERE
    EXISTS(
        SELECT deptno
        FROM dept
        WHERE deptno = 20);
-- �Ʒ��� EXISTS()�� false�� SELECT �� ���
SELECT *
FROM dept
WHERE
    EXISTS(
        SELECT deptno
        FROM dept
        WHERE deptno = 50);
        
-------------------------------------------------
-- p.266
-- DML(Data Manipulation Language)
-- �� ������ ���۾�: �����͸� �߰�, ����, ����
-- DDL(Data Definition Language)
-- �� ������ ���Ǿ�: ��ü�� ����, ����, ����
-- DCL

-- test1(no, name, address, tel) ���̺� ����
-- ����: create table ���̺��(�÷� ����)
-- ����(����): no ����(5), name ���ڿ�(10), address ���ڿ�(50), tel ���ڿ�(20)
-- �� ��ȣ ���� �뷮��
CREATE TABLE test1(
    no number(5),
    name varchar2(10),
    address varchar2(50),
    tel varchar2(20)
);
-- test1 ���̺� ������ �߰�
-- ����: INSERT INTO ���̺��(�÷�) VALUES(��)
INSERT INTO test1(no, name)
VALUES(1, 'aaa');
INSERT INTO test1(no, name, address, tel)
VALUES(2, 'bbb', '�λ�', '010-1111-2222');
INSERT INTO test1(no, name, address, tel)
VALUES(3, 'ccc', '����', '010-3333-4444');
-- ��� �÷��� �����͸� �����Ҷ� �÷��� ���� ����
INSERT INTO test1
VALUES(4, 'ddd', '�뱸', '010-5555-6666');
INSERT INTO test1(no, name, address)
VALUES(5, 'eee', '����');
-- Ŀ��
COMMIT;

-- �ѹ�(Ŀ�� �������ױ��� �ѹ� ����)
INSERT INTO test1(no, name, tel)
VALUES(6, 'ffff', '010-6666-7777');
ROLLBACK;

-- test1 ���̺� no�� 2������ ���
SELECT *
FROM test1
WHERE no = 2;

-- ���� ==> no = 2�� ����� �̸��� ȫ�浿���� ����
UPDATE test1
SET name = 'ȫ�浿'
WHERE no = 2;
COMMIT;

UPDATE test1
SET
    name = '�̼���', address = '����'
WHERE no = 4;
COMMIT;

-- ����
DELETE test1 WHERE no = 3;
ROLLBACK;

DELETE test1 WHERE no = 3;
INSERT INTO test1
VALUES(3, 'ccc', '����', '010-1236-4567');
COMMIT;

-- test2���̺� ���� (��ü Ŀ���� ��)
CREATE TABLE test2(
    no number(4) default 0,
    name varchar2(20) default 'NONAME',
    hiredate date default sysdate
    );

-- test2 ���̺� (1, ȫ�浿) �߰�
INSERT INTO test2(no, name)
VALUES(1, 'ȫ�浿');
-- test2 ���̺� 25/2/6 �߰�
INSERT INTO test2(hiredate)
VALUES('25/02/06');
-- test2 ���̺��� no�� 1���� ����� �̸��� '������'���� ����
UPDATE test2
SET name = '������'
WHERE no = 1;
-- test2 ���̺��� no = 0�� ����
DELETE test2
WHERE no = 0;
-- test2 ���̺��� no = 2 �߰�
INSERT INTO test2(no)
VALUES(2);

COMMIT;

-- CRUD �۾�
-- C: CREATE TABLE table(column type())
-- R: INSERT INTO table(column) VALUES(value)
-- U: UPDATE FROM table SET column = value WHERE
-- D: DELETE FROM table WHERE

-- p.266(CTAS: CREATE TABLE AS SELECT)
-- dept_temp ���̺� ���� ��, dept ���̺� �״��
CREATE TABLE dept_temp
AS
SELECT *
FROM dept;
-- dept_temp ���̺� 50, DATABASE, SEOUL �߰�
DESC dept_temp;
INSERT INTO
    dept_temp(deptno, dname, loc)
VALUES(50, 'DATABASE', 'SEOUL');

-- ���̺� ������ ����
CREATE TABLE emp_temp
AS
SELECT *
FROM emp
WHERE 1 != 1; // WHERE���� false�� �ǵ��� ������ �ϸ� ���̺� ������ ���� ����

-- emp_temp: empno, ename, job, mgr, hiredate, sal, comm, deptno
INSERT INTO emp_temp
VALUES(2111, '�̼���', 'MANAGER', 9999, TO_DATE('07/01/2019', 'dd/mm/yyyy'), 4000, null, 20);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES(2111, '�̼���2', 'MANAGER', 9999, TO_DATE('07/01/2019', 'dd/mm/yyyy'), 4000, 20);
INSERT INTO emp_temp
VALUES(3111, '������', 'MANAGER', 9999, sysdate, 4000, null, 20);

COMMIT;

-- p.275
-- emp ���̺��� �޿� ���(salgrade)�� 1(700~1200)�� ����� emp_temp ���̺� �߰�
-- ���������� �̿��ؼ� �ѹ��� ���� �����͸� �߰��Ͽ���!
-- �̶��� VALUES()�� ������� �ʰ� �ٷ� ���������� ��
INSERT INTO emp_temp
SELECT emp.*
FROM emp
    JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
WHERE grade = 1;
DELETE emp_temp;

COMMIT;

-- �޿� ����� 3�� ����� emp_temp�� �߰�
INSERT INTO emp_temp
SELECT emp.*
FROM emp
    JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
WHERE salgrade.grade = 3;

-- dept ���̺��� �����ؼ� dept_temp2 ���̺��� �����ϰ�,
-- 40�� �μ����� DATABASE, ������ SEOUL�� ����
CREATE TABLE dept_temp2
AS
SELECT *
FROM dept;

UPDATE dept_temp2
SET
    dname = 'DATABASE',
    loc = 'SEOUL'
WHERE
    deptno = 40;
    
COMMIT;

-- dept_temp2 ���̺��� �μ���ȣ�� 40���� �μ���� ������ ����
-- dept ���̺��� 40�� �μ��� �������� �����ϱ�
UPDATE dept_temp2
SET
    dname = (
        SELECT dname
        FROM dept
        WHERE deptno = 40
        ),
    loc = (
        SELECT loc
        FROM dept
        WHERE deptno = 40
        )
WHERE
    deptno = 40;
    
UPDATE dept_temp2
SET
    (dname, loc) = (
        SELECT dname, loc
        FROM dept
        WHERE deptno = 40
        )
WHERE
    deptno = 40;

-- DDL : ��ü ���� ���� ���� CREATE, DROP, ALTER
-- DROP: ��ü ����
-- dept_temp2 ������ ����
DELETE dept_temp2;
COMMIT;

-- dept_temp2 ���̺� ����
DROP TABLE dept_temp;

-- dept ���̺��� �̿��ؼ� dept_temp ���̺� ����
CREATE TABLE dept_temp
AS
SELECT *
FROM dept;

-- ADD(): ��ü ��� �߰�
-- dept_temp ���̺� �÷� �߰�
ALTER TABLE dept_temp
ADD(location varchar2(30));

-- 10�� �μ��� location�� ���� NEW YORK���� ����
UPDATE dept_temp
SET location = 'NEW YORK'
WHERE deptno = 10;

COMMIT;

-- MODIFY(): ��ü ��� ����
-- location�� �뷮�� 70���� ����
ALTER TABLE dept_temp
MODIFY(location varchar(70));

-- DROP COLUMN -> ���� DROP�� ����
-- location �÷� ����
ALTER TABLE dept_temp
DROP COLUMN location;

-- RENAME TO: ��ü �̸� ����
-- ���̺� dept_temp�� dept_temp_temp�� ����
ALTER TABLE dept_temp
RENAME TO dept_temp_temp;
RENAME dept_temp_temp TO dept_temp; -- ALTER �Ⱦ��� RENAME�� �ᵵ ��
-- RENAME COLUMN A TO B: ��ü �� �̸� ����
-- �÷� loc�� �̸��� location���� ����
ALTER TABLE dept_temp
RENAME COLUMN loc TO location;

-- dept_temp ������ ��� ����
DELETE dept_temp;
ROLLBACK; -- DELETE�� DCL�̶� Ŀ��, �ѹ��� ����
TRUNCATE TABLE dept_temp; -- DELETE ���̺�� �̶� ����
ROLLBACK; -- �׷��� TRUNCATE�� DDL�̶� Ŀ��, �ѹ��� �ȵ�

DROP TABLE dept_temp;

----------------------------------------------------------------------------

-- test1 ���̺���
-- 1. �÷� �߰�: birthday / date��
ALTER TABLE test1
ADD(birthday date);

-- 2. �÷��� ����: tel -> phone
ALTER TABLE test1
RENAME COLUMN tel TO phone;

-- 3. no �÷� ����
ALTER TABLE test1
DROP COLUMN no;

-- 4. num �÷� �߰�: number(3)
ALTER TABLE test1
ADD(num number(3));

-- 5. address ���ڿ�(50) -> ���ڿ�(70)���� ����
ALTER TABLE test1
MODIFY(address varchar(70));

-- 6. test1 ���̺��� �̸��� testtest�� �مf�ٰ� �ٽ� ���ƿ��� ����
RENAME test1 TO testtest;
ALTER TABLE testtest
RENAME TO test1;

-- 7. ���̺� ����
DROP TABLE test1;