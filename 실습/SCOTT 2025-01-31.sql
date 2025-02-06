-- DISTINCT(): 중복 제외 함수
SELECT sal FROM emp;
SELECT DISTINCT(sal) FROM emp;

-- p.177
-- 그룹 함수
-- SUM(): 열의 총합을 구하는 함수
SELECT sal, comm FROM emp;
SELECT SUM(sal) FROM emp;
SELECT SUM(sal), comm FROM emp; -- 행 갯수가 달라서 출력 불가
SELECT SUM(sal), SUM(comm) FROM emp; -- null은 알아서 안 더함

-- COUNT(): 행 갯수를 구하는 함수
SELECT COUNT(sal) FROM emp;
SELECT COUNT(comm) FROM emp; -- null은 알아서 안 셈
SELECT COUNT(DISTINCT(sal)) FROM emp;
SELECT COUNT(empno) FROM emp;
SELECT COUNT(*) FROM emp; -- null을 고려 안한다면 어차피 모든 열의 행 갯수는 같으니까...

-- 부서번호(deptno)가 30번인 사원 수
SELECT COUNT(*) FROM emp
WHERE deptno = 30;

-- null이 아닌 comm의 갯수
SELECT COUNT(comm) FROM emp;

-- null인 comm의 갯수
SELECT COUNT(*) FROM emp -- COUNT(comm)으로 하면 0이 나옴... 당연함 COUNT()는 null을 안 셈
WHERE comm IS NULL;

--
SELECT COUNT(sal), COUNT(DISTINCT(sal)), COUNT(ALL(sal)) -- COUNT(sal)이랑 걍 같음
FROM emp;

-- MAX(): 열 데이터 중에서 최대값 출력
-- MIN(): 최소값 출력
-- AVG(): 평균값 출력
SELECT MAX(sal), MIN(sal) FROM emp;
SELECT SUM(sal), COUNT(sal), ROUND(AVG(sal), 1) FROM emp;

-- 부서번호가 20인 사원 중에서 입사일이 가장 최근인 사원 출력
SELECT MAX(hiredate) FROM emp
WHERE deptno = 20;

-- professor 테이블
SELECT * FROM professor;
-- 1. 총 교수 수 출력
SELECT COUNT(*) FROM professor;
-- 2. 교수 급여 합계 출력
SELECT SUM(pay) FROM professor;
-- 3. 교수 급여 평균 출력
SELECT AVG(pay) FROM professor;
-- 4. 교수 급여 평균을 소수점 첫째 자리에서 반올림
SELECT ROUND(AVG(pay), 0) FROM professor;
-- 5. 최고 급여
SELECT MAX(pay) FROM professor;
-- 6. 최저 급여
SELECT MIN(pay) FROM professor;
-- 7. 교수 중 최고 급여를 받는 교수의 이름과 급여를 출력
SELECT name, pay FROM professor
WHERE pay = (SELECT MAX(pay) FROM professor); -- 서브 쿼리 / 인라인 SQL
-- 8. 교수 급여 합계를 출력, 천 단위 쉼표 출력
SELECT TO_CHAR(SUM(pay), '999,999') FROM professor;

-- emp 테이블
-- 1. 부서번호가 10번인 사원의 평균 급여
-- 2. 부서번호가 20번인 사원의 평균 급여
-- 3. 부서번호가 30번인 사원의 평균 급여
SELECT AVG(sal) FROM emp WHERE deptno = 10;
SELECT AVG(sal) FROM emp WHERE deptno = 20;
SELECT AVG(sal) FROM emp WHERE deptno = 30;
-- 4. 부서번호가 10, 20, 30번인 사원의 평균 급여
-- 집합연산자 사용
SELECT AVG(sal) FROM emp WHERE deptno = 10
UNION
SELECT AVG(sal) FROM emp WHERE deptno = 20
UNION
SELECT AVG(sal) FROM emp WHERE deptno = 30; -- 이건 3개의 행으로 따로따로 출력하는 거
SELECT AVG(sal) FROM emp WHERE deptno IN (10, 20, 30); -- 이건 10, 20, 30번 부서 사원 전부의 합계
-- 5. 부서별 평균 급여 출력 (GROUP BY)
SELECT deptno AS 부서번호, AVG(sal) AS 부서별_평균_급여 FROM emp
GROUP BY deptno -- GROUP BY로 묶은 컬럼은 SELECT로 출력 가능
ORDER BY 부서번호;

