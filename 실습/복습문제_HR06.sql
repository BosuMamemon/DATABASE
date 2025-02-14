--CTAS
--1.employees ���̺��� �̿��ؼ� sal_history(empid, hiredate,sal) ���̺� ����
CREATE TABLE sal_history(
    empid,
    hiredate,
    sal)
AS
SELECT employee_id, hire_date, salary
FROM employees;

--2. employees ���̺��� ������ �̿��ؼ� sal_history2(empid, hiredate,sal) ���̺� ����
CREATE TABLE sal_history2(empid, hiredate, sal)
AS
SELECT employee_id, hire_date, salary
FROM employees
WHERE 0 != 0;

--3. employees ���̺��� ������ �̿��ؼ� sal_history3(id, hire,sal) ���̺� ����
CREATE TABLE sal_history3(id, hire, sal)
AS
SELECT employee_id, hire_date, salary
FROM employees
WHERE 0 != 0;

--4. sal_history / sal_history2 / sal_history3 ���̺� ����
DROP TABLE sal_history;
DROP TABLE sal_history2;
DROP TABLE sal_history3;

--5. employees ������ �̿��ؼ� sal_history(empid, hiredate, sal) ���̺� ����
CREATE TABLE sal_history(empid, hiredate, sal)
AS
SELECT employee_id, hire_date, salary
FROM employees
WHERE 0 != 0;

--6. employees ���̺��� employee_id�� 200���� ū �����͸� sal_history ���̺� �ֱ�
INSERT INTO sal_history
SELECT employee_id, hire_date, salary
FROM employees
WHERE employee_id > 200;
COMMIT;

-- 1. member ���̺� ����
-- id ���� / name ���ڿ�(20) / address  ���ڿ�(50) /  phone ���ڿ�(20)
CREATE TABLE member(
    id number,
    name varchar2(20),
    address varchar2(50),
    phone varchar2(20));

-- 2.�߰�
-- (100, 'ȫ�浿', '�λ�', '010-1111-2222')
-- (101, '�̼���', '����', '010-2222-3333')
-- (102, '������', '�뱸', '010-4444-5555')
-- (103, '����Ŭ', '�λ�', '010-5555-6666')
-- (104, '�����ͺ��̽�', '����', '010-3434-7777')
INSERT INTO member
VALUES(100, 'ȫ�浿', '�λ�', '010-1111-2222');
INSERT INTO member
VALUES(101, '�̼���', '����', '010-2222-3333');
INSERT INTO member
VALUES(102, '������', '�뱸', '010-4444-5555');
INSERT INTO member
VALUES(103, '����Ŭ', '�λ�', '010-5555-6666');
INSERT INTO member
VALUES(104, '�����ͺ��̽�', '����', '010-3434-7777');
COMMIT;

-- 3. member ���̺��� address�� member �ο��� ���
SELECT address, COUNT(*)
FROM member
GROUP BY address;
SELECT address, CONCAT(COUNT(*), '��') �ο���
FROM member
GROUP BY address;

-- 4. 102�� ����� ��ȭ��ȣ�� 010-1212-4444�� ����
UPDATE member
SET phone = '010-1212-4444'
WHERE id = 102;
COMMIT;

-- 5. 103�� ȸ�� ����
DELETE FROM member
WHERE id = 103;
COMMIT;

-- 6. member ���̺� email(���ڿ�(30)) �� �߰�
ALTER TABLE member
ADD(email varchar2(30));

-- 7. member ���̺� email���� ���ڿ�(100)���� ����
ALTER TABLE member
MODIFY(email varchar2(100));

-- 8. 102�� ����� email�� test@test.com���� ����
UPDATE member
SET email = 'test@test.com'
WHERE id = 102;
COMMIT;

-- 9. member ���̺� ����
DROP TABLE member;