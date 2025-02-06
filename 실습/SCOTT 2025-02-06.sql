-- 1. ACCOUNTING(dname) �μ� �Ҽ� ����� �̸��� �Ի��� ���
-- Oracle ����
SELECT * FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    AND dname = 'ACCOUNTING';
-- SQL-99 ǥ�� ����
SELECT *
FROM emp JOIN dept ON emp.deptno = dept.deptno
WHERE dname = 'ACCOUNTING';

-- 2. 0���� ���� comm�� �޴� ����̸��� �μ��� ���
SELECT ename, dname, comm
FROM emp JOIN dept ON emp.deptno = dept.deptno
WHERE
    comm IS NOT NULL
    AND comm > 0;
-- Oracle ����
SELECT ename, dname, comm
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    AND comm IS NOT NULL
    AND comm > 0;

-- 3. ������ �Ŵ����� �����Դϴ�
-- ex) SMITH�� �Ŵ����� FORD�Դϴ�.
SELECT emp.ename || '�� �Ŵ����� ' || mgr.ename || '�Դϴ�.' AS col
FROM emp emp JOIN emp mgr ON emp.mgr = mgr.empno;
-- Oracle ����
SELECT emp.ename || '�� �Ŵ����� ' || mgr.ename || '�Դϴ�.' AS col
FROM emp emp, emp mgr
WHERE
    emp.mgr = mgr.empno;
    
-----------------------------------------------------------------------------------------------------------------------------------

-- 1. emp, dept ���̺���,
-- ���忡�� �ٹ��ϴ� ����� �̸�(ename), �޿�(sal)�� ���
SELECT
    loc �ٹ�����, ename �̸�, sal �޿�
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE
    loc = 'NEW YORK';
    
-- 2. emp ���̺���,
-- �Ŵ���(mgr)�� �̸��� KING�� ������� �̸��� ������ ���
SELECT
    mgr.ename �Ŵ���, emp.ename ���, emp.job ����
FROM emp emp
    JOIN emp mgr
        ON emp.mgr = mgr.empno
WHERE
    mgr.ename = 'KING';
-- ���� ���� ���
SELECT
    ename ���, job ����
FROM emp 
WHERE
    mgr =
        (
            SELECT empno
            FROM emp
            WHERE ename = 'KING'
        );

-- 3. emp ���̺���.
-- SMITH�� ���� �μ��� �ִ� ������ �̸��� ���
SELECT ename
FROM emp
WHERE
    deptno =
        (
            SELECT deptno
            FROM emp
            WHERE ename = 'SMITH'
        )
    AND
    NOT ename = 'SMITH';
-- ���� ���� ���
SELECT e1.ename
FROM emp e1
    JOIN emp e2
        ON e1.deptno = e2.deptno
WHERE
    e2.ename = 'SMITH'
    AND
    NOT e1.ename = 'SMITH';
-- ���� ���� ����Ŭ ����
SELECT e1.ename
FROM emp e1, emp e2
WHERE
    e1.deptno = e2.deptno
    AND
    e2.ename = 'SMITH'
    AND
    NOT e1.ename = 'SMITH';
    
-- p.229
-- emp ���̺�
-- �����ȣ, ����̸�, ���, �������ȣ, ����̸�
SELECT
    e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���, e2.empno �������ȣ, e2.ename ����̸�
FROM emp e1
    JOIN emp e2
        ON e1.mgr = e2.empno
ORDER BY e1.empno;
-- e1.mgr�� ���� null�� KING�� ����� ���� ����

-- �ܺ� ����(outer join)
-- ��� ����� ���� �����ȣ, ����̸�, ���, �������ȣ, ����̸� ���
-- null�� ������ ��� �����Ͱ� ���;߸� �ϴ� emp�� �������� OUTER JOIN�� ���� ��
-- ��� �����Ͱ� ���;߸� �ϴ� emp(e1)�� ���ʿ� ������ ���
SELECT
    e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���, e2.empno �������ȣ, e2.ename ����̸�
FROM emp e1
    LEFT OUTER JOIN emp e2
        ON e1.mgr = e2.empno
ORDER BY e1.empno;
-- ��� �����Ͱ� ���;߸� �ϴ� emp(e1)�� �����ʿ� ������ ���
SELECT
    e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���, e2.empno �������ȣ, e2.ename ����̸�
FROM emp e1
    RIGHT OUTER JOIN emp e2
        ON e2.mgr = e1.empno
ORDER BY e2.empno;
-- null���� ������ ���̺� null���� ä���ִ� ���
SELECT
    e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���, e2.empno �������ȣ, e2.ename ����̸�
FROM emp e1
    JOIN emp e2
        ON e1.mgr = e2.empno(+)
ORDER BY e1.empno;
-- ����Ŭ ����
SELECT
    e1.empno �����ȣ, e1.ename ����̸�, e1.mgr ���, e2.empno �������ȣ, e2.ename ����̸�
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno(+)
ORDER BY e1.empno;

