-- 1. professor ���̺���,
-- �а����� �Ҽ� �������� ��ձ޿�, �ּұ޿�, �ִ�޿� ���
-- ��, ��� �޿��� 300�� �Ѵ� �͸� ���

SELECT
    deptno �а�, avg(pay) ��ձ޿�, min(pay) �ּұ޿�, max(pay) �ִ�޿�
FROM professor
GROUP BY deptno
HAVING avg(pay) > 300;

-- 2. student ���̺���,
-- �г�, �л���, ��� Ű, ��� �����Ը� ����ϵ�,
-- �л� ���� 4�� �̻��� �г⿡ ���ؼ� ���
-- ��, ��� Ű�� ��� �����Դ� �Ҽ��� ù��° �ڸ����� �ݿø�
-- ��� ������ ��� Ű�� ���� ������ ������������ ���
SELECT
    grade �г�, count(*) �л���, round(avg(height)) "��� Ű", round(avg(weight)) "��� ������"
FROM student
GROUP BY grade
HAVING count(*) >= 4
ORDER BY avg(height) DESC;

-- 3. professor, student ���̺���,
-- �л��̸��� �������� �̸��� ���
SELECT
    student.name �л�, professor.name ��������
FROM student
    JOIN professor
    ON student.profno = professor.profno;
    
-- 4. gift, customer ���̺���,
-- ���̸�(gname), ����Ʈ(point), ����(gname)�� ���
SELECT
    customer.gname ���̸�, TO_CHAR(point, '999,999') ����Ʈ, gift.gname ����
FROM customer JOIN gift
    ON customer.point >= gift.g_start
        AND customer.point <= gift.g_end;
-- ����Ŭ ����
SELECT
    customer.gname ���̸�, TO_CHAR(point, '999,999') ����Ʈ, gift.gname ����
FROM
    customer, gift
WHERE
    customer.point BETWEEN gift.g_start AND gift.g_end;
    
-- 5. student, score, hakjum ���̺���
-- �л��̸�(name), ����(total), ����(grade) ���
SELECT
    name �л��̸�, total ����, hakjum.grade ����
FROM student
    JOIN score
        ON student.studno = score.studno
    JOIN hakjum
        ON score.total BETWEEN hakjum.min_point AND hakjum.max_point;
    
-- ����Ŭ ����
SELECT
    name �л��̸�, total ����, hakjum.grade ����
FROM
    student, score, hakjum
WHERE
    student.studno = score.studno
    AND
    score.total BETWEEN hakjum.min_point AND hakjum.max_point;
    
-- professor, student ���̺�
-- 1. �л� �̸��� �������� �̸��� ���
-- ��, ���������� �������� ���� �л��� �̸��� ���
SELECT
    student.name "�л� �̸�", professor.name "�������� �̸�"
FROM student
    LEFT OUTER JOIN professor
        ON student.profno = professor.profno;

-- 2. deptno1�� 101�� �л��� ���
-- ��, ���������� ���� �л��� ���
-- �а���ȣ, �л��̸�, �������� �̸� ���
SELECT
    studno �а���ȣ, student.name "�л� �̸�", professor.name "�������� �̸�"
FROM student
    LEFT OUTER JOIN professor
        ON student.profno = professor.profno
WHERE deptno1 = 101;


-- 3. dept2 ���̺��� area�� Seoul Branch Office�� �����
-- �����ȣ, �̸�, �μ���ȣ ���
-- 1) �������� ���
SELECT name, empno, deptno
FROM emp2
WHERE deptno IN
    (SELECT dcode
    FROM dept2
    WHERE area = 'Seoul Branch Office');

-- 2) JOIN ���
SELECT name, empno, deptno
FROM emp2
    JOIN dept2
    ON emp2.deptno = dept2.dcode
WHERE dept2.area = 'Seoul Branch Office';

-- 4. student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л���
-- �г�, �̸�, ������ ���
SELECT grade, max(weight), name, weight
FROM student
WHERE weight IN(SELECT max(weight)
                FROM student
                GROUP BY grade)
GROUP BY grade, name, weight;