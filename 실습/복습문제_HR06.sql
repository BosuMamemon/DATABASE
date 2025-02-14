--CTAS
--1.employees 테이블을 이용해서 sal_history(empid, hiredate,sal) 테이블 생성
CREATE TABLE sal_history(
    empid,
    hiredate,
    sal)
AS
SELECT employee_id, hire_date, salary
FROM employees;

--2. employees 테이블의 구조만 이용해서 sal_history2(empid, hiredate,sal) 테이블 생성
CREATE TABLE sal_history2(empid, hiredate, sal)
AS
SELECT employee_id, hire_date, salary
FROM employees
WHERE 0 != 0;

--3. employees 테이블의 구조만 이용해서 sal_history3(id, hire,sal) 테이블 생성
CREATE TABLE sal_history3(id, hire, sal)
AS
SELECT employee_id, hire_date, salary
FROM employees
WHERE 0 != 0;

--4. sal_history / sal_history2 / sal_history3 테이블 삭제
DROP TABLE sal_history;
DROP TABLE sal_history2;
DROP TABLE sal_history3;

--5. employees 구조만 이용해서 sal_history(empid, hiredate, sal) 테이블 생성
CREATE TABLE sal_history(empid, hiredate, sal)
AS
SELECT employee_id, hire_date, salary
FROM employees
WHERE 0 != 0;

--6. employees 테이블에서 employee_id가 200보다 큰 데이터를 sal_history 테이블에 넣기
INSERT INTO sal_history
SELECT employee_id, hire_date, salary
FROM employees
WHERE employee_id > 200;
COMMIT;

-- 1. member 테이블 생성
-- id 숫자 / name 문자열(20) / address  문자열(50) /  phone 문자열(20)
CREATE TABLE member(
    id number,
    name varchar2(20),
    address varchar2(50),
    phone varchar2(20));

-- 2.추가
-- (100, '홍길동', '부산', '010-1111-2222')
-- (101, '이순신', '서울', '010-2222-3333')
-- (102, '강감찬', '대구', '010-4444-5555')
-- (103, '오라클', '부산', '010-5555-6666')
-- (104, '데이터베이스', '서울', '010-3434-7777')
INSERT INTO member
VALUES(100, '홍길동', '부산', '010-1111-2222');
INSERT INTO member
VALUES(101, '이순신', '서울', '010-2222-3333');
INSERT INTO member
VALUES(102, '강감찬', '대구', '010-4444-5555');
INSERT INTO member
VALUES(103, '오라클', '부산', '010-5555-6666');
INSERT INTO member
VALUES(104, '데이터베이스', '서울', '010-3434-7777');
COMMIT;

-- 3. member 테이블에서 address별 member 인원수 출력
SELECT address, COUNT(*)
FROM member
GROUP BY address;
SELECT address, CONCAT(COUNT(*), '명') 인원수
FROM member
GROUP BY address;

-- 4. 102번 멤버의 전화번호를 010-1212-4444로 수정
UPDATE member
SET phone = '010-1212-4444'
WHERE id = 102;
COMMIT;

-- 5. 103번 회원 삭제
DELETE FROM member
WHERE id = 103;
COMMIT;

-- 6. member 테이블에 email(문자열(30)) 열 추가
ALTER TABLE member
ADD(email varchar2(30));

-- 7. member 테이블에 email열을 문자열(100)으로 변경
ALTER TABLE member
MODIFY(email varchar2(100));

-- 8. 102번 멤버의 email을 test@test.com으로 수정
UPDATE member
SET email = 'test@test.com'
WHERE id = 102;
COMMIT;

-- 9. member 테이블 삭제
DROP TABLE member;