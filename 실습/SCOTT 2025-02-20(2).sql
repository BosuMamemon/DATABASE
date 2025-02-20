SET SERVEROUTPUT ON;
--부서번호를 입력받아 그 부서의 번호, 부서명, 지역을 출력
DECLARE
    CURSOR c IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE deptno = &p_deptno;
BEGIN
    FOR item IN c
        LOOP
            dbms_output.put_line('부서번호: ' || item.deptno);
            dbms_output.put_line('부서이름: ' || item.dname);
            dbms_output.put_line('소재지역: ' || item.loc);
        END LOOP;
END;
/
--또는!!
--이게 커서에 패러미터를 받는 방법임
DECLARE
    v_deptno dept.deptno%TYPE := &input_deptno;
    CURSOR c(p_deptno dept.deptno%TYPE) IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE deptno = p_deptno;
BEGIN
    FOR item IN c(v_deptno)
        LOOP
            dbms_output.put_line('부서번호: ' || item.deptno);
            dbms_output.put_line('부서이름: ' || item.dname);
            dbms_output.put_line('소재지역: ' || item.loc);
        END LOOP;
END;
/
--
--input_deptno에 부서번호를 입력받고 v_deptno에 대입
--input_deptno이거나, 부서명이 'SALES'인 사원 정보를 출력
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
            dbms_output.put_line('부서번호: ' || item.deptno);
            dbms_output.put_line('부서이름: ' || item.dname);
            dbms_output.put_line('소재지역: ' || item.loc);
            dbms_output.put_line('');
        END LOOP;
END;
/

