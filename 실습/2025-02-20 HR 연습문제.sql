SET SERVEROUTPUT ON;
--1. employees 테이블
--employee_id = 200인 사원의 모든 정보를 추출해서
--아이디, 이름, 입사일 출력
--PL/SQL로 작성
DECLARE
    v_emp employees%ROWTYPE;
BEGIN
    SELECT * INTO v_emp
    FROM employees
    WHERE employee_id = 200;
    dbms_output.put_line('아이디: ' || v_emp.employee_id);
    dbms_output.put_line('이름: ' || v_emp.first_name);
    dbms_output.put_line('입사일: ' || v_emp.hire_date);
END;
/

--2. employees에서 department_id, first_name, salary, phone_number, 기타를 출력하되
--급여는 천단위 분리 기호 사용
--기타: 급여가 5000 이하인 경우 '저임금'
--5000 ~ 10000 '보통임금'
--10000 초과 '고임금'
DECLARE
    note VARCHAR2(50) := NULL;
    CURSOR c IS
        SELECT department_id, first_name, salary, phone_number
        FROM employees;
BEGIN
    dbms_output.put_line(
                RPAD('부서 ID', 11) || RPAD('이름', 16) || RPAD('임금', 11) || RPAD('전화번호', 21) || '비고'
            );
    FOR i IN c
        LOOP
            CASE
                WHEN i.salary <= 5000 THEN
                    note := '저임금';
                WHEN i.salary BETWEEN 5000 AND 10000 THEN
                    note := '보통임금';
                WHEN i.salary > 10000 THEN
                    note := '고임금';
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
--SQL문에 CASE문 쓰기
DECLARE
    note VARCHAR2(50) := NULL;
    CURSOR c IS
        SELECT
            department_id, first_name, salary, phone_number,
            CASE
                WHEN salary <= 5000 THEN '저임금'
                WHEN salary BETWEEN 5000 AND 10000 THEN '보통임금'
                WHEN salary > 10000 THEN '고임금'
            END AS note
        FROM employees
        ORDER BY department_id;
BEGIN
    dbms_output.put_line(
                RPAD('부서 ID', 11) || RPAD('이름', 16) || RPAD('임금', 11) || RPAD('전화번호', 21) || '비고'
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