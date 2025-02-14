--p.396 15�� �����, ����, �� ����
--����� / �����ͺ��̽� ��Ű��
--��) scott: �����
--scott�� ������ ���̺�, ��������, ������ �� �����ͺ��̽����� ���� ��� ��ü�� '��Ű��'��� �θ�
--����� ���� => ������ ����

--���������� ���� ����� ���� �տ� C##�� �߰��Ǿ���
--�� ����� ������� �ʱ� ���� session�� ����
ALTER SESSION SET "_oracle_script" = true;

--1. ����� ����: id - test_user / pw: 1234
CREATE USER test_user IDENTIFIED BY 1234;

--2. GRANT: test_user���� ���ӱ���(CREATE SESSION ����) ���� �ο�
GRANT CREATE SESSION TO test_user;
GRANT UNLIMITED TABLESPACE TO test_user;

--3. ��й�ȣ ����
ALTER USER test_user IDENTIFIED BY abcd;

--4. ����� ����(���� ���� ������ �ؾ���)
DROP USER test_user;
DROP USER test_user CASCADE; --�̰� ���� ������ұ��� ���� DROP�ع���

=====

--P.417 ��
--CONNECT ��:
--  CREATE SESSION ��, ���ӱ��Ѹ� ����
--RESOURCE ��:
-- CREATE TABLE / CREATE SEQUENCE �� ��ü�� ������ ������ ����
--UNLIMITED TABLESPACE: ���̺��� ������ ������ ������ ����� ����
--1. ����� ����
CREATE USER test_user IDENTIFIED BY abcd;
--2. ���� �ο�
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO test_user;
--3. ���� ��Ż (CONNECT �� ���� ����)
REVOKE CONNECT FROM test_user;
--4. ����� ����
DROP USER test_user;

--p.416 15�� ��������
--1. PREV_HW ��������(PW: orcl) ���� �����ϵ��� ����
CREATE USER prev_hw IDENTIFIED BY orcl;
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO prev_hw;

--4. prev_hw ���� ����(������ ���������ۿ� ����)
DROP USER prev_hw;