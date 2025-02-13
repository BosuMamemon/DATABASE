-- p.215(다중행 서브쿼리)
-- IN, OR, ANY, EXIST
SELECT ename, sal, job
FROM emp
WHERE job = 'SALESMAN';
-- IN() <- 입력한 인수를 모두 충족
SELECT ename, sal
FROM emp
WHERE sal IN (1600, 1250, 1500);
-- ANY() <- 인수의 범위 중 하나를 충족
SELECT ename, sal
FROM emp
WHERE sal < ANY (1600, 1250, 1500);
SELECT ename, sal
FROM emp
WHERE
    sal < ANY (
        SELECT sal
        FROM emp
        WHERE job = 'SALESMAN'
        );
-- ALL() <- 인수의 범위를 모두 충족
SELECT ename, sal
FROM emp
WHERE
    sal < ALL (
        SELECT sal
        FROM emp
        WHERE job = 'SALESMAN'
        );
        
-- emp 테이블
-- 30번 부서의 최대급여보다 적은 급여를 받는 사원 출력
-- (ANY, ALL) 사용
SELECT *
FROM emp
WHERE
    sal < ANY(
        SELECT sal
        FROM emp
        WHERE deptno = 30
        );

-- 30번 부서의 최대급여보다 많은 급여를 받는 사원 출력
-- (ANY, ALL) 사용
SELECT *
FROM emp
WHERE
    sal > ALL(
        SELECT sal
        FROM emp
        WHERE deptno = 30
        );
-- EXISTS() <- 이 값이 존재하냐 안하냐 boolean
-- 아래는 EXISTS()가 true라서 걍 SELECT를 모두 출력
SELECT *
FROM dept
WHERE
    EXISTS(
        SELECT deptno
        FROM dept
        WHERE deptno = 20);
-- 아래는 EXISTS()가 false라서 SELECT 안 출력
SELECT *
FROM dept
WHERE
    EXISTS(
        SELECT deptno
        FROM dept
        WHERE deptno = 50);
        
-------------------------------------------------
-- p.266
-- DML(Data Manipulation Language)
-- ㄴ 데이터 조작어: 데이터를 추가, 수정, 삭제
-- DDL(Data Definition Language)
-- ㄴ 데이터 정의어: 객체를 생성, 변경, 삭제
-- DCL

-- test1(no, name, address, tel) 테이블 생성
-- 문법: create table 테이블명(컬럼 정의)
-- 유형(예시): no 숫자(5), name 문자열(10), address 문자열(50), tel 문자열(20)
-- ㄴ 괄호 안은 용량임
CREATE TABLE test1(
    no number(5),
    name varchar2(10),
    address varchar2(50),
    tel varchar2(20)
);
-- test1 테이블에 데이터 추가
-- 문법: INSERT INTO 테이블명(컬럼) VALUES(값)
INSERT INTO test1(no, name)
VALUES(1, 'aaa');
INSERT INTO test1(no, name, address, tel)
VALUES(2, 'bbb', '부산', '010-1111-2222');
INSERT INTO test1(no, name, address, tel)
VALUES(3, 'ccc', '서울', '010-3333-4444');
-- 모든 컬럼에 데이터를 삽입할땐 컬럼명 생략 가능
INSERT INTO test1
VALUES(4, 'ddd', '대구', '010-5555-6666');
INSERT INTO test1(no, name, address)
VALUES(5, 'eee', '제주');
-- 커밋
COMMIT;

-- 롤백(커밋 이전사항까지 롤백 가능)
INSERT INTO test1(no, name, tel)
VALUES(6, 'ffff', '010-6666-7777');
ROLLBACK;

-- test1 테이블 no가 2인정보 출력
SELECT *
FROM test1
WHERE no = 2;

-- 수정 ==> no = 2인 사람의 이름을 홍길동으로 수정
UPDATE test1
SET name = '홍길동'
WHERE no = 2;
COMMIT;

UPDATE test1
SET
    name = '이순신', address = '서울'
WHERE no = 4;
COMMIT;

-- 삭제
DELETE test1 WHERE no = 3;
ROLLBACK;

DELETE test1 WHERE no = 3;
INSERT INTO test1
VALUES(3, 'ccc', '서울', '010-1236-4567');
COMMIT;

-- test2테이블 생성 (자체 커밋이 됨)
CREATE TABLE test2(
    no number(4) default 0,
    name varchar2(20) default 'NONAME',
    hiredate date default sysdate
    );

-- test2 테이블에 (1, 홍길동) 추가
INSERT INTO test2(no, name)
VALUES(1, '홍길동');
-- test2 테이블에 25/2/6 추가
INSERT INTO test2(hiredate)
VALUES('25/02/06');
-- test2 테이블에서 no가 1번인 사람의 이름을 '강감찬'으로 변경
UPDATE test2
SET name = '강감찬'
WHERE no = 1;
-- test2 테이블에서 no = 0을 삭제
DELETE test2
WHERE no = 0;
-- test2 테이블에서 no = 2 추가
INSERT INTO test2(no)
VALUES(2);

COMMIT;

-- CRUD 작업
-- C: CREATE TABLE table(column type())
-- R: INSERT INTO table(column) VALUES(value)
-- U: UPDATE FROM table SET column = value WHERE
-- D: DELETE FROM table WHERE

-- p.266(CTAS: CREATE TABLE AS SELECT)
-- dept_temp 테이블 생성 단, dept 테이블 그대로
CREATE TABLE dept_temp
AS
SELECT *
FROM dept;
-- dept_temp 테이블에 50, DATABASE, SEOUL 추가
DESC dept_temp;
INSERT INTO
    dept_temp(deptno, dname, loc)
