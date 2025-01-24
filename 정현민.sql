-- 1. EMP ���̺��� ����̸���(ENAME)�� S�� ������ ����� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '%S';

-- 2. EMP ���̹����� 30�� �μ� �� ��å(JOB)�� SALESMAN��
-- �����ȣ(EMPNO), �̸�(ENAME), ��å(JOB), �޿�(SAL), �μ���ȣ(DEPTNO)�� ��ȸ
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE deptno = 30 AND job = 'SALESMAN';

-- 3. 20��, 30�� �μ��� �ٹ��ϸ鼭, �޿��� 2000�� �ʰ��ϴ� �����
-- �����ȣ(EMPNO), �̸�(ENAME), ��å(JOB), �޿�(SAL), �μ���ȣ(DEPTNO)�� ��ȸ
--  1) ���տ����� ��� ��
SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno = 20
UNION
SELECT empno, ename, job, sal, deptno FROM emp WHERE deptno = 30
INTERSECT
SELECT empno, ename, job, sal, deptno FROM emp WHERE SAL > 2000;

--  2) ���տ����� �̻�� ��
SELECT empno, ename, job, sal, deptno FROM emp
WHERE deptno IN (20, 30) AND sal > 2000;

-- 4. �޿��� 2000�̻� 3000���� ���� �̿��� �����͸� ��ȸ
-- ��, NOT BETWEEN A AND B �����ڸ� ���� ����
SELECT * FROM emp WHERE sal < 2000 OR sal > 3000;

-- 5. ��� �̸��� E�� ���ԵǾ� �ִ� 30�� �μ��� ��� ��
-- �޿��� 1000~2000 ���̰� �ƴ�
-- ����̸�(ENAME), �����ȣ(EMPNO), �޿�(SAL), �μ���ȣ(DEPTNO) ��ȸ
SELECT ename, empno, sal, deptno
FROM emp
WHERE
    ename LIKE '%E%'
    AND
    deptno = 30
    AND
    sal NOT BETWEEN 1000 AND 2000;

-- 6. �߰� ����(COMM)�� �������� �ʰ�, ����ڰ� �ְ�, ��å�� MANAGER, CLERK�� ��� �߿���
-- ��� �̸��� �� ��° ���ڰ� L�� �ƴ� ����� ������ ��ȸ
SELECT *
FROM emp
WHERE
    comm IS NULL
    AND
    mgr IS NOT NULL
    AND
    job IN ('MANAGER', 'CLERK')
    AND
    ename NOT LIKE '_L%';