-- p.177
-- 그룹 함수 = 복수 행 함수 = 다중 행 함수
-- 복수(다중)의 출력 결과를 하나의 열에 담는다는 뜻

-- 부서별 및 직급별 평균 급여
SELECT deptno, job, ROUND(AVG(sal)) AS avg_sal FROM emp
GROUP BY deptno, job
ORDER BY deptno DESC, avg_sal DESC;

-- professor 테이블
-- 1. 학과별 교수들의 평균 급여 출력
SELECT deptno, ROUND(AVG(pay)) FROM professor GROUP BY deptno;
-- 2. 학과별 교수들의 급여 합계 출력
SELECT deptno, SUM(pay) FROM professor GROUP BY deptno;
-- 3. 학과 및 직급별 교수들의 평균 급여 출력
SELECT deptno, position, ROUND(AVG(pay)) FROM professor GROUP BY deptno, position;
-- 4. 교수 중에서 급여와 보직수당을 합친 금액이 가장 많은 경우와 가장 적은 경우 출력
-- 단, bonus가 없는 교수의 급여의 경우는 0으로 계산
-- 합친 금액은 소수 둘째 자리에서 반올림
SELECT
    MAX(ROUND(pay + NVL(bonus, 0), 1)) AS 최대급여,
    MIN(ROUND(pay + NVL(bonus, 0), 1)) AS 최소급여
FROM professor;
-- 5. 직급별 평균 급여가 300보다 크면 '우수', 300보다 작거나 같으면 '보통' 출력
-- 열 이름은 직급, 평균급여, 비고로 출력
SELECT
    position AS 직급,
    ROUND(AVG(pay)) AS 평균급여,
    CASE
        WHEN AVG(pay) > 500 THEN '왜케 많이 줌?'
        WHEN AVG(pay) > 300 THEN '좀 더 주셈'
        ELSE '굶어죽겠음'
        END AS 비고
FROM professor
GROUP BY position;

-- emp 테이블
-- 입사년도별 인원수
-- 열 이름: total 1980년도 1981년도 1982년도
-- 1) SUM() 사용
SELECT
    COUNT(*) AS total,
    SUM(DECODE(TO_CHAR(hiredate, 'yyyy'), 1980, 1, 0)) AS "1980년도",
    SUM(DECODE(TO_CHAR(hiredate, 'yyyy'), 1981, 1, 0)) AS "1981년도",
    SUM(DECODE(TO_CHAR(hiredate, 'yyyy'), 1982, 1, 0)) AS "1982년도"
FROM emp;
-- 2) COUNT() 사용
SELECT
    COUNT(*) AS total,
    COUNT(DECODE(TO_CHAR(hiredate, 'yyyy'), 1980, 2, null)) AS "1980년도",
    COUNT(DECODE(TO_CHAR(hiredate, 'yyyy'), 1981, 3, null)) AS "1981년도",
    COUNT(DECODE(TO_CHAR(hiredate, 'yyyy'), 1982, 4, null)) AS "1982년도"
FROM emp;

-- emp 테이블에서 1000 이상의 급여를 가지는 사원에 대해서 부서별 평균을 구하되,
-- 그 부서별 평균이 2000 이상인 부서번호, 부서별 평균급여 출력
SELECT deptno, ROUND(AVG(sal))
FROM emp
WHERE sal >= 1000
GROUP BY deptno
HAVING AVG(sal) >= 2000; -- HAVING: GROUP BY에 대한 조건문

-- professor 테이블에서,
-- 1. 학과별로 소속 교수들의 평균 급여, 최소 급여, 최대 급여 구하기
-- 단, 평균 급여가 300이 넘는 데이터만 출력
SELECT deptno, AVG(pay), MIN(pay), MAX(pay)
FROM professor
GROUP BY deptno;

