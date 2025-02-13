-- 1. student 테이블에서 각 학년별 최대 몸무게를 가진 학생의
-- 학년, 이름, 몸무게 출력
SELECT grade, max(weight), name, weight
FROM student
WHERE weight IN(SELECT max(weight)
                FROM student
                GROUP BY grade)
GROUP BY grade, name, weight;

-- 2. professor, department 테이블
-- 각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름, 학과명 출력
-- 단, 입사일은 오름차순으로
-- NATURAL JOIN
SELECT
    min(hiredate), profno, name, dname
FROM professor
    NATURAL JOIN department
WHERE
    hiredate IN(
        SELECT min(hiredate)
        FROM professor
        GROUP BY deptno
        )
GROUP BY profno, name, dname;
-- JOIN USING
SELECT
    min(hiredate), profno, name, dname
FROM professor
    JOIN department USING(deptno)
WHERE
    hiredate IN(
        SELECT min(hiredate)
        FROM professor
        GROUP BY deptno
        )
GROUP BY profno, name, dname;

-- 3. emp2 테이블
-- 'Section head'(position) 직급의 최소 연봉자보다
-- 연봉이 높은 사람의 name, position, pay 출력
SELECT name, position, TO_CHAR(pay, '999,999,999') 연봉
FROM emp2
WHERE
    pay > (
        SELECT min(pay)
        FROM emp2
        GROUP BY position
        HAVING position = 'Section head'
        );

-- 4. employees 테이블
-- 부서번호가 80보다 큰 부서의
-- employee_id, 사원이름first_name, 매니저이름first_name 출력
SELECT
    emp.employee_id, emp.first_name, mgr.first_name, emp.department_id
FROM employees emp
    JOIN employees mgr
        ON emp.manager_id = mgr.employee_id
WHERE emp.department_id > 80;

-- 5. student, professor 테이블
-- 모든 학생 출력(지도교수가 없는 학생도 출력)
-- 학생이름name, 교수이름name
SELECT student.name, professor.name
FROM student
    LEFT OUTER JOIN professor
        ON student.profno = professor.profno;