-- ��� �μ��� ����̸�(ename), �μ���ȣ(deptno), �μ���(dname) ���
SELECT
    ename, dept.deptno, dname
FROM emp
    RIGHT OUTER JOIN dept
        ON emp.deptno = dept.deptno;
-- ����Ŭ ����
SELECT
    ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;

-- p.232
-- sal 2000���� ū �����ȣ, �̸�, �޿�, ���, �μ���ȣ, �μ���, ���� ���
SELECT
    e1.empno �����ȣ, e1.ename �̸�, e1.sal �޿�, e2.ename ���,
    dept.deptno �μ���ȣ, dept.dname �μ���, dept.loc ����
FROM emp e1
    JOIN emp e2
        ON e1.mgr = e2.empno
    JOIN dept
        ON e1.deptno = dept.deptno
WHERE e1.sal > 2000;
-- NATURAL JOIN: ���� �÷����� �ڵ����� JOIN�����ִ� ��ɾ�
SELECT
    empno �����ȣ, ename �̸�, sal �޿�, ename ���,
    deptno �μ���ȣ, dname �μ���, loc ����
FROM emp
    NATURAL JOIN dept
WHERE sal > 2000;
-- JOIN USING(����� ��)
SELECT
    empno �����ȣ, ename �̸�, sal �޿�, ename ���,
    deptno �μ���ȣ, dname �μ���, loc ����
FROM emp
    JOIN dept USING(deptno)
WHERE sal > 2000;
-- p.240 JOIN ON(���� ���� ���� ���)
SELECT
    empno �����ȣ, ename �̸�, sal �޿�, ename ���,
    dept.deptno �μ���ȣ, dname �μ���, loc ����
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE sal > 2000;

-- p.238
-- emp, dept ���̺���,
-- empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc ���
-- ��, �޿�(sal)�� 2000 �̻��̸�, ���(mgr)�� �ݵ�� ���Խ��Ѿ� �Ѵ�
-- 1) JOIN USING() ���
SELECT *
FROM emp
    JOIN dept USING(deptno)
WHERE
    sal >= 2000
    AND
    mgr IS NOT NULL;

-- 2) NATURAL JOIN ���
SELECT *
FROM emp
    NATURAL JOIN dept
WHERE
    sal >= 2000
    AND
    mgr IS NOT NULL;

-- 3) JOIN ON ���
SELECT
    empno, ename, job, mgr, hiredate, sal, comm,
    dept.deptno, dname, loc
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE
    sal >= 2000
    AND
    mgr IS NOT NULL;
    

-- p.242
-- WARD ������� ������ ���� �޴� ��� �̸� ���
SELECT ename, sal
FROM emp
WHERE sal >= (SELECT sal
            FROM emp
            WHERE ename = 'WARD')
ORDER BY sal;

-- 'ALLEN'�� ������ ���� ����� �̸�, �μ���, �޿�, ���� ���
SELECT ename, dname, sal, job
FROM emp
    NATURAL JOIN dept
WHERE
    job = (SELECT job
            FROM emp
            WHERE ename = 'ALLEN')
    AND NOT ename = 'ALLEN';
    
-- ��ü ����� ����ӱݺ��� �ӱ��� ���� �޴� ����� �����ȣ, �̸�, �μ���, �Ի��� ���
SELECT empno, ename, dname, hiredate
FROM emp
    NATURAL JOIN dept
WHERE
    sal > (SELECT avg(sal)
            FROM emp);
-- ALLEN���� ���� �Ի��� ����� ����
SELECT *
FROM emp
WHERE hiredate < (SELECT hiredate
                    FROM emp
                    WHERE ename = 'ALLEN');
                    
-- p.248
-- ��ü ����� ��ձ޿����� �۰ų� ���� �޿��� �޴� 20�� �μ��� ��� �� �μ�����
-- empno, ename, job, sal, deptno, dname, loc
-- ����Ŭ ����
SELECT
    emp.empno, emp.ename, emp.job, emp.sal,
    dept.deptno, dept.dname, dept.loc
FROM emp, dept
WHERE
    emp.deptno = dept.deptno
    AND
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    deptno = 20;

-- NATURAL JOIN ���
SELECT empno, ename, job, sal, deptno, dname, loc
FROM emp
    NATURAL JOIN dept
WHERE
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    deptno = 20;
    
-- JOIN USING ���
SELECT empno, ename, job, sal, deptno, dname, loc
FROM emp
    JOIN dept USING(deptno)
WHERE
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    deptno = 20;
    
-- JOIN ON ���
SELECT
    emp.empno, emp.ename, emp.job, emp.sal,
    dept.deptno, dept.dname, dept.loc
FROM emp
    JOIN dept
        ON emp.deptno = dept.deptno
WHERE
    sal <= (SELECT avg(sal)
            FROM emp)
    AND
    dept.deptno = 20;

-- ������ ��������
-- �� �μ��� �ְ�޿��� ������ �޿��� �޴� ��� ���� ���
SELECT *
FROM emp
WHERE
    sal IN (SELECT max(sal)
            FROM emp
            GROUP BY deptno);