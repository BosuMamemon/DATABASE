-- EMP�� ��� ������ ��ȸ
select * from EMP;
-- DEPT ���̺��� ��� ������ ��ȸ
select * from DEPT;
-- EMP ���̺�: ������� ���̺�
-- DEPT ���̺�: �μ����� ���̺�

-- select ������ from ���̺� where �˻�����
-- 1. �μ���ȣ(DEPTNO)�� 10���� ���(*) ��� ������ ��ȸ
select * from EMP where DEPTNO = 10;

-- 2. �μ���ȣ�� 10���� ����� �̸�(ENAME), �Ի���(HIREDATE), �μ���ȣ(DEPTNO) ��ȸ
select ENAME, HIREDATE, DEPTNO from EMP where DEPTNO = 10;

-- 3. �����ȣ(EMPNO)�� 7369�� ����� �̸�, �Ի���, �μ���ȣ ��ȸ
select ENAME, HIREDATE, DEPTNO from EMP where EMPNO = 7369;

-- 4. �̸��� ALLEN�� ����� ��� ���� ��ȸ(�����ʹ� ��ҹ��� ������)
select * from EMP where ENAME = 'ALLEN';

-- 5. �Ի����� 1980 12 17�� ����� �̸�, �μ���ȣ, ����(SAL) ��ȸ�ϱ�
-- (DATE �ڷ����� �⵵ �� 2�ڸ��� �����ص� �ν���)
select ENAME, DEPTNO, SAL from EMP where HIREDATE = '1980/12/17';
select ENAME, DEPTNO, SAL from EMP where HIREDATE = '80/12/17';

-- 6. ����(JOB)�� MANAGER�� ����� ��� ���� ��ȸ
select * from EMP where JOB = 'MANAGER';

-- 7. ����(JOB)�� MANAGER�� �ƴ� ����� ��� ���� ��ȸ
select * from EMP where JOB != 'MANAGER';
select * from EMP where JOB <> 'MANAGER';

-- 8. �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ��� ���� ��ȸ
select * from EMP where HIREDATE >= '81/04/02';
describe EMP;
desc EMP; -- ���� ���� ����

-- 9. �޿�(SAL)�� 1000 �̻��� ����� �̸�, �޿�, �μ���ȣ ��ȸ
select ENAME, SAL, DEPTNO from EMP where SAL >= 1000;

-- 10. -- 9. �޿�(SAL)�� 1000 �̻��� ����� �̸�, �޿�, �μ���ȣ ��ȸ
-- �޿��� ���� ������ ��ȸ!!
select ENAME, SAL, DEPTNO from EMP where SAL >= 1000 order by SAL desc;
select ENAME, SAL, DEPTNO from EMP where SAL >= 1000 order by SAL asc;
-- desc -> descending
-- asc -> ascending (�⺻��)
-- ** �޿��� ������������ ��ȸ / �޿��� ���ٸ� �̸����� ��������
select ENAME, SAL, DEPTNO
from EMP
where SAL >= 1000
order by SAL desc, ENAME;

-- 11. �̸��� 'K'�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ���� ��ȸ
select *
from EMP
where ENAME > 'K'; -- ���ĺ����� �� ������ �� �� ����

-- ���� ������(union)
-- EMP ���̺��� �μ���ȣ�� 10�� ����� �����ȣ, �̸�, �޿�, �μ���ȣ ��ȸ
-- EMP ���̺��� �μ���ȣ�� 20�� ����� �����ȣ, �̸�, �޿�, �μ���ȣ ��ȸ
-- �� ����� ���ļ� ��ȸ
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 10
union
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 20;

-- ��� �μ� �߿��� �μ���ȣrk 20�� �μ��� �����ϰ� ��ȸ(���տ�����(MINUS) ���)
select * from EMP
minus
select * from EMP where DEPTNO = 20;
-- ���� ������ INTERSECT = ������!!!
select * from EMP
intersect
select * from EMP where DEPTNO = 20;

