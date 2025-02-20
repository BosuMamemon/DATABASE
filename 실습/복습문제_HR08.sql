-- ��)ȣ�� ==> ����
--1)HOTEL(hotel_id, name, grade, address)
--hotel_id �⺻Ű ==> ������ :hotel_seq
CREATE SEQUENCE hotel_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE
    NOCACHE;
CREATE TABLE hotel(
    hotel_id NUMBER
        DEFAULT hotel_seq.NEXTVAL
        CONSTRAINT hotel_hotel_id_pk
            PRIMARY KEY,
    name VARCHAR2(20),
    grade NUMBER,
    address VARCHAR2(20)
);

--2)review(num, title, content, regdate)
--num : �⺻Ű ==> ������ : review_seq
--regdate date �� ==> ���ó�¥�� �⺻��
CREATE SEQUENCE review_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCYCLE
    NOCACHE;
CREATE TABLE review(
    num NUMBER
        DEFAULT review_seq.NEXTVAL
        CONSTRAINT review_num_pk
            PRIMARY KEY,
    title VARCHAR2(20),
    content VARCHAR2(50),
    regdate DATE
        DEFAULT SYSDATE
);

--3)hotel �� �������� review �� ���� �� �ִ�
 -- ==> �ܷ�Ű�ο�
ALTER TABLE review
ADD hotel_id NUMBER;
ALTER TABLE review
ADD
    CONSTRAINT review_hotel_id_fk
        FOREIGN KEY(hotel_id)
        REFERENCES hotel(hotel_id)
        ON DELETE CASCADE;
        
--employees, departments ���̺�
--�μ��� �������� ����� ������
ALTER TABLE employees
ADD
    CONSTRAINT employees_department_id_fk
        FOREIGN KEY(department_id)
        REFERENCES departments(department_id)
        ON DELETE CASCADE;
        
--hotel, review ���̺� ����
DROP TABLE review;
DROP TABLE hotel;