--p.439 반복문
-- LOOP문
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

-- WHILE문
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

--FOR문
DECLARE
    v_number NUMBER := 0;
BEGIN
    FOR i IN 1..4
        LOOP
            dbms_output.put_line('현재 i: ' || i);
            dbms_output.put_line('v_number: ' || v_number);
            v_number := v_number + 1;
        END LOOP;
        
    FOR i IN REVERSE 1..4
        LOOP
            dbms_output.put_line('현재 i: ' || i);
            dbms_output.put_line('v_number: ' || v_number);
            v_number := v_number - 1;
        END LOOP;
END;
/

--FOR문 이용해서 0에서 4까지 동작: 짝수만 출력

BEGIN
    FOR i IN 1..4
        LOOP
            IF MOD(i, 2) = 0
                THEN dbms_output.put_line('현재 i: ' || i);
            END IF;
        END LOOP;
--    
dbms_output.put_line('');
    FOR k IN 0..4
        LOOP
            CONTINUE WHEN MOD(k, 2) = 1;
            dbms_output.put_line('현재 k: ' || k);
        END LOOP;
--
dbms_output.put_line('');
    FOR m IN 0..4
        LOOP
            EXIT WHEN MOD(m, 2) = 1; --EXIT는 자바의 break랑 같음
            dbms_output.put_line('현재 m: ' || m);
        END LOOP;
END;
/

-- 1부터 10까지 홀수 출력
BEGIN
    for i in 1..10 loop
        if mod(i,2)=1 then
            dbms_output.put_line('홀수 i 값 :' || i);
        end if;
    end loop;
end;
/

--dept 테이블의 deptno와 자료형이 같은 변수 v_deptno를 선언하고
--v_deptno값에 따른 부서명 출력(10, 20, 30, 40, 아무것도 아니면 n/a)
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

--사용자로부터 부서번호를 입력받아야할 때
ACCEPT p_deptno PROMPT '부서번호 입력: ';
DECLARE
    v_deptno dept.deptno%TYPE := &p_deptno; --ACCEPT로부터 입력받은 값을 집어넣으려면 변수명 앞에 꼭 &를 붙여줘야함
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

--위 작성문을 if문으로 작성
ACCEPT p_deptno PROMPT '부서번호 입력: ';
DECLARE
    v_deptno dept.deptno%TYPE := &p_deptno; --ACCEPT로부터 입력받은 값을 집어넣으려면 변수명 앞에 꼭 &를 붙여줘야함
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

--위 작성문을 자동으로 DNAME을 찾도록 작성
ACCEPT p_deptno1 PROMPT 'SELECT 부서번호 입력: ';
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


--2단 출력
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
--변수 선언해서 위 프로시저 다시 작성해보기
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
--단을 입력받아 입력받은 단의 구구단을 출력하기
ACCEPT p_dan PROMPT '출력할 구구단의 단: ';
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

--dept 테이블 이용
--부서번호를 입력받아 부서명과 지역을 출력하기
ACCEPT p_deptno PROMPT '부서번호 입력: ';
DECLARE
    v_deptno dept.deptno%TYPE := &p_deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = v_deptno;
    dbms_output.put_line('부서명: ' || v_dname);
    dbms_output.put_line('부서 지역: ' || v_loc);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('부서명: N/A');
        dbms_output.put_line('부서 지역: N/A');
END;
/

--구구단을 테이블에 저장해보기
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
--부서번호를 입력받아 그 부서의 부서명과 지역을 출력하고
--dept_temp 테이블에 그 내용을 추가하기
--num은 시퀀스 사용: dept_temp_seq
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
    
    dbms_output.put_line('부서번호: ' || v_deptno);
    dbms_output.put_line('부서명: ' || v_dname);
    dbms_output.put_line('소재지역: ' || v_loc);
    
    INSERT INTO dept_temp
    VALUES(dept_temp_seq.NEXTVAL, v_dname, v_loc);
    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('부서번호 데이터가 없습니다.');
END;
/


--p.446 record
--ctas 방법으로 dept 테이블을 이용해 dept_record 테이블 생성
--PL/SQL문으로 dept_record 테이블에 99, database, seoul이라는 값을 추가
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
--다른 방법
DECLARE
    TYPE REC_DEPT IS RECORD( --레코드 타입이라는 뜻임
        deptno NUMBER(2) NOT NULL := 99,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
    );
    dept_rec REC_DEPT; --유형을 또 내가 만들었음... REC_DEPT라는 이름으로
BEGIN
    dept_rec.dname := 'ORACLE';
    dept_rec.loc := 'BUSAN';
    INSERT INTO dept_record VALUES dept_rec;
    COMMIT;