VALUES(50, 'DATABASE', 'SEOUL');

-- 테이블 구조만 복사
CREATE TABLE emp_temp
AS
SELECT *
FROM emp
WHERE 1 != 1; // WHERE절이 false가 되도록 삽입을 하면 테이블 구조만 복사 가능

-- emp_temp: empno, ename, job, mgr, hiredate, sal, comm, deptno
INSERT INTO emp_temp
VALUES(2111, '이순신', 'MANAGER', 9999, TO_DATE('07/01/2019', 'dd/mm/yyyy'), 4000, null, 20);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, deptno)
VALUES(2111, '이순신2', 'MANAGER', 9999, TO_DATE('07/01/2019', 'dd/mm/yyyy'), 4000, 20);
INSERT INTO emp_temp
VALUES(3111, '강감찬', 'MANAGER', 9999, sysdate, 4000, null, 20);

COMMIT;

-- p.275
-- emp 테이블에서 급여 등급(salgrade)이 1(700~1200)인 사원만 emp_temp 테이블에 추가
-- 서브쿼리를 이용해서 한번에 여러 데이터를 추가하였음!
-- 이때는 VALUES()를 사용하지 않고 바로 서브쿼리로 들어감
INSERT INTO emp_temp
SELECT emp.*
FROM emp
    JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
WHERE grade = 1;
DELETE emp_temp;

COMMIT;

-- 급여 등급이 3인 사원만 emp_temp에 추가
INSERT INTO emp_temp
SELECT emp.*
FROM emp
    JOIN salgrade
        ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal
WHERE salgrade.grade = 3;

-- dept 테이블을 복사해서 dept_temp2 테이블을 생성하고,
-- 40번 부서명을 DATABASE, 지역을 SEOUL로 수정
CREATE TABLE dept_temp2
AS
SELECT *
FROM dept;

UPDATE dept_temp2
SET
    dname = 'DATABASE',
    loc = 'SEOUL'
WHERE
    deptno = 40;
    
COMMIT;

-- dept_temp2 테이블에서 부서번호가 40번인 부서명과 지역을 수정
-- dept 테이블의 40번 부서의 내용으로 수정하기
UPDATE dept_temp2
SET
    dname = (
        SELECT dname
        FROM dept
        WHERE deptno = 40
        ),
    loc = (
        SELECT loc
        FROM dept
        WHERE deptno = 40
        )
WHERE
    deptno = 40;
    
UPDATE dept_temp2
SET
    (dname, loc) = (
        SELECT dname, loc
        FROM dept
        WHERE deptno = 40
        )
WHERE
    deptno = 40;

-- DDL : 객체 생성 삭제 변경 CREATE, DROP, ALTER
-- DROP: 객체 삭제
-- dept_temp2 데이터 삭제
DELETE dept_temp2;
COMMIT;

-- dept_temp2 테이블 삭제
DROP TABLE dept_temp;

-- dept 테이블을 이용해서 dept_temp 테이블 생성
CREATE TABLE dept_temp
AS
SELECT *
FROM dept;

-- ADD(): 객체 요소 추가
-- dept_temp 테이블에 컬럼 추가
ALTER TABLE dept_temp
ADD(location varchar2(30));

-- 10번 부서의 location의 값을 NEW YORK으로 수정
UPDATE dept_temp
SET location = 'NEW YORK'
WHERE deptno = 10;

COMMIT;

-- MODIFY(): 객체 요소 수정
-- location의 용량을 70으로 수정
ALTER TABLE dept_temp
MODIFY(location varchar(70));

-- DROP COLUMN -> 열도 DROP이 가능
-- location 컬럼 삭제
ALTER TABLE dept_temp
DROP COLUMN location;

-- RENAME TO: 객체 이름 변경
-- 테이블 dept_temp를 dept_temp_temp로 변경
ALTER TABLE dept_temp
RENAME TO dept_temp_temp;
RENAME dept_temp_temp TO dept_temp; -- ALTER 안쓰고 RENAME만 써도 됨
-- RENAME COLUMN A TO B: 객체 열 이름 변경
-- 컬럼 loc의 이름을 location으로 변경
ALTER TABLE dept_temp
RENAME COLUMN loc TO location;

-- dept_temp 데이터 모두 삭제
DELETE dept_temp;
ROLLBACK; -- DELETE는 DCL이라서 커밋, 롤백이 가능
TRUNCATE TABLE dept_temp; -- DELETE 테이블명 이랑 같음
ROLLBACK; -- 그런데 TRUNCATE는 DDL이라서 커밋, 롤백이 안됨

DROP TABLE dept_temp;

----------------------------------------------------------------------------

-- test1 테이블에서
-- 1. 컬럼 추가: birthday / date형
ALTER TABLE test1
ADD(birthday date);

-- 2. 컬럼명 수정: tel -> phone
ALTER TABLE test1
RENAME COLUMN tel TO phone;

-- 3. no 컬럼 삭제
ALTER TABLE test1
DROP COLUMN no;

-- 4. num 컬럼 추가: number(3)
ALTER TABLE test1
ADD(num number(3));

-- 5. address 문자열(50) -> 문자열(70)으로 변경
ALTER TABLE test1
MODIFY(address varchar(70));

-- 6. test1 테이블의 이름을 testtest로 바꿧다가 다시 돌아오기 ㅎㅎ
RENAME test1 TO testtest;
ALTER TABLE testtest
RENAME TO test1;

-- 7. 테이블 삭제
DROP TABLE test1;