-- 1. ACCOUNTING(dname) 부서 소속 사원의 이름과 입사일 출력
-- Oracle 문법
SELECT * FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    AND dname = 'ACCOUNTING';
-- SQL-99 표준 문법
SELECT *
FROM emp JOIN dept ON emp.deptno = dept.deptno
WHERE dname = 'ACCOUNTING';

-- 2. 0보다 많은 comm을 받는 사원이름과 부서명 출력
SELECT ename, dname, comm
FROM emp JOIN dept ON emp.deptno = dept.deptno
WHERE
    comm IS NOT NULL
    AND comm > 0;
-- Oracle 문법
SELECT ename, dname, comm
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    AND comm IS NOT NULL
    AND comm > 0;

-- 3. 누구의 매니저는 누구입니다
-- ex) SMITH의 매니저는 FORD입니다.
SELECT emp.ename || '의 매니저는 ' || mgr.ename || '입니다.' AS col
FROM emp emp JOIN emp mgr ON emp.mgr = mgr.empno;
-- Oracle 문법
SELECT emp.ename || '의 매니저는 ' || mgr.ename || '입니다.' AS col
FROM emp emp, emp mgr
WHERE
    emp.mgr = mgr.empno;
    
-----------------------------------------------------------------------------------------------------------------------------------

-- 1. emp, dept 테이블에서,
-- 뉴욕에서 근무하는 사원의 이름(ename), 급여(sal)를 출력
SELECT
    loc 근무지역, ename 이름, sal 급여
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE
    loc = 'NEW YORK';
    
-- 2. emp 테이블에서,
-- 매니저(mgr)의 이름이 KING인 사원들의 이름과 직급을 출력
SELECT
    mgr.ename 매니저, emp.ename 사원, emp.job 직급
FROM emp emp
    JOIN emp mgr
        ON emp.mgr = mgr.empno
WHERE
    mgr.ename = 'KING';
-- 서브 쿼리 사용
SELECT
    ename 사원, job 직급
FROM emp 
WHERE
    mgr =
        (
            SELECT empno
            FROM emp
            WHERE ename = 'KING'
        );

-- 3. emp 테이블에서.
-- SMITH와 같은 부서에 있는 동료의 이름을 출력
SELECT ename
FROM emp
WHERE
    deptno =
        (
            SELECT deptno
            FROM emp
            WHERE ename = 'SMITH'
        )
    AND
    NOT ename = 'SMITH';
-- 셀프 조인 사용
SELECT e1.ename
FROM emp e1
    JOIN emp e2
        ON e1.deptno = e2.deptno
WHERE
    e2.ename = 'SMITH'
    AND
    NOT e1.ename = 'SMITH';
-- 셀프 조인 오라클 문법
SELECT e1.ename
FROM emp e1, emp e2
WHERE
    e1.deptno = e2.deptno
    AND
    e2.ename = 'SMITH'
    AND
    NOT e1.ename = 'SMITH';
    
-- p.229
-- emp 테이블
-- 사원번호, 사원이름, 상사, 상사사원번호, 상사이름
SELECT
    e1.empno 사원번호, e1.ename 사원이름, e1.mgr 상사, e2.empno 상사사원번호, e2.ename 상사이름
FROM emp e1
    JOIN emp e2
        ON e1.mgr = e2.empno
ORDER BY e1.empno;
-- e1.mgr의 값이 null인 KING이 출력이 되지 않음

-- 외부 조인(outer join)
-- 모든 사원에 대해 사원번호, 사원이름, 상사, 상사사원번호, 상사이름 출력
-- null을 포함한 모든 데이터가 나와야만 하는 emp를 기준으로 OUTER JOIN이 들어가야 함
-- 모든 데이터가 나와야만 하는 emp(e1)를 왼쪽에 적었을 경우
SELECT
    e1.empno 사원번호, e1.ename 사원이름, e1.mgr 상사, e2.empno 상사사원번호, e2.ename 상사이름
FROM emp e1
    LEFT OUTER JOIN emp e2
        ON e1.mgr = e2.empno
ORDER BY e1.empno;
-- 모든 데이터가 나와야만 하는 emp(e1)를 오른쪽에 적었을 경우
SELECT
    e1.empno 사원번호, e1.ename 사원이름, e1.mgr 상사, e2.empno 상사사원번호, e2.ename 상사이름
FROM emp e1
    RIGHT OUTER JOIN emp e2
        ON e2.mgr = e1.empno
ORDER BY e2.empno;
-- null값이 부족한 테이블에 null값을 채워주는 경우
SELECT
    e1.empno 사원번호, e1.ename 사원이름, e1.mgr 상사, e2.empno 상사사원번호, e2.ename 상사이름
FROM emp e1
    JOIN emp e2
        ON e1.mgr = e2.empno(+)
