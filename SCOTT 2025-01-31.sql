-- DISTINCT(): �ߺ� ���� �Լ�
SELECT sal FROM emp;
SELECT DISTINCT(sal) FROM emp;

-- p.177
-- �׷� �Լ�
-- SUM(): ���� ������ ���ϴ� �Լ�
SELECT sal, comm FROM emp;
SELECT SUM(sal) FROM emp;
SELECT SUM(sal), comm FROM emp; -- �� ������ �޶� ��� �Ұ�
SELECT SUM(sal), SUM(comm) FROM emp; -- null�� �˾Ƽ� �� ����

-- COUNT(): �� ������ ���ϴ� �Լ�
SELECT COUNT(sal) FROM emp;
SELECT COUNT(comm) FROM emp; -- null�� �˾Ƽ� �� ��
SELECT COUNT(DISTINCT(sal)) FROM emp;
SELECT COUNT(empno) FROM emp;
SELECT COUNT(*) FROM emp; -- null�� ��� ���Ѵٸ� ������ ��� ���� �� ������ �����ϱ�...

-- �μ���ȣ(deptno)�� 30���� ��� ��
SELECT COUNT(*) FROM emp
WHERE deptno = 30;

-- null�� �ƴ� comm�� ����
SELECT COUNT(comm) FROM emp;

-- null�� comm�� ����
SELECT COUNT(*) FROM emp -- COUNT(comm)���� �ϸ� 0�� ����... �翬�� COUNT()�� null�� �� ��
WHERE comm IS NULL;

--
SELECT COUNT(sal), COUNT(DISTINCT(sal)), COUNT(ALL(sal)) -- COUNT(sal)�̶� �� ����
FROM emp;

-- MAX(): �� ������ �߿��� �ִ밪 ���
-- MIN(): �ּҰ� ���
-- AVG(): ��հ� ���
SELECT MAX(sal), MIN(sal) FROM emp;
SELECT SUM(sal), COUNT(sal), ROUND(AVG(sal), 1) FROM emp;

-- �μ���ȣ�� 20�� ��� �߿��� �Ի����� ���� �ֱ��� ��� ���
SELECT MAX(hiredate) FROM emp
WHERE deptno = 20;

-- professor ���̺�
SELECT * FROM professor;
-- 1. �� ���� �� ���
SELECT COUNT(*) FROM professor;
-- 2. ���� �޿� �հ� ���
SELECT SUM(pay) FROM professor;
-- 3. ���� �޿� ��� ���
SELECT AVG(pay) FROM professor;
-- 4. ���� �޿� ����� �Ҽ��� ù° �ڸ����� �ݿø�
SELECT ROUND(AVG(pay), 0) FROM professor;
-- 5. �ְ� �޿�
SELECT MAX(pay) FROM professor;
-- 6. ���� �޿�
SELECT MIN(pay) FROM professor;
-- 7. ���� �� �ְ� �޿��� �޴� ������ �̸��� �޿��� ���
SELECT name, pay FROM professor
WHERE pay = (SELECT MAX(pay) FROM professor); -- ���� ���� / �ζ��� SQL
-- 8. ���� �޿� �հ踦 ���, õ ���� ��ǥ ���
SELECT TO_CHAR(SUM(pay), '999,999') FROM professor;

-- emp ���̺�
-- 1. �μ���ȣ�� 10���� ����� ��� �޿�
-- 2. �μ���ȣ�� 20���� ����� ��� �޿�
-- 3. �μ���ȣ�� 30���� ����� ��� �޿�
SELECT AVG(sal) FROM emp WHERE deptno = 10;
SELECT AVG(sal) FROM emp WHERE deptno = 20;
SELECT AVG(sal) FROM emp WHERE deptno = 30;
-- 4. �μ���ȣ�� 10, 20, 30���� ����� ��� �޿�
-- ���տ����� ���
SELECT AVG(sal) FROM emp WHERE deptno = 10
UNION
SELECT AVG(sal) FROM emp WHERE deptno = 20
UNION
SELECT AVG(sal) FROM emp WHERE deptno = 30; -- �̰� 3���� ������ ���ε��� ����ϴ� ��
SELECT AVG(sal) FROM emp WHERE deptno IN (10, 20, 30); -- �̰� 10, 20, 30�� �μ� ��� ������ �հ�
-- 5. �μ��� ��� �޿� ��� (GROUP BY)
SELECT deptno AS �μ���ȣ, AVG(sal) AS �μ���_���_�޿� FROM emp
GROUP BY deptno -- GROUP BY�� ���� �÷��� SELECT�� ��� ����
ORDER BY �μ���ȣ;

