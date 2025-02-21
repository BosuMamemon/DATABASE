SET SERVEROUTPUT ON;

--���ν����� ����Ͽ� ���̺� �ڷ� ����ֱ�
--CTAS emp_mon ���̺� ����(emp �̿�)
CREATE TABLE emp_mon
AS
SELECT *
FROM emp;

--(empno, ename, job, mgr, sal) 
--4000, 'ȫ�浿', '���', 5000, 800 �߰�
--4001, 'ȫ�浿1', '���1', 5000, 900 �߰�
CREATE OR REPLACE PROCEDURE emp_proc(
    v_empno emp_mon.empno%TYPE,
    v_ename emp_mon.ename%TYPE,
    v_job   emp_mon.job%TYPE,
    v_mgr   emp_mon.mgr%TYPE,
    v_sal   emp_mon.sal%TYPE
)
IS
BEGIN
    INSERT INTO emp_mon(empno, ename, job, mgr, sal)
    VALUES(v_empno, v_ename, v_job, v_mgr, v_sal);
    COMMIT;
END;
/
EXECUTE emp_proc(4000, 'ȫ�浿', '���', 5000, 800);
EXECUTE emp_proc(4001, 'ȫ�浿1', '���1', 5000, 900);

--�μ���, �ο���, �޿��հ踦 ���ϴ� ���ν���(sumProcess) �ۼ�
CREATE OR REPLACE PROCEDURE sumProcess
IS
    CURSOR c IS
        SELECT dname �μ���, COUNT(*) �ο���, SUM(sal) �޿��հ�
        FROM emp NATURAL JOIN dept
        GROUP BY dname;
BEGIN
    FOR i IN c
        LOOP
            dbms_output.put_line('�μ���: ' || i.�μ���);
            dbms_output.put_line('�ο���: ' || i.�ο���);
            dbms_output.put_line('�޿��հ�: ' || i.�޿��հ�);
        END LOOP;
END;
/

EXECUTE sumProcess; --sumProcess()��� �������൵ ��