-- 12. �μ���ȣ�� 10�̰ų� 20�� �μ��� ��� ��� ���� ��ȸ
select EMPNO, ENAME, SAL, DEPTNO from EMP
where DEPTNO = 10 or DEPTNO = 20;
select EMPNO, ENAME, SAL, DEPTNO from EMP
where DEPTNO in (10, 20); -- in�� �̿��ϸ� = �ڿ� ������ ���ڸ� ���� �� ����

-- 13. ����̸��� s�� ������ ����� ��� ���� ��ȸ
select *  from EMP where ENAME like '%S';
    -- %�� �տ� � ���ڿ��̵� �� �� �ִٴ� ��
    -- =�� ��Ȯ�� ���� �ν��ϹǷ� %���� ��ȣ�� ������ like�� �����
    
-- 14. 30�� �μ����� �ٹ��ϴ� ��� �� JOB�� SALESMAN�� �����
-- �����ȣ, �̸�, ��å, �޿�, �μ���ȣ ��ȸ
select EMPNO, ENAME, JOB, SAL, DEPTNO from EMP
where DEPTNO = 30 and JOB = 'SALESMAN';

-- 15. 30�� �μ����� �ٹ��ϴ� ��� ��
-- JOB�� SALESMAN�� �����
-- �����ȣ, �̸�, ��å, �޿�, �μ���ȣ��
-- �޿��� ���� ������ ��ȸ
select EMPNO, ENAME, JOB, SAL, DEPTNO
from EMP
where DEPTNO = 30 and JOB = 'SALESMAN'
order by SAL desc;

-- 16. 30�� �μ����� �ٹ��ϴ� ��� ��
-- JOB�� SALESMAN�� �����
-- �����ȣ, �̸�, ��å, �޿�, �μ���ȣ��
-- �޿��� ���� ������ ��ȸ, �޿��� ���ٸ� �����ȣ�� ���� �� ���� ���
select EMPNO, ENAME, JOB, SAL, DEPTNO
from EMP
where DEPTNO = 30 and JOB = 'SALESMAN'
order by SAL desc, EMPNO asc;

-- [20��, 30�� �μ��� �ٹ��ϴ� ��� �߿���
--  �޿��� 2000�� �ʰ��ϴ� �����
--  �����ȣ, �̸�, �޿�, �μ���ȣ�� ��ȸ�϶�.]

-- 17. ���� �����ڸ� ����Ͽ� ��ȸ
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 20
UNION
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 30
INTERSECT
select EMPNO, ENAME, SAL, DEPTNO from EMP where SAL > 2000;

--18. ���� �����ڸ� ������� �ʰ� ��ȸ
select EMPNO, ENAME, SAL, DEPTNO from EMP
where (DEPTNO = 20 or DEPTNO = 30) and SAL > 2000;
select EMPNO, ENAME, SAL, DEPTNO from EMP
where DEPTNO in (20, 30) and SAL > 2000;

-- 19. �޿��� 2000 �̻� 3000 ���� ������ ��� ���� ��ȸ
SELECT * FROM EMP where SAL >= 2000 AND SAL <= 3000;
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- 20. �޿��� 2000 �̻� 3000 ���� ���� �̿��� ��� ���� ��ȸ
SELECT * FROM EMP WHERE SAL NOT BETWEEN 2000 AND 3000;
SELECT * FROM EMP
MINUS
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000;

-- 21. ����̸�, �����ȣ, �޿�, �μ���ȣ ��ȸ
SELECT ENAME, EMPNO, SAL, DEPTNO FROM EMP;
SELECT ENAME AS ����̸�,
EMPNO �����ȣ, -- AS�� ����ǥ ����������, ��� ������ �������� ū����ǥ�� �����, �ƴ� _ ������
SAL �޿�,
DEPTNO �μ���ȣ
FROM EMP;

-- 22. ����̸��� E�� ���ԵǾ� �ִ� 30�� �μ� ��� �߿���
-- �޿��� 1000 ~ 2000 ���̰� �ƴ� ����� ��ȸ.
-- �� �÷����� ����̸�, ��� ��ȣ, �޿�, �μ� ��ȣ �̿�.
SELECT ENAME AS "����̸�", EMPNO AS "��� ��ȣ", SAL AS "�޿�", DEPTNO AS "�μ� ��ȣ"
FROM EMP
WHERE ENAME LIKE '%E%'
AND DEPTNO = 30
AND SAL NOT BETWEEN 1000 AND 2000;