END;
/
--또 다른 방법
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
--emp, dept 테이블 
--사원번호, 사원이름, 부서번호, 부서명, 부서지역 ==> 단, 사원번호는 7369로 고정
SELECT empno, ename, deptno, dname, loc
FROM emp NATURAL JOIN dept
WHERE empno = 7369;
--위 쿼리문을 pl/sql로 하기 ㅎㅎ
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
    dbms_output.put_line('사원번호: ' || v_emp_rec.empno);
    dbms_output.put_line('사원이름: ' || v_emp_rec.ename);
    dbms_output.put_line('부서번호: ' || v_emp_rec.deptno);
    dbms_output.put_line('부서이름: ' || v_emp_rec.dname);
    dbms_output.put_line('소재지역: ' || v_emp_rec.loc);
END;
/

--p.460 cursor
--SELECT문, 데이터 조작어 같은 SQL문을 실행했을 때
--해당 SQL문을 처리하는 정보를 저장하는 메모리 공간
--구문 1: CURSOR OPEN FETCH CLOSE
--구문 2: FOR LOOP END(이쪽이 더 간결)
--구문 2로 먼저 작성해보기
DECLARE
    v_emp emp%ROWTYPE; --생략 가능
    CURSOR c1 IS
        SELECT empno, ename, sal
        FROM emp
        WHERE deptno = 20; --커서 정의: 자료형의 일종으로 보기 때문에 DECLARE문에서 정의함
BEGIN
    dbms_output.put_line('번호   이름   급여');
    FOR v_emp IN c1 --v_emp는 DECLARE문에서 선언을 해도 안해도 상관없음
        LOOP
            dbms_output.put_line(v_emp.empno || ' ' || v_emp.ename || ' ' || v_emp.sal);
        END LOOP;
END;
/

--emp 테이블의 모든 사원 이름과 급여를 출력하고, 회원들의 급여 합계도 출력
DECLARE
    total NUMBER := 0;
    CURSOR c1 IS
        SELECT ename, sal
        FROM emp;
BEGIN
    dbms_output.put_line('이름        급여');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(v_emp.ename || ' ' || TO_CHAR(v_emp.sal, '999,999'));
            total := total + v_emp.sal;
        END LOOP;
    dbms_output.put_line('급여 합계: ' || TO_CHAR(total, '999,999'));
END;
/
--다른 방법
DECLARE
    total NUMBER := 0;
    CURSOR c1 IS
        SELECT ename, sal
        FROM emp;
BEGIN
    dbms_output.put_line('이름    급여');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(v_emp.ename || TO_CHAR(v_emp.sal, '999,999'));
        END LOOP;
        SELECT sum(sal) INTO total FROM emp;
        dbms_output.put_line('급여 합계:' || TO_CHAR(total, '999,999'));
END;
/
--
SELECT ename, sal FROM emp ORDER BY sal DESC;
--PL/SQL로 사원별 급여현황(급여의 내립차순으로 출력)
--이름 별표(100당 별표 하나)
--예: JAMES **********(950)
DECLARE
    CURSOR c1 IS
        SELECT ename, sal FROM emp ORDER BY sal DESC;
BEGIN
    dbms_output.put_line(RPAD('이름', 12) || '급여');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(
                RPAD(v_emp.ename, 10) || ' ' || RPAD('*', ROUND(v_emp.sal / 100), '*') || '(' || v_emp.sal || ')'
            );
        END LOOP;
END;
/
--위 문제에서 급여 2000 이상인 사원만 보여달라 그러면?
DECLARE
    CURSOR c1 IS
        SELECT ename, sal FROM emp WHERE sal >= 2000 ORDER BY sal DESC;
BEGIN
    dbms_output.put_line(RPAD('이름', 12) || '급여');
    FOR v_emp IN c1
        LOOP
            dbms_output.put_line(
                RPAD(v_emp.ename, 10) || ' ' || RPAD('*', ROUND(v_emp.sal / 100), '*') || '(' || v_emp.sal || ')'
            );
        END LOOP;
END;
/
--또는 begin절에서 처리할수도 있음
DECLARE
    CURSOR c1 IS
        SELECT ename, sal FROM emp ORDER BY sal DESC;
BEGIN
    dbms_output.put_line(RPAD('이름', 12) || '급여');
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

--p.462 하나의 데이터를 저장 => 커서 사용
-- OPEN FETCH CLOSE 방식 사용
DECLARE
--  명시적 커서 선언
    CURSOR c IS
        SELECT deptno, dname, loc
        FROM dept
        WHERE deptno = 40;
    v_dept_row dept%ROWTYPE;
BEGIN
--  커서 열기
    OPEN c;
--  커서로부터 읽어온 데이터 사용(FETCH)
    FETCH c INTO v_dept_row;
    dbms_output.put_line('deptno: ' || v_dept_row.deptno);
    dbms_output.put_line('dname: ' || v_dept_row.dname);
    dbms_output.put_line('loc: ' || v_dept_row.loc);
--  커서 닫기
    CLOSE c;
END;
/
-- FOR문 사용
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
-- CURSOR 사용하지 않기
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