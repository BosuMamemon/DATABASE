--p.439 �ݺ���
-- LOOP��
SET SERVEROUTPUT ON;

DECLARE
    v_num NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('v_num: ' || v_num);
        v_num := v_num + 1;
        IF v_num > 5
            THEN EXIT;
        END IF;
    END LOOP;
END;
/

-- WHILE��
DECLARE
    v_number NUMBER := 0;
BEGIN
    WHILE v_number < 5
        LOOP
            dbms_output.put_line('v_number: ' || v_number);
            v_number := v_number + 1;
        END LOOP;
END;
/

--FOR��
DECLARE
    v_number NUMBER := 0;
BEGIN
    FOR i IN 1..4
        LOOP
            dbms_output.put_line('���� i: ' || i);
            dbms_output.put_line('v_number: ' || v_number);
            v_number := v_number + 1;
        END LOOP;
        
    FOR i IN REVERSE 1..4
        LOOP
            dbms_output.put_line('���� i: ' || i);
            dbms_output.put_line('v_number: ' || v_number);
            v_number := v_number - 1;
        END LOOP;
END;
/

--FOR�� �̿��ؼ� 0���� 4���� ����: ¦���� ���

BEGIN
    FOR i IN 1..4
        LOOP
            IF MOD(i, 2) = 0
                THEN dbms_output.put_line('���� i: ' || i);
            END IF;
        END LOOP;
--    
dbms_output.put_line('');
    FOR k IN 0..4
        LOOP
            CONTINUE WHEN MOD(k, 2) = 1;
            dbms_output.put_line('���� k: ' || k);
        END LOOP;
--
dbms_output.put_line('');
    FOR m IN 0..4
        LOOP
            EXIT WHEN MOD(m, 2) = 1; --EXIT�� �ڹ��� break�� ����
            dbms_output.put_line('���� m: ' || m);
        END LOOP;
END;
/

-- 1���� 10���� Ȧ�� ���
BEGIN
    for i in 1..10 loop
        if mod(i,2)=1 then
            dbms_output.put_line('Ȧ�� i �� :' || i);
        end if;
    end loop;
end;
/

--dept ���̺��� deptno�� �ڷ����� ���� ���� v_deptno�� �����ϰ�
--v_deptno���� ���� �μ��� ���(10, 20, 30, 40, �ƹ��͵� �ƴϸ� n/a)
DECLARE
    v_deptno dept.deptno%TYPE;
BEGIN
    CASE v_deptno
        WHEN 10
            THEN dbms_output.put_line('DNAME: ACCOUNTING');
        WHEN 20
            THEN dbms_output.put_line('DNAME: RESEARCH');
        WHEN 30
            THEN dbms_output.put_line('DNAME: SALES');
        WHEN 40
            THEN dbms_output.put_line('DNAME: OPERATION');
        ELSE
            dbms_output.put_line('DNAME: N/A');
    END CASE;
END;
/

--����ڷκ��� �μ���ȣ�� �Է¹޾ƾ��� ��
ACCEPT p_deptno PROMPT '�μ���ȣ �Է�: ';
DECLARE
    v_deptno dept.deptno%TYPE := &p_deptno; --ACCEPT�κ��� �Է¹��� ���� ����������� ������ �տ� �� &�� �ٿ������
BEGIN
    CASE v_deptno
        WHEN 10
            THEN dbms_output.put_line('DNAME: ACCOUNTING');
        WHEN 20
            THEN dbms_output.put_line('DNAME: RESEARCH');
        WHEN 30
            THEN dbms_output.put_line('DNAME: SALES');
        WHEN 40
            THEN dbms_output.put_line('DNAME: OPERATION');
        ELSE
            dbms_output.put_line('DNAME: N/A');
    END CASE;
END;
/

--�� �ۼ����� if������ �ۼ�
ACCEPT p_deptno PROMPT '�μ���ȣ �Է�: ';
DECLARE
    v_deptno dept.deptno%TYPE := &p_deptno; --ACCEPT�κ��� �Է¹��� ���� ����������� ������ �տ� �� &�� �ٿ������
