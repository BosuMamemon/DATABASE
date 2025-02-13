-- p.357 13장 연습문제

-- Q1-1
CREATE TABLE empidx
AS
SELECT *
FROM emp;
-- Q1-2
CREATE INDEX idx_empidx_empno
ON empidx(empno);
-- Q1-3
SELECT * FROM user_indexes;

-- Q2
CREATE OR REPLACE VIEW empidx_over15k
AS
SELECT empno, ename, job, deptno, sal, NVL2(comm, 'O', 'X') comm
FROM empidx
WHERE sal > 1500
WITH READ ONLY;

-- Q3-1
CREATE TABLE deptseq
AS
SELECT *
FROM dept
WHERE 0 = 1;
-- Q3-2
CREATE SEQUENCE dept_sequence
START WITH 1
INCREMENT BY 1
MAXVALUE 99
MINVALUE 1
NOCYCLE
NOCACHE;
-- Q3-3
INSERT INTO deptseq
VALUES(dept_sequence.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO deptseq
VALUES(dept_sequence.NEXTVAL, 'WEB', 'BUSAN');
INSERT INTO deptseq
VALUES(dept_sequence.NEXTVAL, 'MOBILE', 'ILSAN');

-- 시퀀스, 테이블, 뷰, 인덱스 삭제
DROP TABLE deptseq;
DROP TABLE empidx;
DROP SEQUENCE dept_sequence;
DROP VIEW empidx_over15k;
DROP INDEX idx_empidx_empno;