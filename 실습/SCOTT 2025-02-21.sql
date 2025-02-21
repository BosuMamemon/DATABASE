SET SERVEROUTPUT ON;

--프로시저를 사용하여 테이블에 자료 집어넣기
--CTAS emp_mon 테이블 생성(emp 이용)
CREATE TABLE emp_mon
AS
SELECT *
FROM emp;

--(empno, ename, job, mgr, sal) 
--4000, '홍길동', '사원', 5000, 800 추가
--4001, '홍길동1', '사원1', 5000, 900 추가
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
EXECUTE emp_proc(4000, '홍길동', '사원', 5000, 800);
EXECUTE emp_proc(4001, '홍길동1', '사원1', 5000, 900);

--부서명, 인원수, 급여합계를 구하는 프로시저(sumProcess) 작성
CREATE OR REPLACE PROCEDURE sumProcess
IS
    CURSOR c IS
        SELECT dname 부서명, COUNT(*) 인원수, SUM(sal) 급여합계
        FROM emp NATURAL JOIN dept
        GROUP BY dname;
BEGIN
    FOR i IN c
        LOOP
            dbms_output.put_line('부서명: ' || i.부서명);
            dbms_output.put_line('인원수: ' || i.인원수);
            dbms_output.put_line('급여합계: ' || i.급여합계);
        END LOOP;
END;
/

EXECUTE sumProcess; --sumProcess()라고 안적어줘도 됨