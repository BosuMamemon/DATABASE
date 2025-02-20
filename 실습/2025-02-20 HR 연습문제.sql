SET SERVEROUTPUT ON;
--1. employees ���̺�
--employee_id = 200�� ����� ��� ������ �����ؼ�
--���̵�, �̸�, �Ի��� ���
--PL/SQL�� �ۼ�
DECLARE
    v_emp employees%ROWTYPE;
BEGIN
    SELECT * INTO v_emp
    FROM employees
    WHERE employee_id = 200;
    dbms_output.put_line('���̵�: ' || v_emp.employee_id);
    dbms_output.put_line('�̸�: ' || v_emp.first_name);
    dbms_output.put_line('�Ի���: ' || v_emp.hire_date);
END;
/

--2. employees���� department_id, first_name, salary, phone_number, ��Ÿ�� ����ϵ�
--�޿��� õ���� �и� ��ȣ ���
--��Ÿ: �޿��� 5000 ������ ��� '���ӱ�'
--5000 ~ 10000 '�����ӱ�'
--10000 �ʰ� '���ӱ�'
DECLARE
    note VARCHAR2(50) := NULL;
    CURSOR c IS
        SELECT department_id, first_name, salary, phone_number
        FROM employees;
BEGIN
    dbms_output.put_line(
                RPAD('�μ� ID', 11) || RPAD('�̸�', 16) || RPAD('�ӱ�', 11) || RPAD('��ȭ��ȣ', 21) || '���'
            );
    FOR i IN c
        LOOP
            CASE
                WHEN i.salary <= 5000 THEN
                    note := '���ӱ�';
                WHEN i.salary BETWEEN 5000 AND 10000 THEN
                    note := '�����ӱ�';
                WHEN i.salary > 10000 THEN
                    note := '���ӱ�';
            END CASE;
            
            IF i.department_id IS NULL THEN
                dbms_output.put_line(
                RPAD('N/A', 10) || RPAD(i.first_name, 15) || RPAD(TO_CHAR(i.salary, '999,999'), 10) || RPAD(i.phone_number, 20) || note
            );
            ELSE
                dbms_output.put_line(
                    RPAD(i.department_id, 10) || RPAD(i.first_name, 15) || RPAD(TO_CHAR(i.salary, '999,999'), 10) || RPAD(i.phone_number, 20) || note
                );
            END IF;
        END LOOP;
END;
/
--SQL���� CASE�� ����
DECLARE
    note VARCHAR2(50) := NULL;
    CURSOR c IS
        SELECT
            department_id, first_name, salary, phone_number,
            CASE
                WHEN salary <= 5000 THEN '���ӱ�'
                WHEN salary BETWEEN 5000 AND 10000 THEN '�����ӱ�'
                WHEN salary > 10000 THEN '���ӱ�'
            END AS note
        FROM employees
        ORDER BY department_id;
BEGIN
    dbms_output.put_line(
                RPAD('�μ� ID', 11) || RPAD('�̸�', 16) || RPAD('�ӱ�', 11) || RPAD('��ȭ��ȣ', 21) || '���'
            );
    FOR i IN c
        LOOP
            IF i.department_id IS NULL THEN
                dbms_output.put_line(
                RPAD('N/A', 10) || RPAD(i.first_name, 15) || RPAD(TO_CHAR(i.salary, '999,999'), 10) || RPAD(i.phone_number, 20) || i.note
            );
            ELSE
                dbms_output.put_line(
                    RPAD(i.department_id, 10) || RPAD(i.first_name, 15) || RPAD(TO_CHAR(i.salary, '999,999'), 10) || RPAD(i.phone_number, 20) || i.note
                );
            END IF;
        END LOOP;
END;
/