-- 23. �ְ�����(COMM)�� �������� �ʴ� ��� ���� ��ȸ
SELECT * FROM EMP WHERE COMM IS NULL; -- NULL�����Ŷ� ��ġ�ϴ°� ������ IS �����

-- 24. �ְ������� �����ϴ� ����� ���� ��ȸ (�� COMM�� 0�� ����� ����)
SELECT * FROM EMP
WHERE COMM IS NOT NULL
AND NOT COMM = 0;

-- 25. �ְ�����(comm)�� �������� �ʰ�, �����(mgr)�� �ְ�, 
-- ������ MANAGER, CLERK �� ���  �߿��� 
-- ����̸��� �ι�° ���ڰ� L�� �ƴ� ��� ���� ���

-- ������ _�� ���� ������ �ѱ��ڸ� ����.
SELECT * FROM EMP
WHERE COMM IS NULL
    AND MGR IS NOT NULL
    AND JOB IN (MANAGER, CLERK)
    AND ENAME NOT LIKE '_L%';
    
--------------------------p128 ����Ŭ�Լ�(�����Լ�) ------------------------------
-- <���ڿ� ���� �����Լ�>
-- upper(������) : �빮�ڷ� �ٲ��ִ� �����Լ�
-- lower(������) : �ҹ��ڷ� �ٲ��ִ� �����Լ�
-- initcap(������) : ù���ڸ� �빮�ڷ� �ٲ��ִ� �����Լ�

select * from emp;
select ename, upper(ename) as �빮��, lower(ename) AS �ҹ���, initcap(ename)
from emp ;

--<�� ��>
-- length(������) : �̸��� ���ڼ��� �˷���
select ename, length(ename) AS �̸����ڼ� from emp;
-- ����̸�(ename)�� 5���� �̻��� ����� �̸�(ename), ���ڼ� ���
select ename, length(ename) AS �̸����ڼ� from emp where length(ename)>=5;

-- �̸� ����
-- substr(������,������ġ,����) : ������ �Ϻκи� �����ؼ� ���, ������ �Ⱦ��� ������ ���
select ename ,substr(ename, 1, 2), substr(ename, 3, 2), substr(ename, 3), 
        substr(ename, 3, length(ename)),
        length(substr(ename, 3)), length(substr(ename,3,length(ename)))
        -- �ΰ��� ����� ���ڼ��� ����.-> �ڿ� �������
        from emp;
--------------------------------------------------------------------------------
-- dual : ����ִ� ���̺��� ������ִ°� ����.
select 'CORPORATE'
from dual;

-- ��ġ�� ����
-- instr(���� or ������, ã�� ����, ��𼭺��� , ���°�� ��ġ�ϴ��� ) : �� ������ ��ġ�� ������ ����
select instr('CORPORATE FLOOR', 'OR', 1, 1)
from dual;
select instr('CORPORATE FLOOR', 'OR')       -- �ڸ� �����ϸ� ���Ƕ�� �Ȱ�����(1,1)�� �Ǵ���.
from dual;
select instr('CORPORATE FLOOR', 'OR', 1, 2)  -- �ι�°�� OR �� ������ ������ ������ �� O�� ��ġ�� ��ȯ
from dual;
select instr('CORPORATE FLOOR', 'OR', -1, 2)  -- -1�� ���⿡ ���� �ڿ��� ���� 2��°�� ������ OR ���� ��ġ�� ��ȯ
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 1)  -- -3�̹Ƿ� �ڿ��� 3��°���ں��� �����ؼ� OR�� 1��° ������ O�� ��ġ�� ��ȯ
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 2)  -- -3�̹Ƿ� �ڿ��� 3��°���ں��� �����ؼ� OR�� 2��° ������ O�� ��ġ�� ��ȯ
from dual;
-- ���ڿ� ABCDDEF ���� D�� ��ġ�� ���
-- ó������ => 4
select instr('ABCDDEF', 'D') from dual;
select instr('ABCDDEF', 'D', 1, 1) from dual;
-- ������  => 5
select instr('ABCDDEF', 'D', -1, 1) from dual;
-- emp ���̺��� ename �� s�� �ִ� ��ġ ���
select ename, instr(ename, 'S'), instr(ename, 'S',-1,1)
from emp;
-- emp���̺��� ����̸��� s�� ����ִ� �̸��� ���(instr �Լ� ���)
select * from emp where ename like '%S%';  -- like '%S%'�� �̿��Ͽ�
select ename from emp where instr(ename, 'S') > 0;
-- emp ���̺��� ename ���(�̸��� 2���ڸ� �����Ͽ� �ҹ��ڷ� ��ȯ�Ͽ� ���) 
select ename, lower( substr(ename,1,2) ) �ҹ���1, substr(lower( ename ),1,2) �ҹ���2 from emp;