BEGIN
    IF v_deptno = 10
        THEN dbms_output.put_line('DNAME: ACCOUNTING');
    ELSIF v_deptno = 20
        THEN dbms_output.put_line('DNAME: RESEARCH');
    ELSIF v_deptno = 30
        THEN dbms_output.put_line('DNAME: SALES');
    ELSIF v_deptno = 40
        THEN dbms_output.put_line('DNAME: OPERATION');
    ELSE
        dbms_output.put_line('DNAME: N/A');
    END IF;
END;
/

--�� �ۼ����� �ڵ����� DNAME�� ã���� �ۼ�
ACCEPT p_deptno1 PROMPT 'SELECT �μ���ȣ �Է�: ';
DECLARE
    v_dname dept.dname%TYPE;
    v_deptno dept.deptno%TYPE := &p_deptno1;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = v_deptno;
    dbms_output.put_line('DEPTNO: ' || v_deptno);
    dbms_output.put_line('DNAME: ' || v_dname);
EXCEPTION
    WHEN no_data_found
        THEN dbms_output.put_line('DNAME: N/A');
END;
/


--2�� ���
--2 * 1 = 2
--...
--2 * 9 = 18
BEGIN
    FOR i IN 1..9
        LOOP
            dbms_output.put_line('2 * ' || i || ' = ' || 2 * i);
        END LOOP;
END;
/
--���� �����ؼ� �� ���ν��� �ٽ� �ۼ��غ���
DECLARE
    total NUMBER(3);
BEGIN
    FOR i IN 1..9
        LOOP
            total := 3 * i;
            dbms_output.put_line('3 * ' || i || ' = ' || total);
        END LOOP;
END;
/
--���� �Է¹޾� �Է¹��� ���� �������� ����ϱ�
ACCEPT p_dan PROMPT '����� �������� ��: ';
DECLARE
    total NUMBER(3);
    dan NUMBER := &p_dan;
BEGIN
    FOR i IN 1..9
        LOOP
            total := dan * i;
            dbms_output.put_line(dan || ' * ' || i || ' = ' || total);
        END LOOP;
END;
/

--dept ���̺� �̿�
--�μ���ȣ�� �Է¹޾� �μ���� ������ ����ϱ�
ACCEPT p_deptno PROMPT '�μ���ȣ �Է�: ';
DECLARE
    v_deptno dept.deptno%TYPE := &p_deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = v_deptno;
    dbms_output.put_line('�μ���: ' || v_dname);
    dbms_output.put_line('�μ� ����: ' || v_loc);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('�μ���: N/A');
        dbms_output.put_line('�μ� ����: N/A');
END;
/

--�������� ���̺� �����غ���
CREATE TABLE A(
    a1 NUMBER,
    a2 NUMBER,
    a3 NUMBER
);
ACCEPT p_dan;
DECLARE
    dan NUMBER := &p_dan;
    total NUMBER;
BEGIN
    FOR i IN 1..9
        LOOP
            total := dan * i;
            dbms_output.put_line(dan || ' * ' || i || ' = ' || total);
            INSERT INTO a VALUES(dan, i, total);
        END LOOP;
END;
/
--�μ���ȣ�� �Է¹޾� �� �μ��� �μ���� ������ ����ϰ�
--dept_temp ���̺� �� ������ �߰��ϱ�
--num�� ������ ���: dept_temp_seq
CREATE TABLE dept_temp(
    num NUMBER,
    dname VARCHAR2(50),
    loc VARCHAR2(50)
);
CREATE SEQUENCE dept_temp_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE
    NOCACHE;

ACCEPT p_deptno;
DECLARE
    v_deptno dept.deptno%TYPE := &p_deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = v_deptno;
    
    dbms_output.put_line('�μ���ȣ: ' || v_deptno);
    dbms_output.put_line('�μ���: ' || v_dname);
    dbms_output.put_line('��������: ' || v_loc);
    
    INSERT INTO dept_temp
    VALUES(dept_temp_seq.NEXTVAL, v_dname, v_loc);
    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('�μ���ȣ �����Ͱ� �����ϴ�.');