-- p.177
-- �׷� �Լ� = ���� �� �Լ� = ���� �� �Լ�
-- ����(����)�� ��� ����� �ϳ��� ���� ��´ٴ� ��

-- �μ��� �� ���޺� ��� �޿�
SELECT deptno, job, ROUND(AVG(sal)) AS avg_sal FROM emp
GROUP BY deptno, job
ORDER BY deptno DESC, avg_sal DESC;

-- professor ���̺�
-- 1. �а��� �������� ��� �޿� ���
SELECT deptno, ROUND(AVG(pay)) FROM professor GROUP BY deptno;
-- 2. �а��� �������� �޿� �հ� ���
SELECT deptno, SUM(pay) FROM professor GROUP BY deptno;
-- 3. �а� �� ���޺� �������� ��� �޿� ���
SELECT deptno, position, ROUND(AVG(pay)) FROM professor GROUP BY deptno, position;
-- 4. ���� �߿��� �޿��� ���������� ��ģ �ݾ��� ���� ���� ���� ���� ���� ��� ���
-- ��, bonus�� ���� ������ �޿��� ���� 0���� ���
-- ��ģ �ݾ��� �Ҽ� ��° �ڸ����� �ݿø�
SELECT
    MAX(ROUND(pay + NVL(bonus, 0), 1)) AS �ִ�޿�,
    MIN(ROUND(pay + NVL(bonus, 0), 1)) AS �ּұ޿�
FROM professor;
-- 5. ���޺� ��� �޿��� 300���� ũ�� '���', 300���� �۰ų� ������ '����' ���
-- �� �̸��� ����, ��ձ޿�, ���� ���
SELECT
    position AS ����,
    ROUND(AVG(pay)) AS ��ձ޿�,
    CASE
        WHEN AVG(pay) > 500 THEN '���� ���� ��?'
        WHEN AVG(pay) > 300 THEN '�� �� �ּ�'
        ELSE '�����װ���'
        END AS ���
FROM professor
GROUP BY position;

-- emp ���̺�
-- �Ի�⵵�� �ο���
-- �� �̸�: total 1980�⵵ 1981�⵵ 1982�⵵
-- 1) SUM() ���
SELECT
    COUNT(*) AS total,
    SUM(DECODE(TO_CHAR(hiredate, 'yyyy'), 1980, 1, 0)) AS "1980�⵵",
    SUM(DECODE(TO_CHAR(hiredate, 'yyyy'), 1981, 1, 0)) AS "1981�⵵",
    SUM(DECODE(TO_CHAR(hiredate, 'yyyy'), 1982, 1, 0)) AS "1982�⵵"
FROM emp;
-- 2) COUNT() ���
SELECT
    COUNT(*) AS total,
    COUNT(DECODE(TO_CHAR(hiredate, 'yyyy'), 1980, 2, null)) AS "1980�⵵",
    COUNT(DECODE(TO_CHAR(hiredate, 'yyyy'), 1981, 3, null)) AS "1981�⵵",
    COUNT(DECODE(TO_CHAR(hiredate, 'yyyy'), 1982, 4, null)) AS "1982�⵵"
FROM emp;

-- emp ���̺��� 1000 �̻��� �޿��� ������ ����� ���ؼ� �μ��� ����� ���ϵ�,
-- �� �μ��� ����� 2000 �̻��� �μ���ȣ, �μ��� ��ձ޿� ���
SELECT deptno, ROUND(AVG(sal))
FROM emp
WHERE sal >= 1000
GROUP BY deptno
HAVING AVG(sal) >= 2000; -- HAVING: GROUP BY�� ���� ���ǹ�

-- professor ���̺���,
-- 1. �а����� �Ҽ� �������� ��� �޿�, �ּ� �޿�, �ִ� �޿� ���ϱ�
-- ��, ��� �޿��� 300�� �Ѵ� �����͸� ���
SELECT deptno, AVG(pay), MIN(pay), MAX(pay)
FROM professor
GROUP BY deptno;

