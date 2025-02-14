--p.396 15장 사용자, 권한, 롤 관리
--사용자 / 데이터베이스 스키마
--예) scott: 사용자
--scott이 생성한 테이블, 제약조건, 시퀀스 등 데이터베이스에서 만든 모든 객체를 '스키마'라고 부름
--사용자 생성 => 관리자 권한

--버전업으로 인해 사용자 계정 앞에 C##이 추가되었음
--위 기능을 사용하지 않기 위해 session을 변경
ALTER SESSION SET "_oracle_script" = true;

--1. 사용자 생성: id - test_user / pw: 1234
CREATE USER test_user IDENTIFIED BY 1234;

--2. GRANT: test_user에게 접속권한(CREATE SESSION 권한) 등을 부여
GRANT CREATE SESSION TO test_user;
GRANT UNLIMITED TABLESPACE TO test_user;

--3. 비밀번호 변경
ALTER USER test_user IDENTIFIED BY abcd;

--4. 사용자 삭제(먼저 접속 해제를 해야함)
DROP USER test_user;
DROP USER test_user CASCADE; --이거 쓰면 연관요소까지 전부 DROP해버림

=====

--P.417 롤
--CONNECT 롤:
--  CREATE SESSION 즉, 접속권한만 있음
--RESOURCE 롤:
-- CREATE TABLE / CREATE SEQUENCE 등 객체를 생성할 권한이 있음
--UNLIMITED TABLESPACE: 테이블을 생성할 공간을 무한히 사용할 권한
--1. 사용자 생성
CREATE USER test_user IDENTIFIED BY abcd;
--2. 권한 부여
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO test_user;
--3. 권한 박탈 (CONNECT 롤 권한 삭제)
REVOKE CONNECT FROM test_user;
--4. 사용자 삭제
DROP USER test_user;

--p.416 15장 연습문제
--1. PREV_HW 계정생성(PW: orcl) 접속 가능하도록 생성
CREATE USER prev_hw IDENTIFIED BY orcl;
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO prev_hw;

--4. prev_hw 계정 삭제(관리자 계정에서밖에 못함)
DROP USER prev_hw;