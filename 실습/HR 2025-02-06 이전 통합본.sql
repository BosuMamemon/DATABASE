--@C:\JHM\DATABASE\hr_table.sql;

-- 1. employees ���̺� ��� ���� ��ȸ
SELECT * FROM employees;

-- 2. departments ���̺� ��� ���� ��ȸ
SELECT * FROM departments;

-- 3. employees ���̺��� first_name ��ȸ
SELECT first_name FROM employees;

-- 4. employees ���̺��� department_id�� 30���� first_name�� ��ȸ
SELECT first_name FROM employees
WHERE department_id = 30;

-- 5. employees ���̺��� ����(salary)�� 9000 �̻��� ����� first_name�� ��ȸ
-- ��, ����(salary)�� ���� ������ ���
SELECT first_name FROM employees
WHERE salary >= 9000
ORDER BY salary DESC;

-- 6. employees ���̺��� ������ 9000 �̻��̰�,
-- �μ���ȣ(department_id)�� 30���� ����� first_name ��ȸ
SELECT first_name, salary, department_id FROM employees
WHERE
    salary >= 9000
    AND
    department_id = 30;

-- 7. employees ���̺��� ����(salary)�� 9000 �̻��̰ų�,
-- �μ���ȣ(department_id)�� 30���� ����� first_name ��ȸ
SELECT first_name, salary, department_id FROM employees
WHERE
    salary >= 9000
    OR
    department_id = 30;
    
-- 8. �μ���ȣ�� 20�� �ƴ� ����� first_name, department_id ��ȸ
SELECT first_name, department_id FROM employees
WHERE NOT department_id = 20;

-- 9. job_id�� PU_CLERK�ų� ST_MAN�ų� SA_MAN�� �����
-- first_name�� job_id ���
SELECT first_name, job_id FROM employees
WHERE job_id IN ('PU_CLERK', 'ST_MAN', 'SA_MAN');

-- 10. �μ���ȣ�� 100�� ����� first_name, first_name�� ù����, �μ���ȣ ���
SELECT first_name, SUBSTR(first_name, 1, 1) AS first_letter, department_id
FROM employees
WHERE department_id = 100;

-- 11. �μ���ȣ�� 100�� ����� first_name�� 10���ڷ� ǥ���ϵ�, ������ '*'�� ä���
SELECT RPAD(first_name, 10, '*')
FROM employees
WHERE department_id = 100;

-- 12. �μ���ȣ�� 100�� ����� first_name�� �α��ڸ� ����ϰ�, �������� '*'�� ä���
SELECT RPAD(SUBSTR(first_name, 1, 2), LENGTH(first_name), '*') AS first_name
FROM employees
WHERE department_id = 100;

------------------------------------------------------------------------------------------

-- professor ���̺�
-- 1. professor ���̺� name�� deptno, �а��� ���
-- ��, deptno = 101�̸� '��ǻ�Ͱ��а�'