END;
/


--p.446 record
--ctas ������� dept ���̺��� �̿��� dept_record ���̺� ����
--PL/SQL������ dept_record ���̺� 99, database, seoul�̶�� ���� �߰�
CREATE TABLE dept_record
AS
SELECT *
FROM dept;

DECLARE
    r_deptno NUMBER;
    r_dname VARCHAR2(20);
    r_loc VARCHAR2(20);
BEGIN
    r_deptno := 99;
    r_dname := 'DATABASE';
    r_loc := 'SEOUL';
    INSERT INTO dept_record
    VALUES(r_deptno, r_dname, r_loc);
    COMMIT;
END;
/
--�ٸ� ���
DECLARE
    TYPE REC_DEPT IS RECORD( --���ڵ� Ÿ���̶�� ����
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
    );
    dept_rec REC_DEPT; --������ �� ���� �������... REC_DEPT��� �̸�����
BEGIN
    dept_rec.dname := 'ORACLE';
    dept_rec.loc := 'BUSAN';
    INSERT INTO dept_record VALUES dept_rec;
    COMMIT;
END;
/
--�� �ٸ� ���
DECLARE
    v_dept_rec dept%ROWTYPE;
BEGIN
    v_dept_rec.deptno := 11;
    v_dept_rec.dname := 'JAVA';
    v_dept_rec.loc := 'DAEJEON';
    INSERT INTO dept_record VALUES v_dept_rec;
    COMMIT;
END;
/

--P.450
--emp, dept ���̺� 
--�����ȣ, ����̸�, �μ���ȣ, �μ���, �μ����� ==> ��, �����ȣ�� 7369�� ����
SELECT empno, ename, deptno, dname, loc
FROM emp NATURAL JOIN dept
WHERE empno = 7369;
--�� �������� pl/sql�� �ϱ� ����
DECLARE
    TYPE EMP_REC IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        deptno emp.deptno%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
    );
    v_emp_rec EMP_REC;
BEGIN
    SELECT empno, ename, deptno, dname, loc
    INTO v_emp_rec
    FROM emp NATURAL JOIN dept
    WHERE empno = 7369;
    dbms_output.put_line('�����ȣ: ' || v_emp_rec.empno);
    dbms_output.put_line('����̸�: ' || v_emp_rec.ename);
    dbms_output.put_line('�μ���ȣ: ' || v_emp_rec.deptno);
    dbms_output.put_line('�μ��̸�: ' || v_emp_rec.dname);
    dbms_output.put_line('��������: ' || v_emp_rec.loc);
END;
/

--p.460 cursor
--SELECT��, ������ ���۾� ���� SQL���� �������� ��
--�ش� SQL���� ó���ϴ� ������ �����ϴ� �޸� ����
--���� 1: CURSOR OPEN FETCH CLOSE
--���� 2: FOR LOOP END(������ �� ����)
--���� 2�� ���� �ۼ��غ���
DECLARE
    v_emp emp%ROWTYPE; --���� ����
    CURSOR c1 IS
        SELECT empno, ename, sal
        FROM emp
        WHERE deptno = 20; --Ŀ�� ����: �ڷ����� �������� ���� ������ DECLARE������ ������
BEGIN
    dbms_output.put_line('��ȣ   �̸�   �޿�');
    FOR v_emp IN c1 --v_emp�� DECLARE������ ������ �ص� ���ص� �������
        LOOP
            dbms_output.put_line(v_emp.empno || ' ' || v_emp.ename || ' ' || v_emp.sal);
        END LOOP;
END;
/

--emp ���̺��� ��� ��� �̸��� �޿��� ����ϰ�, ȸ������ �޿� �հ赵 ���
DECLARE
    total NUMBER := 0;
    CURSOR c1 IS
        SELECT ename, sal
        FROM emp;
