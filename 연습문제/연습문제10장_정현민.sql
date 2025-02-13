-- p.287 10장 연습문제
-- Q1.
INSERT INTO chap10hw_dept
VALUES(50, 'ORACLE', 'BUSAN');
INSERT INTO chap10hw_dept
VALUES(60, 'SQL', 'ILSAN');
INSERT INTO chap10hw_dept
VALUES(70, 'SELECT', 'INCHEON');
INSERT INTO chap10hw_dept
VALUES(80, 'DML', 'BUNDANG');

COMMIT;

-- Q2.
INSERT INTO chap10hw_emp
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'yyyy-mm-dd'), 4500, null, 50);
INSERT INTO chap10hw_emp
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'yyyy-mm-dd'), 1800, null, 50);
INSERT INTO chap10hw_emp
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'yyyy-mm-dd'), 3400, null, 60);
INSERT INTO chap10hw_emp
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'yyyy-mm-dd'), 2700, 300, 60);
INSERT INTO chap10hw_emp
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'yyyy-mm-dd'), 2600, null, 70);
INSERT INTO chap10hw_emp
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'yyyy-mm-dd'), 2600, null, 70);
INSERT INTO chap10hw_emp
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'yyyy-mm-dd'), 2300, null, 80);
INSERT INTO chap10hw_emp
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'yyyy-mm-dd'), 1200, null, 80);

COMMIT;

-- Q3.
UPDATE chap10hw_emp
SET deptno = 70
WHERE
    sal > (
        SELECT avg(sal)
        FROM chap10hw_emp
        WHERE deptno = 50
        );

COMMIT;

-- Q4.
UPDATE chap10hw_emp
SET
    sal = sal * 1.1,
    deptno = 80
WHERE
    hiredate > (
        SELECT min(hiredate)
        FROM chap10hw_emp
        WHERE deptno = 60
        );

COMMIT;

-- Q5.
DELETE chap10hw_emp
WHERE
    sal IN(
        SELECT sal
        FROM chap10hw_emp e
            JOIN chap10hw_salgrade s
                ON e.sal BETWEEN s.losal AND s.hisal
        WHERE grade = 5
        );
        
COMMIT;