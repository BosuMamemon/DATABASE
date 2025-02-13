-- 1. student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л���
-- �г�, �̸�, ������ ���
SELECT grade, max(weight), name, weight
FROM student
WHERE weight IN(SELECT max(weight)
                FROM student
                GROUP BY grade)
GROUP BY grade, name, weight;

-- 2. professor, department ���̺�
-- �� �а��� �Ի����� ���� ������ ������ ������ȣ, �̸�, �а��� ���
-- ��, �Ի����� ������������
-- NATURAL JOIN
SELECT
    min(hiredate), profno, name, dname
FROM professor
    NATURAL JOIN department
WHERE
    hiredate IN(
        SELECT min(hiredate)
        FROM professor
        GROUP BY deptno
        )
GROUP BY profno, name, dname;
-- JOIN USING
SELECT
    min(hiredate), profno, name, dname
FROM professor
    JOIN department USING(deptno)
WHERE
    hiredate IN(
        SELECT min(hiredate)
        FROM professor
        GROUP BY deptno
        )
GROUP BY profno, name, dname;

-- 3. emp2 ���̺�
-- 'Section head'(position) ������ �ּ� �����ں���
-- ������ ���� ����� name, position, pay ���
SELECT name, position, TO_CHAR(pay, '999,999,999') ����
FROM emp2
WHERE
    pay > (
        SELECT min(pay)
        FROM emp2
        GROUP BY position
        HAVING position = 'Section head'
        );

-- 4. employees ���̺�
-- �μ���ȣ�� 80���� ū �μ���
-- employee_id, ����̸�first_name, �Ŵ����̸�first_name ���
SELECT
    emp.employee_id, emp.first_name, mgr.first_name, emp.department_id
FROM employees emp
    JOIN employees mgr
        ON emp.manager_id = mgr.employee_id
WHERE emp.department_id > 80;

-- 5. student, professor ���̺�
-- ��� �л� ���(���������� ���� �л��� ���)
-- �л��̸�name, �����̸�name
SELECT student.name, professor.name
FROM student
    LEFT OUTER JOIN professor
        ON student.profno = professor.profno;