--1. professor ���̺�, department ���̺�
--������ȣ(profno)�� �����̸�(name), �Ҽ��а��̸�(dname)�� ��ȸ�ϴ�
--view ����(v_prof_dept2)
CREATE OR REPLACE VIEW v_prof_dept2
AS
SELECT profno, name, dname
FROM professor
    NATURAL JOIN department;

--2.1�� �並 �б� ��������  v_prof_dept3
CREATE OR REPLACE VIEW v_prof_dept3
AS
SELECT profno, name, dname
FROM professor
    NATURAL JOIN department
WITH READ ONLY;

--3. student, department ���̺��� ����Ͽ�
--�а���(deptno1)�� �л����� �ִ�Ű�� �ִ� ������, �а� �̸��� ���
SELECT deptno1, MAX(height), MAX(weight), dname
FROM student s
    JOIN department d
        ON s.deptno1 = d.deptno
GROUP BY deptno1, dname;
        
--4. �а��̸�, �а��� �ִ�Ű, �а����� ���� Ű�� ū �л����� �̸��� Ű�� ���
--�ζ��κ�
SELECT *
FROM (
        SELECT deptno1, name, MAX(height) max_height
        FROM student
        GROUP BY deptno1, name
    ) vw
    JOIN department d
        ON vw.deptno1 = d.deptno
    JOIN student s
        ON vw.name = s.name;

--5. student ���̺���
--�л��� Ű�� ���� �г��� ��� Ű���� ū �л���                           
--�г�, �̸�, Ű, �ش� �г��� ���Ű ��� (�ζ��κ� �̿�, �г����� ��������)
SELECT vw.grade, s.name, s.height, vw.avg_height
FROM (
        SELECT grade, AVG(height) avg_height
        FROM student
        GROUP BY grade
    ) vw
    JOIN student s
        ON vw.grade = s.grade
WHERE height > avg_height
ORDER BY vw.grade;