-- Replace(�ٲ� ������ or �����Ͱ�, �ٲܹ���, �ٲ���) : 
select '010-1234-5678' as rep_before,
    replace('010-1234-5678', '-', ' ') as rep_after
from dual;
--emp ���̺��� s�� �ҹ��� s�� �����Ͽ� ���(replace �Լ� ���)
select ename, replace(ename, 'S', 's') 
from emp;
select length('�ѱ�'), lengthB('�ѱ�')
from dual;

select 'Oracle', length('Oracle'), lengthB('Oracle')
from dual;

select 'Oracle', LPAD('Oracle', 10, '#') LPAD1,
RPAD('Oracle', 10, '#') RPAD1,
LPAD('Oracle', 10) LPAD2, -- �⺻���� ������
RPAD('Oracle', 10) RPAD2
FROM DUAL;

-- EMP ���̺��� �����ȣ(�� 2�ڸ� ����, �������� *) �����ȣ
-- ����̸�(ù 2���ڸ� ������ �������� *) ����̸�
SELECT RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS "�����ȣ",
    RPAD(SUBSTR(ENAME, 1, 2), LENGTH(ENAME), '*') AS "����̸�"
FROM EMP;

-- P.141
SELECT
    RPAD('960104-', 14, '*') AS RPAD_JMNO,
    RPAD('010-1234-', 13, '*') AS RPAD_PHONE
FROM DUAL;

----------------------------------------------------------------------------

-- 1. JUMIN 7510231901810 -> 751023*******
SELECT RPAD(SUBSTR(JUMIN, 1, 6), 13, '*') AS JUMIN FROM STUDENT;

-- 2. TEL 055)381-2158 -> 055-381-2158
SELECT REPLACE(TEL, ')', '-') AS TEL FROM STUDENT;

-- 3. Ű(HEIGHT)�� 170 �̻��� �л��� STUDNO, NAME, GRADE, HEIGHT, WEIGHT ��ȸ
--  Ű�� ū �л� ������ ��ȸ, Ű�� ���ٸ� STUDNO�� ���� ������ ��ȸ
SELECT STUDNO, NAME, GRADE, HEIGHT, WEIGHT 
FROM STUDENT
WHERE HEIGHT >= 170
ORDER BY HEIGHT DESC, STUDNO ASC;

-- 4. PROFESSOR ���̺��� ���ʽ��� ���� ���ϴ� �����
--  PROFNO, NAME, PAY, BONUS ��ȸ
SELECT PROFNO, NAME, PAY, BONUS
FROM PROFESSOR
WHERE BONUS IS NULL;

-- 5. PROFESSOR ���̺��� EMAIL �߿��� ���̵� ��ȸ�Ͻÿ�
SELECT SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS EMAIL_ID
FROM PROFESSOR;

----------------------------------------------------------------------------

SELECT * FROM emp;

-- 1. ���ڿ� ����(concat) ��, concat�� �μ��� 2�������ۿ� �� ����
SELECT concat(ename, job) AS concat FROM emp;

-- 2. ename:job�� �÷� �ϳ��� ��� ex) SMITH:CLERK <- �������� ���
SELECT concat(concat(ename, ':'), job) AS dbl_concat FROM emp;
SELECT concat(ename, concat(':', job)) AS dbl_concat FROM emp;

