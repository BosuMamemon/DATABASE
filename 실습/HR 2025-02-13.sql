-- 1. member 테이블 생성
-- num 숫자 / name 문자열 / address 문자열 / phone 문자열 / hiredate date 기본값 = 오늘 날짜
-- num은 시퀀스로 입력(member_seq / 1로 시작 / 1씩 증가 / 최소값 1 / 사이클 없음 / 캐시 없음)
CREATE TABLE member(
    num number(5),
    name varchar(30),
    address varchar(30),
    phone varchar(30),
    hiredate date DEFAULT sysdate);
CREATE SEQUENCE member_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOCYCLE
NOCACHE;

-- 2. 추가 -> num은 자동 증가
-- ('홍길동', '부산', '010-1111-2222')
-- ('이순신', '서울', '010-2222-3333')
INSERT INTO member
VALUES(member_seq.NEXTVAL, '홍길동', '부산', '010-1111-2222', DEFAULT);
INSERT INTO member
VALUES(member_seq.NEXTVAL, '이순신', '서울', '010-2222-3333', DEFAULT);
COMMIT;

-- 시퀀스, 테이블 삭제
DROP SEQUENCE member_seq;
DROP TABLE member;