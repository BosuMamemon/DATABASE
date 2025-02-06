-- p.239 ~ 240
-- Q1.
-- SQL 99 이전 방식
SELECT dept.deptno deptno, dname, empno, ename, sal
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    AND
    sal > 2000
ORDER BY deptno;
-- SQL 99
SELECT deptno, dname, empno, ename, sal
FROM emp NATURAL JOIN dept
WHERE
    sal > 2000
ORDER BY deptno;

-- Q2.
-- sql99 이전
SELECT
    emp.deptno, dname, TRUNC(avg(sal)) avg_sal, max(sal) max_sal, min(sal) min_sal, count(*) cnt
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
GROUP BY emp.deptno, dname
ORDER BY emp.deptno;
-- sql99 이후
SELECT
    deptno, dname, TRUNC(avg(sal)) avg_sal, max(sal) max_sal, min(sal) min_sal, count(*) cnt
FROM emp NATURAL JOIN dept
GROUP BY deptno, dname
ORDER BY deptno;

--Q3.
-- sql99 이전
SELECT dept.deptno, dname, empno, ename, job, sal
FROM emp, dept
WHERE
    emp.deptno(+) = dept.deptno
ORDER BY dept.deptno;
-- sql99 이후
SELECT deptno, dname, empno, ename, job, sal
FROM emp NATURAL RIGHT OUTER JOIN dept
ORDER BY deptno;

-- Q4.
-- sql99 이전
SELECT
    dept.deptno, dept.dname,
    emp.empno, emp.ename, emp.mgr, emp.sal, emp.deptno,
    salgrade.losal, salgrade.hisal, salgrade.grade,
    mgr.empno, mgr.ename
FROM dept, emp emp, salgrade, emp mgr
WHERE
    dept.deptno = emp.deptno(+)
    AND emp.sal BETWEEN salgrade.losal(+) AND salgrade.hisal(+)
    AND emp.mgr = mgr.empno(+)
ORDER BY dept.deptno, emp.empno;
-- sql99 이후
SELECT
    dept.deptno, dept.dname,
    emp.empno, emp.ename, emp.mgr, emp.sal,
    salgrade.losal, salgrade.hisal, salgrade.grade,
    mgr.empno, mgr.ename
FROM dept
    LEFT OUTER JOIN emp emp
        ON dept.deptno = emp.deptno
    LEFT OUTER JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
    LEFT OUTER JOIN emp mgr
        ON emp.mgr = mgr.empno
ORDER BY dept.deptno, emp.empno;