-- p.142 ���ڿ� ���� (||)
SELECT ename || ':' || job AS "�̸�:����"
FROM emp;

-- ���� ����(TRIM �Լ�)
SELECT '     oracle     ', LENGTH('     oracle     '),
    TRIM('     oracle     '), LENGTH(TRIM('     oracle     ')) AS TRIM����,
    LTRIM('     oracle     '), LENGTH(LTRIM('     oracle     ')) AS LTRIM����,
    RTRIM('     oracle     '), LENGTH(RTRIM('     oracle     ')) AS RTRIM����
FROM dual;

-- ���� ���� �Լ�
-- �ݿø�: ROUND()
SELECT 123.567, ROUND(123.567), ROUND(123.567, 1), ROUND(123.567, 2),
    ROUND(123.567, -1)
FROM dual;
-- ����: TRUNC()
SELECT 15.793, TRUNC(15.793), TRUNC(15.793, 1), TRUNC(15.793, 2),
    TRUNC(15.793, -1)
FROM dual;
-- �ø�(���� ����� ū ����): CEIL()
SELECT 3.14, CEIL(3.14)
FROM dual;
-- ���� ����� ���� ����: FLOOR()
SELECT 3.14, FLOOR(3.14)
FROM dual;
-- TRUNC, CEIL, FLOOR ��
SELECT TRUNC(3.14), CEIL(3.14), FLOOR(3.14), TRUNC(-3.14), CEIL(-3.14), FLOOR(-3.14)
FROM dual;
-- ����: POWER()
SELECT POWER(2, 3) FROM dual;
-- ������: MOD()
SELECT MOD(15, 6) FROM dual;

-- ��¥ ���� �Լ�
SELECT sysdate AS ����, sysdate + 1 AS ����, sysdate - 1 AS ����,
    sysdate + 3
FROM dual;
-- 3���� ��
SELECT sysdate, ADD_MONTHS(sysdate, 3), ADD_MONTHS('22/05/01', 3)
FROM dual;
-- emp ���̺��� �����ȣ(empno), �̸�(ename), �Ի���(hiredate) ���
-- �Ի� 10�� �� ��¥�� '�Ի�10����' �������� ���
SELECT empno, ename, hiredate, ADD_MONTHS(hiredate, 120) AS �Ի�10����
FROM emp;
SELECT MONTHS_BETWEEN(sysdate, '24/01/24') FROM dual;
-- emp ���̺��� �̸�, �ٹ����� ��(�Ҽ��� ��°�ڸ����� ����) ���
SELECT ename, hiredate, TRUNC(MONTHS_BETWEEN(sysdate, hiredate), 1) AS �ٹ�������
FROM emp;
-- �ٹ������� ���, �� '����'�̶�� ���ڸ� ���̰� ���, �Ҽ��� ���ϴ� ����
-- ��, CONCAT�Լ� ���
SELECT CONCAT(TRUNC(MONTHS_BETWEEN(sysdate, hiredate)), '����') AS �ٹ�������
FROM emp;

-- NEXT_DAY, LAST_DAY �Լ�
SELECT sysdate, NEXT_DAY(sysdate, '������') AS ������,
    NEXT_DAY(sysdate, '�����') AS �����,
    LAST_DAY(sysdate) AS ��������,
    LAST_DAY('96/01/04')
FROM dual;

-- �����ȣ(empno)�� ¦���� ����� �����ȣ(empno), �̸�(ename), ����(job) ���
SELECT empno, ename, job
FROM emp
WHERE MOD(empno, 2) = 0;

-- �޿�(sal)�� 1500���� 3000 ������ ����� �� �޿��� 15%�� ȸ��� ����
-- �̸�, �޿�, ȸ��(�ݿø�) ���
SELECT ename, sal, ROUND(sal * 0.15) AS ȸ��
FROM emp
WHERE sal BETWEEN 1500 AND 3000;

