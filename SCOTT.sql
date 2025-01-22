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