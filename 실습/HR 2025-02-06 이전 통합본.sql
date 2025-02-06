--@C:\JHM\DATABASE\hr_table.sql;

-- 1. employees 테이블 모든 정보 조회
SELECT * FROM employees;

-- 2. departments 테이블 모든 정보 조회
SELECT * FROM departments;

-- 3. employees 테이블에서 first_name 조회
SELECT first_name FROM employees;

-- 4. employees 테이블에서 department_id가 30번인 first_name만 조회
SELECT first_name FROM employees
WHERE department_id = 30;

-- 5. employees 테이블에서 연봉(salary)이 9000 이상인 사람의 first_name만 조회
-- 단, 연봉(salary)이 높은 순으로 출력
SELECT first_name FROM employees
WHERE salary >= 9000
ORDER BY salary DESC;

-- 6. employees 테이블에서 연봉이 9000 이상이고,
-- 부서번호(department_id)가 30번인 사람의 first_name 조회
SELECT first_name, salary, department_id FROM employees
WHERE
    salary >= 9000
    AND
    department_id = 30;

-- 7. employees 테이블에서 연봉(salary)이 9000 이상이거나,
-- 부서번호(department_id)가 30번인 사람의 first_name 조회
SELECT first_name, salary, department_id FROM employees
WHERE
    salary >= 9000
    OR
    department_id = 30;
    
-- 8. 부서번호가 20이 아닌 사람의 first_name, department_id 조회
SELECT first_name, department_id FROM employees
WHERE NOT department_id = 20;

-- 9. job_id가 PU_CLERK거나 ST_MAN거나 SA_MAN인 사람의
-- first_name과 job_id 출력
SELECT first_name, job_id FROM employees
WHERE job_id IN ('PU_CLERK', 'ST_MAN', 'SA_MAN');

-- 10. 부서번호가 100인 사원의 first_name, first_name의 첫글자, 부서번호 출력
SELECT first_name, SUBSTR(first_name, 1, 1) AS first_letter, department_id
FROM employees
WHERE department_id = 100;

-- 11. 부서번호가 100인 사원의 first_name을 10글자로 표현하되, 왼쪽을 '*'로 채우기
SELECT RPAD(first_name, 10, '*')
FROM employees
WHERE department_id = 100;

-- 12. 부서번호가 100인 사원의 first_name의 두글자만 출력하고, 나머지는 '*'로 채우기
SELECT RPAD(SUBSTR(first_name, 1, 2), LENGTH(first_name), '*') AS first_name
FROM employees
WHERE department_id = 100;

------------------------------------------------------------------------------------------

-- professor 테이블
-- 1. professor 테이블 name과 deptno, 학과명 출력
-- 단, deptno = 101이면 '컴퓨터공학과'