-- 2. �а� �� ���޺� �������� ��� �޿� ���
-- ��, ��� �޿��� 400 �̻��� �����Ϳ� ���ؼ��� �а���ȣ, ����, ��ձ޿� ���
SELECT deptno AS "�а���ȣ", position AS "����", AVG(pay) AS "��ձ޿�"
FROM professor
GROUP BY deptno, position
HAVING AVG(pay) >= 400;

-- student ���̺���,
-- 3. �г⺰ �л� ��, ��� Ű, ��� �����Ը� ���
-- ��, �л����� 4�� �̻��� �����͸� ���
-- ��� Ű, ��� �����Դ� �Ҽ��� ù° �ڸ����� �ݿø�
-- ��� ������ ��� Ű���� ��������.
SELECT grade, COUNT(*) AS "�л� ��", ROUND(AVG(height)) AS "��� Ű", ROUND(AVG(weight)) AS "��� ������"
FROM student
GROUP BY grade
HAVING COUNT(*) >= 4
ORDER BY AVG(height) DESC;

-- p.196
-- ROLLUP(A, B): A, B �� A�� ���� �Ұ踦 ��½�Ű�� �Լ�
SELECT deptno, job, COUNT(*), MAX(sal), MIN(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY ROLLUP(deptno, job)
ORDER BY deptno, job;

-- CUBE(A, B): A, B �� A �� B�� ���� �Ұ踦 ��½�Ű�� �Լ�
SELECT deptno, job, COUNT(*), MAX(sal), MIN(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;

-- ROLLUP(A, B, C) -> A, B, C / A, B / C / A�� ���� �Ұ� ���
-- CUBE(A, B, C) -> A, B, C / A, B / A, C / B, C / A / B / C�� ���� �Ұ� ���

-- emp ���̺���,
-- �μ��� ���޺� ��� �޿� �� ��� �� ���ϱ�
-- ��, �μ��� ��ձ޿��� ��� ��, ��ü ����� ��ձ޿��� ��� ���� ���
SELECT deptno, job, ROUND(AVG(sal)), COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno, job) -- �μ��� �Ұ� -> ��ü �Ұ�
ORDER BY deptno, job;
SELECT job, deptno, ROUND(AVG(sal)), COUNT(*)
FROM emp
GROUP BY ROLLUP(job, deptno)
ORDER BY job, deptno; -- ���޺� �Ұ� -> ��ü �Ұ�

-- �μ� �� ���޺� ��� �޿��� ��� ���� ���
-- ��, �μ��� ��� �޿��� ��� �� ��� / ���޺� ��� �޿��� ��� �� ��� / ��ü ��� ��� �޿��� ��� �� ���
SELECT deptno, job, ROUND(AVG(sal)), COUNT(*)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;

---------------------------------------------------------------------------------------

-- p.215 JOIN
SELECT * FROM emp;
SELECT * FROM dept;

-- SMITH�� �μ����� dept ���̺��� ���Ͽ� ���
SELECT deptno FROM emp WHERE ename = 'SMITH';
SELECT dname FROM dept WHERE deptno = 20;
SELECT dname FROM dept WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');

--------------------------------------------------------------------------------------
SELECT * FROM emp e, dept d;
--------------------------------------------------------------------------------------

-- �JOIN
SELECT * FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- �����ȣ, ����̸�, ����, �μ���, ������ �����
SELECT empno, ename, job, dname, loc, e.deptno, d.deptno -- empno���� �ֵ��� �����ص� 1�����ۿ� ������ e.�̷��� �����ص� �������
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--------------------------------------------------------------------------------------
SELECT * FROM emp e, salgrade s;
--------------------------------------------------------------------------------------

-- ��JOIN
SELECT * 
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

-- SMITH ����� ����� �̸��� ���
-- 1) ���� ���� ���
SELECT ename
FROM emp 
WHERE empno = (SELECT mgr FROM emp WHERE ename = 'SMITH');

-- 2) ���� ���(���� ���� / ��ü ����)
SELECT e1.empno AS �����ȣ, e1.ename AS ����̸�, e1.mgr AS ����ȣ,
    e2.empno AS �������ȣ, e2.ename AS ����̸�
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno
ORDER BY e1.empno;