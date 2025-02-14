--pl/sql(p.420)

SET SERVEROUTPUT ON; --��°�� Ȯ��(��ũ��Ʈ �������� ��������� ��)

BEGIN
    dbms_output.put_line('Hello');
END;
/
--p.421
DECLARE --���� ����
    v_ename VARCHAR2(20);
    v_empno NUMBER(4);
    v_tax CONSTANT NUMBER(3) := 3;
    v_deptno NUMBER(2) NOT NULL DEFAULT 10;
    v_deptno1 dept.deptno%TYPE := 5; --�ڷ����� ������(dept.deptno�� �ڷ����� ����)���� �����Ͽ���
BEGIN
    v_ename := 'SMITH';
    v_empno := 9900;
    dbms_output.put_line('v_ename: ' || v_ename);
    dbms_output.put_line('v_empno: ' || v_empno);
--  v_tax := 5; <- CONSTANT�� ��� ����̶� ���� �Ұ���
    dbms_output.put_line('v_tax: ' || v_tax);
    dbms_output.put_line('v_deptno: ' || v_deptno);
    dbms_output.put_line('v_deptno1: ' || v_deptno1);
END;
/

=====

--p.429
SELECT deptno, dname, loc
FROM dept
WHERE deptno = 40;
--�� �������� �ۼ��ϴ� pl/sql���� �ۼ��ϱ�
DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT deptno, dname, loc
    INTO v_deptno, v_dname, v_loc
    FROM dept
    WHERE deptno = 40;
    
    dbms_output.put_line('v_deptno: ' || v_deptno);
    dbms_output.put_line('v_dname: ' || v_dname);
    dbms_output.put_line('v_loc: ' || v_loc);
END;
/

DECLARE
    v_deptno_row dept%ROWTYPE;
    v_number NUMBER := 30;
BEGIN
    SELECT deptno, dname, loc
    INTO v_deptno_row
    FROM dept
    WHERE deptno = 40;
    
    IF MOD(v_number, 2) = 0
        THEN dbms_output.put_line(v_number || ': ¦��');
    ELSE
        dbms_output.put_line(v_number || ': ¦��');
    END IF;
    
    dbms_output.put_line('v_deptno: ' || v_deptno_row.deptno);
    dbms_output.put_line('v_dname: ' || v_deptno_row.dname);
    dbms_output.put_line('v_loc: ' || v_deptno_row.loc);
END;
/

=====

--p.434 ���� ���(A, B, C, D, F ����)
DECLARE
    v_score NUMBER := 88;
BEGIN
    IF v_score >= 90 THEN
        dbms_output.put_line('A����');
    ELSIF v_score >= 80 THEN
        dbms_output.put_line('B����');
    ELSIF v_score >= 70 THEN
        dbms_output.put_line('C����');
    ELSIF v_score >= 60 THEN
        dbms_output.put_line('D����');
    ELSE
        dbms_output.put_line('F����');
    END IF;
END;
/

DECLARE
    v_score NUMBER := 88;
BEGIN
    CASE TRUNC(v_score / 10) --��������
        WHEN 10 THEN dbms_output.put_line('A����'); -- ���� WHEN �ڿ� v_score >= 90 ���� �������� �� �� ����
        WHEN 9 THEN dbms_output.put_line('A����');
        WHEN 8 THEN dbms_output.put_line('B����');
        WHEN 7 THEN dbms_output.put_line('C����');
        WHEN 6 THEN dbms_output.put_line('D����');
        ELSE dbms_output.put_line('F����');
    END CASE;
END;
/