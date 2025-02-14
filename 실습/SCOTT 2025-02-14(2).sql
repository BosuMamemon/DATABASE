--pl/sql(p.420)

SET SERVEROUTPUT ON; --출력결과 확인(스크립트 실행으로 실행해줘야 함)

BEGIN
    dbms_output.put_line('Hello');
END;
/
--p.421
DECLARE --변수 선언
    v_ename VARCHAR2(20);
    v_empno NUMBER(4);
    v_tax CONSTANT NUMBER(3) := 3;
    v_deptno NUMBER(2) NOT NULL DEFAULT 10;
    v_deptno1 dept.deptno%TYPE := 5; --자료형을 참조형(dept.deptno의 자료형을 참조)으로 선언하였음
BEGIN
    v_ename := 'SMITH';
    v_empno := 9900;
    dbms_output.put_line('v_ename: ' || v_ename);
    dbms_output.put_line('v_empno: ' || v_empno);
--  v_tax := 5; <- CONSTANT는 상수 취급이라서 변경 불가임
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
--위 쿼리문을 작성하는 pl/sql문을 작성하기
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
        THEN dbms_output.put_line(v_number || ': 짝수');
    ELSE
        dbms_output.put_line(v_number || ': 짝수');
    END IF;
    
    dbms_output.put_line('v_deptno: ' || v_deptno_row.deptno);
    dbms_output.put_line('v_dname: ' || v_deptno_row.dname);
    dbms_output.put_line('v_loc: ' || v_deptno_row.loc);
END;
/

=====

--p.434 학점 출력(A, B, C, D, F 학점)
DECLARE
    v_score NUMBER := 88;
BEGIN
    IF v_score >= 90 THEN
        dbms_output.put_line('A학점');
    ELSIF v_score >= 80 THEN
        dbms_output.put_line('B학점');
    ELSIF v_score >= 70 THEN
        dbms_output.put_line('C학점');
    ELSIF v_score >= 60 THEN
        dbms_output.put_line('D학점');
    ELSE
        dbms_output.put_line('F학점');
    END IF;
END;
/

DECLARE
    v_score NUMBER := 88;
BEGIN
    CASE TRUNC(v_score / 10) --생략가능
        WHEN 10 THEN dbms_output.put_line('A학점'); -- 물론 WHEN 뒤에 v_score >= 90 같은 범위값도 줄 수 있음
        WHEN 9 THEN dbms_output.put_line('A학점');
        WHEN 8 THEN dbms_output.put_line('B학점');
        WHEN 7 THEN dbms_output.put_line('C학점');
        WHEN 6 THEN dbms_output.put_line('D학점');
        ELSE dbms_output.put_line('F학점');
    END CASE;
END;
/