-- Q1.
SELECT job, empno, ename, sal, deptno, dname
FROM emp NATURAL JOIN dept
WHERE
    job = (
        SELECT job
        FROM emp
        WHERE ename = 'ALLEN'
        );
        
-- Q2.
SELECT
    empno, ename, dname, hiredate, loc, sal, grade
FROM emp
    NATURAL JOIN dept
    JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
WHERE
    sal > (
        SELECT avg(sal)
        FROM emp
        )
ORDER BY sal DESC, empno;

-- Q3.
SELECT
    empno, ename, job, deptno, dname, loc
FROM emp
    NATURAL JOIN dept
WHERE
    deptno = 10
    AND
    job NOT IN(
        SELECT job
        FROM emp
        WHERE deptno = 30
        );
        
-- Q4.
-- 다중 행 함수를 사용하지 않는 방법
SELECT
    empno, ename, sal, grade
FROM emp
    JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
WHERE
    sal > (
        SELECT max(sal)
        FROM emp
        WHERE job = 'SALESMAN'
        )
ORDER BY empno;
-- 다중 행 함수를 사용하는 방법
SELECT
    empno, ename, sal, grade
FROM emp
    JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
WHERE
    sal > ALL(
        SELECT sal
        FROM emp
        WHERE job = 'SALESMAN'
        )
ORDER BY empno;