ORDER BY e1.empno;
-- 오라클 문법
SELECT
    e1.empno 사원번호, e1.ename 사원이름, e1.mgr 상사, e2.empno 상사사원번호, e2.ename 상사이름
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno(+)
ORDER BY e1.empno;

-- 모든 부서의 사원이름(ename), 부서번호(deptno), 부서명(dname) 출력
SELECT
    ename, dept.deptno, dname
FROM emp
    RIGHT OUTER JOIN dept
        ON emp.deptno = dept.deptno;
-- 오라클 문법
SELECT
    ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;

-- p.232
-- sal 2000보다 큰 사원번호, 이름, 급여, 상사, 부서번호, 부서명, 지역 출력
SELECT
    e1.empno 사원번호, e1.ename 이름, e1.sal 급여, e2.ename 상사,
    dept.deptno 부서번호, dept.dname 부서명, dept.loc 지역
FROM emp e1
    JOIN emp e2
        ON e1.mgr = e2.empno
    JOIN dept
        ON e1.deptno = dept.deptno
WHERE e1.sal > 2000;
-- NATURAL JOIN: 공통 컬럼으로 자동으로 JOIN시켜주는 명령어
SELECT
    empno 사원번호, ename 이름, sal 급여, ename 상사,
    deptno 부서번호, dname 부서명, loc 지역
FROM emp
    NATURAL JOIN dept
WHERE sal > 2000;
-- JOIN USING(공통된 열)
SELECT
    empno 사원번호, ename 이름, sal 급여, ename 상사,
    deptno 부서번호, dname 부서명, loc 지역
FROM emp
    JOIN dept USING(deptno)
WHERE sal > 2000;
-- p.240 JOIN ON(제일 많이 쓰는 방법)
SELECT
    empno 사원번호, ename 이름, sal 급여, ename 상사,
    dept.deptno 부서번호, dname 부서명, loc 지역
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE sal > 2000;

-- p.238
-- emp, dept 테이블에서,
-- empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc 출력
-- 단, 급여(sal)가 2000 이상이며, 상사(mgr)를 반드시 포함시켜야 한다
-- 1) JOIN USING() 사용
SELECT *
FROM emp
    JOIN dept USING(deptno)
WHERE
    sal >= 2000
    AND
    mgr IS NOT NULL;

-- 2) NATURAL JOIN 사용
SELECT *
FROM emp
    NATURAL JOIN dept
WHERE
    sal >= 2000
    AND
    mgr IS NOT NULL;

-- 3) JOIN ON 사용
SELECT
    empno, ename, job, mgr, hiredate, sal, comm,
    dept.deptno, dname, loc
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE
    sal >= 2000
    AND
    mgr IS NOT NULL;
    

-- p.242
-- WARD 사원보다 월급을 많이 받는 사원 이름 출력
SELECT ename, sal
FROM emp
WHERE sal >= (SELECT sal
            FROM emp
            WHERE ename = 'WARD')
ORDER BY sal;

-- 'ALLEN'의 직무와 같은 사람의 이름, 부서명, 급여, 직무 출력
SELECT ename, dname, sal, job
FROM emp
    NATURAL JOIN dept
WHERE
    job = (SELECT job
            FROM emp
            WHERE ename = 'ALLEN')
    AND NOT ename = 'ALLEN';
    
-- 전체 사원의 평균임금보다 임금을 많이 받는 사람의 사원번호, 이름, 부서명, 입사일 출력
SELECT empno, ename, dname, hiredate
FROM emp
    NATURAL JOIN dept
WHERE
    sal > (SELECT avg(sal)
            FROM emp);
-- ALLEN보다 일찍 입사한 사원의 정보
SELECT *
FROM emp
WHERE hiredate < (SELECT hiredate
                    FROM emp
                    WHERE ename = 'ALLEN');
                    
-- p.248
-- 전체 사원의 평균급여보다 작거나 같은 급여를 받는 20번 부서의 사원 및 부서정보
-- empno, ename, job, sal, deptno, dname, loc
-- 오라클 문법
SELECT
    emp.empno, emp.ename, emp.job, emp.sal,
    dept.deptno, dept.dname, dept.loc
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    AND
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    deptno = 20;

-- NATURAL JOIN 사용
SELECT empno, ename, job, sal, deptno, dname, loc
FROM emp
    NATURAL JOIN dept
WHERE
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    deptno = 20;
    
-- JOIN USING 사용
SELECT empno, ename, job, sal, deptno, dname, loc
FROM emp
    JOIN dept USING(deptno)
WHERE
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    deptno = 20;
    
-- JOIN ON 사용
SELECT
    emp.empno, emp.ename, emp.job, emp.sal,
    dept.deptno, dept.dname, dept.loc
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    dept.deptno = 20;

-- 다중행 서브쿼리
-- 각 부서별 최고급여와 동일한 급여를 받는 사원 정보 출력
SELECT *
FROM emp
WHERE
    sal IN (SELECT max(sal)
            FROM emp
            GROUP BY deptno);