-- 2. 학과 및 직급별 교수들의 평균 급여 출력
-- 단, 평균 급여가 400 이상인 데이터에 대해서만 학과번호, 직급, 평균급여 출력
SELECT deptno AS "학과번호", position AS "직급", AVG(pay) AS "평균급여"
FROM professor
GROUP BY deptno, position
HAVING AVG(pay) >= 400;

-- student 테이블에서,
-- 3. 학년별 학생 수, 평균 키, 평균 몸무게를 출력
-- 단, 학생수가 4명 이상인 데이터만 출력
-- 평균 키, 평균 몸무게는 소수점 첫째 자리에서 반올림
-- 출력 순서는 평균 키에서 내림차순.
SELECT grade, COUNT(*) AS "학생 수", ROUND(AVG(height)) AS "평균 키", ROUND(AVG(weight)) AS "평균 몸무게"
FROM student
GROUP BY grade
HAVING COUNT(*) >= 4
ORDER BY AVG(height) DESC;

-- p.196
-- ROLLUP(A, B): A, B 및 A에 대한 소계를 출력시키는 함수
SELECT deptno, job, COUNT(*), MAX(sal), MIN(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY ROLLUP(deptno, job)
ORDER BY deptno, job;

-- CUBE(A, B): A, B 및 A 및 B에 대한 소계를 출력시키는 함수
SELECT deptno, job, COUNT(*), MAX(sal), MIN(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;

-- ROLLUP(A, B, C) -> A, B, C / A, B / C / A에 대한 소계 출력
-- CUBE(A, B, C) -> A, B, C / A, B / A, C / B, C / A / B / C에 대한 소계 출력

-- emp 테이블에서,
-- 부서와 직급별 평균 급여 및 사원 수 구하기
-- 단, 부서별 평균급여와 사원 수, 전체 사원의 평균급여와 사원 수도 출력
SELECT deptno, job, ROUND(AVG(sal)), COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno, job) -- 부서별 소계 -> 전체 소계
ORDER BY deptno, job;
SELECT job, deptno, ROUND(AVG(sal)), COUNT(*)
FROM emp
GROUP BY ROLLUP(job, deptno)
ORDER BY job, deptno; -- 직급별 소계 -> 전체 소계

-- 부서 및 직급별 평균 급여와 사원 수를 출력
-- 단, 부서별 평균 급여와 사원 수 출력 / 직급별 평균 급여와 사원 수 출력 / 전체 사원 평균 급여와 사원 수 출력
SELECT deptno, job, ROUND(AVG(sal)), COUNT(*)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;

---------------------------------------------------------------------------------------

-- p.215 JOIN
SELECT * FROM emp;
SELECT * FROM dept;

-- SMITH의 부서명을 dept 테이블에서 구하여 출력
SELECT deptno FROM emp WHERE ename = 'SMITH';
SELECT dname FROM dept WHERE deptno = 20;
SELECT dname FROM dept WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');

--------------------------------------------------------------------------------------
SELECT * FROM emp e, dept d;
--------------------------------------------------------------------------------------

-- 등가JOIN
SELECT * FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- 사원번호, 사원이름, 직급, 부서명, 지역을 등가조인
SELECT empno, ename, job, dname, loc, e.deptno, d.deptno -- empno같은 애들은 조인해도 1종류밖에 없으니 e.이런거 생략해도 상관없음
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--------------------------------------------------------------------------------------
SELECT * FROM emp e, salgrade s;
--------------------------------------------------------------------------------------

-- 비등가JOIN
SELECT * 
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

-- SMITH 사원의 상사의 이름을 출력
-- 1) 서브 쿼리 사용
SELECT ename
FROM emp 
WHERE empno = (SELECT mgr FROM emp WHERE ename = 'SMITH');

-- 2) 조인 사용(셀프 조인 / 자체 조인)
SELECT e1.empno AS 사원번호, e1.ename AS 사원이름, e1.mgr AS 상사번호,
    e2.empno AS 상사사원번호, e2.ename AS 상사이름
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno
ORDER BY e1.empno;