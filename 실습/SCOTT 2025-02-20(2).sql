SET SERVEROUTPUT ON;
--�μ���ȣ�� �Է¹޾� �� �μ��� ��ȣ, �μ���, ������ ���
DECLARE
    CURSOR c IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE deptno = &p_deptno;
BEGIN
    FOR item IN c
        LOOP
            dbms_output.put_line('�μ���ȣ: ' || item.deptno);
            dbms_output.put_line('�μ��̸�: ' || item.dname);
            dbms_output.put_line('��������: ' || item.loc);
        END LOOP;
END;
/
--�Ǵ�!!
--�̰� Ŀ���� �з����͸� �޴� �����
DECLARE
    v_deptno dept.deptno%TYPE := &input_deptno;
    CURSOR c(p_deptno dept.deptno%TYPE) IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE deptno = p_deptno;
BEGIN
    FOR item IN c(v_deptno)
        LOOP
            dbms_output.put_line('�μ���ȣ: ' || item.deptno);
            dbms_output.put_line('�μ��̸�: ' || item.dname);
            dbms_output.put_line('��������: ' || item.loc);
        END LOOP;
END;
/
--
--input_deptno�� �μ���ȣ�� �Է¹ް� v_deptno�� ����
--input_deptno�̰ų�, �μ����� 'SALES'�� ��� ������ ���
DECLARE
    v_deptno dept.deptno%TYPE := &input_deptno;
    v_dname dept.dname%TYPE := &input_dname;
    CURSOR c1(
            p_deptno dept.deptno%TYPE, p_dname dept.dname%TYPE
        ) IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE
            deptno = p_deptno
            OR
            dname = p_dname;
BEGIN
    FOR item IN c1(v_deptno, v_dname)
        LOOP
            dbms_output.put_line('�μ���ȣ: ' || item.deptno);
            dbms_output.put_line('�μ��̸�: ' || item.dname);
            dbms_output.put_line('��������: ' || item.loc);
            dbms_output.put_line('');
        END LOOP;
END;
/