-- p.157 �� ��ȯ �Լ�
describe emp;
SELECT empno, ename, empno + '500' -- '500'�� ���ڷ� ����ȯ�Ǿ���
FROM emp;

-- ���ڿ��� ��ȯ���ִ� �Լ� TO_CHAR(��, ����)
SELECT TO_CHAR(sysdate, 'mm')�� FROM dual;
SELECT TO_CHAR(sysdate, 'dd')�� FROM dual;
SELECT TO_CHAR(sysdate, 'hh')�� FROM dual;
SELECT TO_CHAR(sysdate, 'mi')�� FROM dual;
SELECT TO_CHAR(sysdate, 'ss')�� FROM dual;
SELECT TO_CHAR(sysdate, 'mon')�� FROM dual;
SELECT TO_CHAR(sysdate, 'month')�� FROM dual;
SELECT TO_CHAR(sysdate, 'day')���� FROM dual;

-- �Ի����� 1, 2, 3���� ����� ��ȣ, �̸�, �Ի��� ���
SELECT empno, ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'mm') IN (1, 2, 3);

SELECT TO_CHAR(sal, '$999,999') sal_$,
    TO_CHAR(sal, 'L999,999') sal_$,
    TO_CHAR(sal, '999,999') sal_9,
    TO_CHAR(sal, '000,999') sal_0
FROM emp;

-- TO_NUMBER(��, �ν��� ����)
SELECT 1300 - 1500 FROM dual;
SELECT TO_NUMBER('1300') - TO_NUMBER('1500') FROM dual;
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500','999,999')
FROM dual;
-- SELECT TO_NUMBER('1,300') - TO_NUMBER('1,500') FROM dual; <- �̰� ����

-- p.164 '20240727' �긦 ��¥������ �ٲٱ� TO_DATE(��, ����)
SELECT TO_DATE('20240727') as str_date FROM dual;

-- 81/12/03 ���� �Ի��� ��� ���
SELECT * FROM emp WHERE hiredate >= TO_DATE('81/12/03');

----------------------------------------------------------------------------
-- NVL(��, null�϶� ���� ��) <- null�� ġȯ����
-- ���, �̸�, �޿�, Ŀ�̼�, �޿�+Ŀ�̼� ��� (null+���� = null��)
SELECT empno, ename, comm, sal + comm AS ����
FROM emp;
SELECT empno, ename, comm, sal + nvl(comm, 0) AS ����
FROM emp;

-- ���, �̸�, �޿�, Ŀ�̼�, �޿�+Ŀ�̼�(col=����) ���
-- ��, ������ õ������ �����Ͽ� ���
SELECT empno, ename, comm, TO_CHAR((sal + nvl(comm, 0)) * 12, '999,999') AS ����
FROM emp;

-- NVL2(��, null�� �ƴҶ� ġȯ�� ��, null�� �� ġȯ�� ��)
-- comm�� ������ O, ���� ������ X��� ���
SELECT empno, ename, comm, NVL2(comm, 'O', 'X')
FROM emp;

-- ���� ��� (��, NVL2 ���)
SELECT empno, ename, sal, sal * 12 + NVL2(comm, comm, 0) AS ����,
    TO_CHAR(sal * 12 + NVL2(comm, comm, 0), '999,999') AS ����2
FROM emp;

-- empno, ename, mgr ��� / ��, mgr�� null�̸�, 'CEO' ���
SELECT empno, ename, NVL2(mgr, TO_CHAR(mgr), 'CEO') AS mgr
FROM emp;

------------------------------------

-- p.170
-- DECODE() -> if�� �Լ�
-- job�� ���� �޿� �ٸ��� �λ�
-- MANAGER 1.5 / SALESMAN 1.2 / ANALYST 1.05 / 1.04
SELECT empno, ename, job, sal,
    DECODE(job, 'MANAGER', sal * 1.5, 'SALESMAN', sal * 1.2,
        'ANALYST', sal * 1.05, sal * 1.04) AS �λ�SAL
FROM emp;
-- CASE WHEN THEN END
SELECT empno, ename, job, sal,
    CASE job
        WHEN 'MANAGER' THEN sal * 1.5
        WHEN 'SALESMAN' THEN sal * 1.2
        WHEN 'ANALYST' THEN sal * 1.05
        ELSE sal * 1.04
    END AS �λ�޿�
