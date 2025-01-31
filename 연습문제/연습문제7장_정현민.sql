-- p.212 7장 연습문제
-- Q1.
SELECT
    deptno,
    TRUNC(AVG(sal)) AS avg_sal,
    MAX(sal) AS max_sal,
    MIN(sal) AS min_sal,
    COUNT(*) AS cnt
FROM emp
GROUP BY deptno
ORDER BY deptno DESC;    

-- Q2.
SELECT job, COUNT(*)
FROM emp
GROUP BY job
HAVING COUNT(*) >= 3;

-- Q3.
SELECT
    TO_CHAR(hiredate, 'yyyy') AS hire_year,
    deptno,
    COUNT(*) AS cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy'), deptno
ORDER BY TO_CHAR(hiredate, 'yyyy') DESC, deptno;

-- Q4.
SELECT
    NVL2(comm, 'O', 'X') AS exist_comm,
    COUNT(*) AS cnt
FROM emp
GROUP BY NVL2(comm, 'O', 'X');

-- Q5.
SELECT
    deptno,
    TO_CHAR(hiredate, 'yyyy') AS hire_year,
    COUNT(*) AS cnt,
    MAX(sal) AS max_sal,
    SUM(sal) AS sum_sal,
    AVG(sal) AS avg_sal
FROM emp
GROUP BY ROLLUP(deptno, TO_CHAR(hiredate, 'yyyy'))
ORDER BY deptno, TO_CHAR(hiredate, 'yyyy');