BEGIN
    dbms_output.put_line('�̸�        �޿�');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(v_emp.ename || ' ' || TO_CHAR(v_emp.sal, '999,999'));
            total := total + v_emp.sal;
        END LOOP;
    dbms_output.put_line('�޿� �հ�: ' || TO_CHAR(total, '999,999'));
END;
/
--�ٸ� ���
DECLARE
    total NUMBER := 0;
    CURSOR c1 IS
        SELECT ename, sal
        FROM emp;
BEGIN
    dbms_output.put_line('�̸�    �޿�');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(v_emp.ename || TO_CHAR(v_emp.sal, '999,999'));
        END LOOP;
        SELECT sum(sal) INTO total FROM emp;
        dbms_output.put_line('�޿� �հ�:' || TO_CHAR(total, '999,999'));
END;
/
--
SELECT ename, sal FROM emp ORDER BY sal DESC;
--PL/SQL�� ����� �޿���Ȳ(�޿��� ������������ ���)
--�̸� ��ǥ(100�� ��ǥ �ϳ�)
--��: JAMES **********(950)
DECLARE
    CURSOR c1 IS
        SELECT ename, sal FROM emp ORDER BY sal DESC;
BEGIN
    dbms_output.put_line(RPAD('�̸�', 12) || '�޿�');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(
                RPAD(v_emp.ename, 10) || ' ' || RPAD('*', ROUND(v_emp.sal / 100), '*') || '(' || v_emp.sal || ')'
            );
        END LOOP;
END;
/
--�� �������� �޿� 2000 �̻��� ����� �����޶� �׷���?
DECLARE
    CURSOR c1 IS
        SELECT ename, sal FROM emp WHERE sal >= 2000 ORDER BY sal DESC;
BEGIN
    dbms_output.put_line(RPAD('�̸�', 12) || '�޿�');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(
                RPAD(v_emp.ename, 10) || ' ' || RPAD('*', ROUND(v_emp.sal / 100), '*') || '(' || v_emp.sal || ')'
            );
        END LOOP;
END;
/
--�Ǵ� begin������ ó���Ҽ��� ����
DECLARE
    CURSOR c1 IS
        SELECT ename, sal FROM emp ORDER BY sal DESC;
BEGIN
    dbms_output.put_line(RPAD('�̸�', 12) || '�޿�');
    FOR v_emp IN c1
        LOOP
            IF v_emp.sal >= 2000 THEN
                dbms_output.put_line(
                    RPAD(v_emp.ename, 10) || ' ' || RPAD('*', ROUND(v_emp.sal / 100), '*') || '(' || v_emp.sal || ')'
                );
            END IF;
        END LOOP;
END;
/

--p.462 �ϳ��� �����͸� ���� => Ŀ�� ���
-- OPEN FETCH CLOSE ��� ���
DECLARE
--  ����� Ŀ�� ����
    CURSOR c IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE deptno = 40;
    v_dept_row dept%ROWTYPE;
BEGIN
--  Ŀ�� ����
    OPEN c;
--  Ŀ���κ��� �о�� ������ ���(FETCH)
    FETCH c INTO v_dept_row;
    dbms_output.put_line('deptno: ' || v_dept_row.deptno);
    dbms_output.put_line('dname: ' || v_dept_row.dname);
    dbms_output.put_line('loc: ' || v_dept_row.loc);
--  Ŀ�� �ݱ�
    CLOSE c;
END;
/
-- FOR�� ���
DECLARE
    CURSOR c IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE deptno = 40;
BEGIN
    FOR i IN c
        LOOP
            dbms_output.put_line('deptno: ' || i.deptno);
            dbms_output.put_line('dname: ' || i.dname);
            dbms_output.put_line('loc: ' || i.loc);
        END LOOP;
END;
/
-- CURSOR ������� �ʱ�
DECLARE
    v_row dept%ROWTYPE;
BEGIN
    SELECT deptno, dname, loc
    INTO v_row
    FROM dept
    WHERE deptno = 40;
    dbms_output.put_line('deptno: ' || v_row.deptno);
    dbms_output.put_line('dname: ' || v_row.dname);
    dbms_output.put_line('loc: ' || v_row.loc);
END;
/