FROM emp;
SELECT empno, ename, job, sal,
    CASE
        WHEN job = 'MANAGER' THEN sal * 1.5
        WHEN job = 'SALESMAN' THEN sal * 1.2
        WHEN job = 'ANALYST' THEN sal * 1.05
        ELSE sal * 1.04
    END AS �λ�޿�
FROM emp;

-- comm�� null�̸� '�ش���� ����', comm = 0�̸� '���� ����',
-- comm�� ������ '����: ~~' ���
-- 1) DECODE() ���
SELECT empno, ename, comm,
    DECODE(comm, null, '�ش���� ����', 0, '���� ����', CONCAT('����: ', comm)) AS comm_txt
FROM emp;

-- 2) CASE ���
SELECT empno, ename, comm,
    CASE
        WHEN comm IS null THEN '�ش���� ����'
        WHEN comm = 0 THEN '���� ����'
        ELSE CONCAT('����: ', comm)
        END AS comm_txt
FROM emp;

------------------------------------------------------------------------------------------

-- professor ���̺�
-- 1. professor ���̺� name�� deptno, �а��� ���
-- ��, deptno = 101�̸� '��ǻ�Ͱ��а�'
-- 1) case��
SELECT name, deptno,
    CASE
        WHEN deptno = 101 THEN '��ǻ�Ͱ��а�'
        END AS �а���
FROM professor;

-- 2) DECODE
SELECT name, deptno, DECODE(deptno, 101, '��ǻ�Ͱ��а�')
FROM professor;

-- 2. professor ���̺� name�� deptno, �а��� ���
-- ��, deptno = 101�̸� '��ǻ�Ͱ��а�', ������ �а��� ��Ÿ�� ���
-- 1) case��
SELECT name, deptno,
    CASE
        WHEN deptno = 101 THEN '��ǻ�Ͱ��а�'
        ELSE '��Ÿ'
        END AS �а���
FROM professor;

-- 2) DECODE
SELECT name, deptno, DECODE(deptno, 101, '��ǻ�Ͱ��а�', '��Ÿ')
FROM professor;

-- 3. professor ���̺� name�� deptno, �а��� ���
-- ��, deptno = 101�̸� '��ǻ�Ͱ��а�'
-- 102�� ��Ƽ�̵�� ���а�
-- 201�̸� ����Ʈ������а�
-- �������� ��Ÿ ���
-- 1) case��
SELECT name, deptno,
    CASE deptno
        WHEN 101 THEN '��ǻ�Ͱ��а�'
        WHEN 102 THEN '��Ƽ�̵����а�'
        WHEN 201 THEN '����Ʈ������а�'
        ELSE '��Ÿ'
        END AS �а���
FROM professor;

-- 2) DECODE
SELECT name, deptno,
    DECODE(deptno, 101, '��ǻ�Ͱ��а�', 102, '��Ƽ�̵����а�', 201, '����Ʈ������а�', '��Ÿ') AS �а���
FROM professor;

-- student ���̺��� �л��� 3���� ������ �з���
-- studno�� 3���� ������
-- �������� 0�̸� A��, 1�̸� B��, 2�̸� C��
-- studno, name, deptno1, ���̸�
-- CASE
SELECT studno, name, deptno1,
    CASE MOD(studno, 3)
        WHEN 0 THEN 'A'
        WHEN 1 THEN 'B'
        WHEN 2 THEN 'C'
        END AS ���̸�
FROM student;

-- DECODE()
SELECT studno, name, deptno1,
    DECODE(MOD(studno, 3), 0, 'A', 1, 'B', 2, 'C') AS ���̸�
FROM student;

-- 1. �л� ���̺��� jumin 7��° ���ڰ� 1�̸� ����, 2�� ����
-- studno, name, jumin, �� �÷�(����)
SELECT studno, name, jumin,
    DECODE(SUBSTR(jumin, 7, 1), 1, '����', 2, '����') AS ����
FROM student;
