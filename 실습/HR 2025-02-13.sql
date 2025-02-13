-- 1. member ���̺� ����
-- num ���� / name ���ڿ� / address ���ڿ� / phone ���ڿ� / hiredate date �⺻�� = ���� ��¥
-- num�� �������� �Է�(member_seq / 1�� ���� / 1�� ���� / �ּҰ� 1 / ����Ŭ ���� / ĳ�� ����)
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

-- 2. �߰� -> num�� �ڵ� ����
-- ('ȫ�浿', '�λ�', '010-1111-2222')
-- ('�̼���', '����', '010-2222-3333')
INSERT INTO member
VALUES(member_seq.NEXTVAL, 'ȫ�浿', '�λ�', '010-1111-2222', DEFAULT);
INSERT INTO member
VALUES(member_seq.NEXTVAL, '�̼���', '����', '010-2222-3333', DEFAULT);
COMMIT;

-- ������, ���̺� ����
DROP SEQUENCE member_seq;
DROP TABLE member;