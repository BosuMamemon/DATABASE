-- p.174 ~ 175
-- Q1.
SELECT empno,
    RPAD(SUBSTR(empno, 1, 2), LENGTH(empno), '*') AS masking_empno,
    ename,
    RPAD(SUBSTR(ename, 1, 1), LENGTH(ename), '*') AS masking_ename
FROM emp
WHERE LENGTH(ename) >= 5
    AND LENGTH(ename) < 6;
    
-- Q2.
SELECT empno, ename, sal,
    TRUNC(sal / 21.5, 2) AS day_pay,
    ROUND(sal / 21.5 / 8, 1) AS time_pay
FROM emp;

-- Q3.
SELECT empno, ename,
    TO_CHAR(hiredate, 'yyyy/mm/dd') AS hiredate,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hiredate, 3), '¿ù'), 'yyyy-mm-dd') AS r_job,
    NVL(TO_CHAR(comm), 'N/A') AS comm
FROM emp;

-- Q4.
-- CASE¹®
SELECT empno, ename, NVL(TO_CHAR(mgr), ' ') AS mgr,
    CASE
        WHEN mgr IS NULL THEN '0000'
        WHEN SUBSTR(mgr, 1, 2) = '75' THEN '5555'
        WHEN SUBSTR(mgr, 1, 2) = '76' THEN '6666'
        WHEN SUBSTR(mgr, 1, 2) = '77' THEN '7777'
        WHEN SUBSTR(mgr, 1, 2) = '78' THEN '8888'
        ELSE TO_CHAR(mgr)
        END AS chg_mgr
FROM emp;
-- DECODE¹®
SELECT empno, ename, NVL(TO_CHAR(mgr), ' ') AS mgr,
    DECODE(SUBSTR(mgr, 1, 2),
        null, '0000',
        '75', '5555',
        '76', '6666',
        '77', '7777',
        '78', '8888',
        mgr) AS chg_mgr
FROM emp;