-- 1. EMP 테이블에서 사원이름이(ENAME)이 S로 끝나는 사원의 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%S';

-- 2. EMP 테이벌에서 30번 부서 중 직책(JOB)이 SALESMAN인
-- 사원번호(EMPNO), 이름(ENAME), 직책(JOB), 급여(SAL), 부서번호(DEPTNO)를 조회
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE deptno = 30 AND job = 'SALESMAN';

-- 3. 20번, 30번 부서에 근무하면서, 급여가 2000을 초과하는 사원의
-- 사원번호(EMPNO), 이름(ENAME), 직책(JOB), 급여(SAL), 부서번호(DEPTNO)를 조회
--  1) 집합연산자 사용 시
SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno = 20
UNION
SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno = 30
INTERSECT
SELECT empno, ename, job, sal, deptno FROM emp WHERE SAL > 2000;

--  2) 집합연산자 미사용 시
SELECT empno, ename, job, sal, deptno FROM emp
WHERE deptno IN (20, 30) AND sal > 2000;

-- 4. 급여가 2000이상 3000이하 범위 이외의 데이터를 조회
-- 단, NOT BETWEEN A AND B 연산자를 쓰지 않음
SELECT * FROM emp WHERE sal < 2000 OR sal > 3000;

-- 5. 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중
-- 급여가 1000~2000 사이가 아닌
-- 사원이름(ENAME), 사원번호(EMPNO), 급여(SAL), 부서번호(DEPTNO) 조회
SELECT ename, empno, sal, deptno
FROM emp
WHERE
    ename LIKE '%E%'
    AND
    deptno = 30
    AND
    sal NOT BETWEEN 1000 AND 2000;

-- 6. 추가 수당(COMM)이 존재하지 않고, 상급자가 있고, 직책이 MANAGER, CLERK인 사원 중에서
-- 사원 이름의 두 번째 글자가 L이 아닌 사원의 정보를 조회
SELECT *
FROM emp
WHERE
    comm IS NULL
    AND
    mgr IS NOT NULL
    AND
    job IN ('MANAGER', 'CLERK')
    AND
    ename NOT LIKE '_L%';