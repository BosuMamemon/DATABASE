-- EMP의 모든 정보를 조회
select * from EMP;
-- DEPT 테이블의 모든 정보를 조회
select * from DEPT;
-- EMP 테이블: 사원정보 테이블
-- DEPT 테이블: 부서정보 테이블

-- select 데이터 from 테이블 where 검색조건
-- 1. 부서번호(DEPTNO)가 10번인 모든(*) 사원 정보를 조회
select * from EMP where DEPTNO = 10;

-- 2. 부서번호가 10번인 사원의 이름(ENAME), 입사일(HIREDATE), 부서번호(DEPTNO) 조회
select ENAME, HIREDATE, DEPTNO from EMP where DEPTNO = 10;

-- 3. 사원번호(EMPNO)가 7369인 사원의 이름, 입사일, 부서번호 조회
select ENAME, HIREDATE, DEPTNO from EMP where EMPNO = 7369;

-- 4. 이름이 ALLEN인 사원의 모든 정보 조회(데이터는 대소문자 구분함)
select * from EMP where ENAME = 'ALLEN';

-- 5. 입사일이 1980 12 17인 사원의 이름, 부서번호, 월급(SAL) 조회하기
-- (DATE 자료형은 년도 앞 2자리를 생략해도 인식함)
select ENAME, DEPTNO, SAL from EMP where HIREDATE = '1980/12/17';
select ENAME, DEPTNO, SAL from EMP where HIREDATE = '80/12/17';

-- 6. 직업(JOB)이 MANAGER인 사원의 모든 정보 조회
select * from EMP where JOB = 'MANAGER';

-- 7. 직업(JOB)이 MANAGER가 아닌 사원의 모든 정보 조회
select * from EMP where JOB != 'MANAGER';
select * from EMP where JOB <> 'MANAGER';

-- 8. 입사일이 81/04/02 이후에 입사한 사원의 모든 정보 조회
select * from EMP where HIREDATE >= '81/04/02';
describe EMP;
desc EMP; -- 위랑 같은 말임

-- 9. 급여(SAL)가 1000 이상인 사원의 이름, 급여, 부서번호 조회
select ENAME, SAL, DEPTNO from EMP where SAL >= 1000;

-- 10. -- 9. 급여(SAL)가 1000 이상인 사원의 이름, 급여, 부서번호 조회
-- 급여가 높은 순으로 조회!!
select ENAME, SAL, DEPTNO from EMP where SAL >= 1000 order by SAL desc;
select ENAME, SAL, DEPTNO from EMP where SAL >= 1000 order by SAL asc;
-- desc -> descending
-- asc -> ascending (기본값)
-- ** 급여를 내림차순으로 조회 / 급여가 같다면 이름으로 오름차순
select ENAME, SAL, DEPTNO
from EMP
where SAL >= 1000
order by SAL desc, ENAME;

-- 11. 이름이 'K'로 시작하는 사람보다 높은 이름을 가진 사원의 모든 정보 조회
select *
from EMP
where ENAME > 'K'; -- 알파벳에도 비교 연산자 쓸 수 있음

-- 집합 연산자(union)
-- EMP 테이블에서 부서번호가 10인 사원의 사원번호, 이름, 급여, 부서번호 조회
-- EMP 테이블에서 부서번호가 20인 사원의 사원번호, 이름, 급여, 부서번호 조회
-- 두 결과를 합쳐서 조회
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 10
union
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 20;

-- 모든 부서 중에서 부서번호rk 20인 부서만 제외하고 조회(집합연산자(MINUS) 사용)
select * from EMP
minus
select * from EMP where DEPTNO = 20;
-- 집합 연산자 INTERSECT = 교집합!!!
select * from EMP
intersect
select * from EMP where DEPTNO = 20;

-- 12. 부서번호가 10이거나 20인 부서의 사원 모든 정보 조회
select EMPNO, ENAME, SAL, DEPTNO from EMP
where DEPTNO = 10 or DEPTNO = 20;
select EMPNO, ENAME, SAL, DEPTNO from EMP
where DEPTNO in (10, 20); -- in을 이용하면 = 뒤에 복수의 숫자를 넣을 수 있음

-- 13. 사원이름이 s로 끝나는 사원의 모든 정보 조회
select *  from EMP where ENAME like '%S';
    -- %는 앞에 어떤 문자열이든 올 수 있다는 뜻
    -- =는 정확한 값만 인식하므로 %같은 기호를 쓰려면 like를 써야함
    
-- 14. 30번 부서에서 근무하는 사원 중 JOB이 SALESMAN인 사원의
-- 사원번호, 이름, 직책, 급여, 부서번호 조회
select EMPNO, ENAME, JOB, SAL, DEPTNO from EMP
where DEPTNO = 30 and JOB = 'SALESMAN';

-- 15. 30번 부서에서 근무하는 사원 중
-- JOB이 SALESMAN인 사원의
-- 사원번호, 이름, 직책, 급여, 부서번호를
-- 급여가 높은 순으로 조회
select EMPNO, ENAME, JOB, SAL, DEPTNO
from EMP
where DEPTNO = 30 and JOB = 'SALESMAN'
order by SAL desc;

-- 16. 30번 부서에서 근무하는 사원 중
-- JOB이 SALESMAN인 사원의
-- 사원번호, 이름, 직책, 급여, 부서번호를
-- 급여가 높은 순으로 조회, 급여가 같다면 사원번호가 작은 순 먼저 출력
select EMPNO, ENAME, JOB, SAL, DEPTNO
from EMP
where DEPTNO = 30 and JOB = 'SALESMAN'
order by SAL desc, EMPNO asc;

-- [20번, 30번 부서에 근무하는 사원 중에서
--  급여가 2000을 초과하는 사원의
--  사원번호, 이름, 급여, 부서번호를 조회하라.]

-- 17. 집합 연산자를 사용하여 조회
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 20
UNION
select EMPNO, ENAME, SAL, DEPTNO from EMP where DEPTNO = 30
INTERSECT
select EMPNO, ENAME, SAL, DEPTNO from EMP where SAL > 2000;

--18. 집합 연산자를 사용하지 않고 조회
select EMPNO, ENAME, SAL, DEPTNO from EMP
where (DEPTNO = 20 or DEPTNO = 30) and SAL > 2000;
select EMPNO, ENAME, SAL, DEPTNO from EMP
where DEPTNO in (20, 30) and SAL > 2000;

-- 19. 급여가 2000 이상 3000 이하 범위인 사원 정보 조회
SELECT * FROM EMP where SAL >= 2000 AND SAL <= 3000;
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- 20. 급여가 2000 이상 3000 이하 범위 이외의 사원 정보 조회
SELECT * FROM EMP WHERE SAL NOT BETWEEN 2000 AND 3000;
SELECT * FROM EMP
MINUS
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000;

-- 21. 사원이름, 사원번호, 급여, 부서번호 조회
SELECT ENAME, EMPNO, SAL, DEPTNO FROM EMP;
SELECT ENAME AS 사원이름,
EMPNO 사원번호, -- AS랑 따옴표 생략가능함, 대신 공백을 넣으려면 큰따옴표를 써야함, 아님 _ 쓰던가
SAL 급여,
DEPTNO 부서번호
FROM EMP;

-- 22. 사원이름에 E가 포함되어 있는 30번 부서 사원 중에서
-- 급여가 1000 ~ 2000 사이가 아닌 사원을 조회.
-- 단 컬럼명은 사원이름, 사원 번호, 급여, 부서 번호 이용.
SELECT ENAME AS "사원이름", EMPNO AS "사원 번호", SAL AS "급여", DEPTNO AS "부서 번호"
FROM EMP
WHERE ENAME LIKE '%E%'
AND DEPTNO = 30
AND SAL NOT BETWEEN 1000 AND 2000;

-- 23. 주가수당(COMM)이 존재하지 않는 사원 정보 조회
SELECT * FROM EMP WHERE COMM IS NULL; -- NULL같은거랑 일치하는거 볼때는 IS 써야함

-- 24. 주가수당이 존재하는 사원의 정보 조회 (단 COMM이 0인 사원은 제외)
SELECT * FROM EMP
WHERE COMM IS NOT NULL
AND NOT COMM = 0;

-- 25. 주가수당(comm)이 존재하지 않고, 상급자(mgr)는 있고, 
-- 직급이 MANAGER, CLERK 인 사원  중에서 
-- 사원이름의 두번째 글자가 L이 아닌 사원 정보 출력

-- 변수명에 _를 쓰면 임의의 한글자를 뜻함.
SELECT * FROM EMP
WHERE COMM IS NULL
    AND MGR IS NOT NULL
    AND JOB IN (MANAGER, CLERK)
    AND ENAME NOT LIKE '_L%';
    
--------------------------p128 오라클함수(내장함수) ------------------------------
-- <문자열 관련 내장함수>
-- upper(변수명) : 대문자로 바꿔주는 내장함수
-- lower(변수명) : 소문자로 바꿔주는 내장함수
-- initcap(변수명) : 첫글자만 대문자로 바꿔주는 내장함수

select * from emp;
select ename, upper(ename) as 대문자, lower(ename) AS 소문자, initcap(ename)
from emp ;

--<그 외>
-- length(변수명) : 이름의 글자수를 알려줌
select ename, length(ename) AS 이름글자수 from emp;
-- 사원이름(ename)이 5글자 이상인 사원의 이름(ename), 글자수 출력
select ename, length(ename) AS 이름글자수 from emp where length(ename)>=5;

-- 이름 추출
-- substr(변수명,시작위치,개수) : 변수의 일부분만 추출해서 출력, 개수를 안쓰면 끝까지 출력
select ename ,substr(ename, 1, 2), substr(ename, 3, 2), substr(ename, 3), 
        substr(ename, 3, length(ename)),
        length(substr(ename, 3)), length(substr(ename,3,length(ename)))
        -- 두가지 방법의 글자수가 같음.-> 뒤에 공백없음
        from emp;
--------------------------------------------------------------------------------
-- dual : 비어있는 테이블을 만들어주는것 같음.
select 'CORPORATE'
from dual;

-- 위치값 리턴
-- instr(문자 or 변수명, 찾을 문자, 어디서부터 , 몇번째로 일치하는지 ) : 그 글자의 위치를 정수로 리턴
select instr('CORPORATE FLOOR', 'OR', 1, 1)
from dual;
select instr('CORPORATE FLOOR', 'OR')       -- 뒤를 생략하면 위의뜻과 똑같아짐(1,1)로 판단함.
from dual;
select instr('CORPORATE FLOOR', 'OR', 1, 2)  -- 두번째로 OR 이 나오는 지점의 시작점 즉 O의 위치를 반환
from dual;
select instr('CORPORATE FLOOR', 'OR', -1, 2)  -- -1을 저기에 쓰면 뒤에서 부터 2번째에 나오는 OR 값의 위치를 반환
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 1)  -- -3이므로 뒤에서 3번째글자부터 시작해서 OR이 1번째 나오는 O의 위치를 반환
from dual;
select instr('CORPORATE FLOOR', 'OR', -3, 2)  -- -3이므로 뒤에서 3번째글자부터 시작해서 OR이 2번째 나오는 O의 위치를 반환
from dual;
-- 문자열 ABCDDEF 에서 D의 위치값 출력
-- 처음부터 => 4
select instr('ABCDDEF', 'D') from dual;
select instr('ABCDDEF', 'D', 1, 1) from dual;
-- 끝에서  => 5
select instr('ABCDDEF', 'D', -1, 1) from dual;
-- emp 테이블에서 ename 중 s가 있는 위치 출력
select ename, instr(ename, 'S'), instr(ename, 'S',-1,1)
from emp;
-- emp테이블에서 사원이름에 s가 들어있는 이름만 출력(instr 함수 사용)
select * from emp where ename like '%S%';  -- like '%S%'를 이용하여
select ename from emp where instr(ename, 'S') > 0;
-- emp 테이블에서 ename 출력(이름의 2글자만 추출하여 소문자로 변환하여 출력) 
select ename, lower( substr(ename,1,2) ) 소문자1, substr(lower( ename ),1,2) 소문자2 from emp;

-- Replace(바꿀 변수명 or 데이터값, 바꿀문자, 바뀔문자) : 
select '010-1234-5678' as rep_before,
    replace('010-1234-5678', '-', ' ') as rep_after
from dual;
--emp 테이블에서 s를 소문자 s로 변경하여 출력(replace 함수 사용)
select ename, replace(ename, 'S', 's') 
from emp;
select length('한글'), lengthB('한글')
from dual;

select 'Oracle', length('Oracle'), lengthB('Oracle')
from dual;

select 'Oracle', LPAD('Oracle', 10, '#') LPAD1,
RPAD('Oracle', 10, '#') RPAD1,
LPAD('Oracle', 10) LPAD2, -- 기본값은 공백임
RPAD('Oracle', 10) RPAD2
FROM DUAL;

-- EMP 테이블에서 사원번호(앞 2자리 숫자, 나머지는 *) 사원번호
-- 사원이름(첫 2글자만 나오고 나머지는 *) 사원이름
SELECT RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS "사원번호",
    RPAD(SUBSTR(ENAME, 1, 2), LENGTH(ENAME), '*') AS "사원이름"
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

-- 3. 키(HEIGHT)가 170 이상인 학생의 STUDNO, NAME, GRADE, HEIGHT, WEIGHT 조회
--  키가 큰 학생 순으로 조회, 키가 같다면 STUDNO가 작은 순으로 조회
SELECT STUDNO, NAME, GRADE, HEIGHT, WEIGHT 
FROM STUDENT
WHERE HEIGHT >= 170
ORDER BY HEIGHT DESC, STUDNO ASC;

-- 4. PROFESSOR 테이블에서 보너스를 받지 못하는 사람의
--  PROFNO, NAME, PAY, BONUS 조회
SELECT PROFNO, NAME, PAY, BONUS
FROM PROFESSOR
WHERE BONUS IS NULL;

-- 5. PROFESSOR 테이블에서 EMAIL 중에서 아이디만 조회하시오
SELECT SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS EMAIL_ID
FROM PROFESSOR;

----------------------------------------------------------------------------

SELECT * FROM emp;

-- 1. 문자열 연결(concat) 단, concat은 인수를 2개까지밖에 못 받음
SELECT concat(ename, job) AS concat FROM emp;

-- 2. ename:job을 컬럼 하나로 출력 ex) SMITH:CLERK <- 형식으로 출력
SELECT concat(concat(ename, ':'), job) AS dbl_concat FROM emp;
SELECT concat(ename, concat(':', job)) AS dbl_concat FROM emp;

-- p.142 문자열 연결 (||)
SELECT ename || ':' || job AS "이름:직업"
FROM emp;

-- 공백 제거(TRIM 함수)
SELECT '     oracle     ', LENGTH('     oracle     '),
    TRIM('     oracle     '), LENGTH(TRIM('     oracle     ')) AS TRIM길이,
    LTRIM('     oracle     '), LENGTH(LTRIM('     oracle     ')) AS LTRIM길이,
    RTRIM('     oracle     '), LENGTH(RTRIM('     oracle     ')) AS RTRIM길이
FROM dual;

-- 숫자 관련 함수
-- 반올림: ROUND()
SELECT 123.567, ROUND(123.567), ROUND(123.567, 1), ROUND(123.567, 2),
    ROUND(123.567, -1)
FROM dual;
-- 버림: TRUNC()
SELECT 15.793, TRUNC(15.793), TRUNC(15.793, 1), TRUNC(15.793, 2),
    TRUNC(15.793, -1)
FROM dual;
-- 올림(가장 가까운 큰 정수): CEIL()
SELECT 3.14, CEIL(3.14)
FROM dual;
-- 가장 가까운 작은 정수: FLOOR()
SELECT 3.14, FLOOR(3.14)
FROM dual;
-- TRUNC, CEIL, FLOOR 비교
SELECT TRUNC(3.14), CEIL(3.14), FLOOR(3.14), TRUNC(-3.14), CEIL(-3.14), FLOOR(-3.14)
FROM dual;
-- 제곱: POWER()
SELECT POWER(2, 3) FROM dual;
-- 나머지: MOD()
SELECT MOD(15, 6) FROM dual;

-- 날짜 관련 함수
SELECT sysdate AS 오늘, sysdate + 1 AS 내일, sysdate - 1 AS 어제,
    sysdate + 3
FROM dual;
-- 3개월 뒤
SELECT sysdate, ADD_MONTHS(sysdate, 3), ADD_MONTHS('22/05/01', 3)
FROM dual;
-- emp 테이블에서 사원번호(empno), 이름(ename), 입사일(hiredate) 출력
-- 입사 10년 후 날짜를 '입사10년후' 제목으로 출력
SELECT empno, ename, hiredate, ADD_MONTHS(hiredate, 120) AS 입사10년후
FROM emp;
SELECT MONTHS_BETWEEN(sysdate, '24/01/24') FROM dual;
-- emp 테이블에서 이름, 근무개월 수(소숫점 둘째자리에서 버림) 출력
SELECT ename, hiredate, TRUNC(MONTHS_BETWEEN(sysdate, hiredate), 1) AS 근무개월수
FROM emp;
-- 근무개월수 출력, 단 '개월'이라는 글자를 붙이고 출력, 소숫점 이하는 버림
-- 단, CONCAT함수 사용
SELECT CONCAT(TRUNC(MONTHS_BETWEEN(sysdate, hiredate)), '개월') AS 근무개월수
FROM emp;

-- NEXT_DAY, LAST_DAY 함수
SELECT sysdate, NEXT_DAY(sysdate, '월요일') AS 월요일,
    NEXT_DAY(sysdate, '토요일') AS 토요일,
    LAST_DAY(sysdate) AS 마지막날,
    LAST_DAY('96/01/04')
FROM dual;

-- 사원번호(empno)가 짝수인 사원의 사원번호(empno), 이름(ename), 직급(job) 출력
SELECT empno, ename, job
FROM emp
WHERE MOD(empno, 2) = 0;

-- 급여(sal)가 1500에서 3000 사이의 사원은 그 급여의 15%를 회비로 낸다
-- 이름, 급여, 회비(반올림) 출력
SELECT ename, sal, ROUND(sal * 0.15) AS 회비
FROM emp
WHERE sal BETWEEN 1500 AND 3000;

-- p.157 형 변환 함수
describe emp;
SELECT empno, ename, empno + '500' -- '500'이 숫자로 형변환되었음
FROM emp;

-- 문자열로 변환해주는 함수 TO_CHAR(값, 형식)
SELECT TO_CHAR(sysdate, 'mm')월 FROM dual;
SELECT TO_CHAR(sysdate, 'dd')일 FROM dual;
SELECT TO_CHAR(sysdate, 'hh')시 FROM dual;
SELECT TO_CHAR(sysdate, 'mi')분 FROM dual;
SELECT TO_CHAR(sysdate, 'ss')초 FROM dual;
SELECT TO_CHAR(sysdate, 'mon')월 FROM dual;
SELECT TO_CHAR(sysdate, 'month')월 FROM dual;
SELECT TO_CHAR(sysdate, 'day')요일 FROM dual;

-- 입사일이 1, 2, 3월인 사원의 번호, 이름, 입사일 출력
SELECT empno, ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'mm') IN (1, 2, 3);

SELECT TO_CHAR(sal, '$999,999') sal_$,
    TO_CHAR(sal, 'L999,999') sal_$,
    TO_CHAR(sal, '999,999') sal_9,
    TO_CHAR(sal, '000,999') sal_0
FROM emp;

-- TO_NUMBER(값, 인식할 형식)
SELECT 1300 - 1500 FROM dual;
SELECT TO_NUMBER('1300') - TO_NUMBER('1500') FROM dual;
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500','999,999')
FROM dual;
-- SELECT TO_NUMBER('1,300') - TO_NUMBER('1,500') FROM dual; <- 이건 오류

-- p.164 '20240727' 얘를 날짜형으로 바꾸기 TO_DATE(값, 형식)
SELECT TO_DATE('20240727') as str_date FROM dual;

-- 81/12/03 이후 입사한 사원 출력
SELECT * FROM emp WHERE hiredate >= TO_DATE('81/12/03');

----------------------------------------------------------------------------
-- NVL(값, null일때 넣을 값) <- null을 치환해줌
-- 사번, 이름, 급여, 커미션, 급여+커미션 출력 (null+숫자 = null임)
SELECT empno, ename, comm, sal + comm AS 수입
FROM emp;
SELECT empno, ename, comm, sal + nvl(comm, 0) AS 수입
FROM emp;

-- 사번, 이름, 급여, 커미션, 급여+커미션(col=수입) 출력
-- 단, 수입을 천단위로 구분하여 출력
SELECT empno, ename, comm, TO_CHAR((sal + nvl(comm, 0)) * 12, '999,999') AS 연봉
FROM emp;

-- NVL2(값, null이 아닐때 치환할 값, null일 때 치환할 값)
-- comm을 받으면 O, 받지 않으면 X라고 출력
SELECT empno, ename, comm, NVL2(comm, 'O', 'X')
FROM emp;

-- 연봉 출력 (단, NVL2 사용)
SELECT empno, ename, sal, sal * 12 + NVL2(comm, comm, 0) AS 연봉,
    TO_CHAR(sal * 12 + NVL2(comm, comm, 0), '999,999') AS 연봉2
FROM emp;

-- empno, ename, mgr 출력 / 단, mgr이 null이면, 'CEO' 출력
SELECT empno, ename, NVL2(mgr, TO_CHAR(mgr), 'CEO') AS mgr
FROM emp;

------------------------------------

-- p.170
-- DECODE() -> if문 함수
-- job에 따라 급여 다르게 인상
-- MANAGER 1.5 / SALESMAN 1.2 / ANALYST 1.05 / 1.04
SELECT empno, ename, job, sal,
    DECODE(job, 'MANAGER', sal * 1.5, 'SALESMAN', sal * 1.2,
        'ANALYST', sal * 1.05, sal * 1.04) AS 인상SAL
FROM emp;
-- CASE WHEN THEN END
SELECT empno, ename, job, sal,
    CASE job
        WHEN 'MANAGER' THEN sal * 1.5
        WHEN 'SALESMAN' THEN sal * 1.2
        WHEN 'ANALYST' THEN sal * 1.05
        ELSE sal * 1.04
    END AS 인상급여
FROM emp;
SELECT empno, ename, job, sal,
    CASE
        WHEN job = 'MANAGER' THEN sal * 1.5
        WHEN job = 'SALESMAN' THEN sal * 1.2
        WHEN job = 'ANALYST' THEN sal * 1.05
        ELSE sal * 1.04
    END AS 인상급여
FROM emp;

-- comm이 null이면 '해당사항 없음', comm = 0이면 '수당 없음',
-- comm이 있으면 '수당: ~~' 출력
-- 1) DECODE() 사용
SELECT empno, ename, comm,
    DECODE(comm, null, '해당사항 없음', 0, '수당 없음', CONCAT('수당: ', comm)) AS comm_txt
FROM emp;

-- 2) CASE 사용
SELECT empno, ename, comm,
    CASE
        WHEN comm IS null THEN '해당사항 없음'
        WHEN comm = 0 THEN '수당 없음'
        ELSE CONCAT('수당: ', comm)
        END AS comm_txt
FROM emp;

------------------------------------------------------------------------------------------

-- professor 테이블
-- 1. professor 테이블 name과 deptno, 학과명 출력
-- 단, deptno = 101이면 '컴퓨터공학과'
-- 1) case문
SELECT name, deptno,
    CASE
        WHEN deptno = 101 THEN '컴퓨터공학과'
        END AS 학과명
FROM professor;

-- 2) DECODE
SELECT name, deptno, DECODE(deptno, 101, '컴퓨터공학과')
FROM professor;

-- 2. professor 테이블 name과 deptno, 학과명 출력
-- 단, deptno = 101이면 '컴퓨터공학과', 나머지 학과는 기타로 출력
-- 1) case문
SELECT name, deptno,
    CASE
        WHEN deptno = 101 THEN '컴퓨터공학과'
        ELSE '기타'
        END AS 학과명
FROM professor;

-- 2) DECODE
SELECT name, deptno, DECODE(deptno, 101, '컴퓨터공학과', '기타')
FROM professor;

-- 3. professor 테이블 name과 deptno, 학과명 출력
-- 단, deptno = 101이면 '컴퓨터공학과'
-- 102면 멀티미디어 공학과
-- 201이면 소프트웨어공학과
-- 나머지는 기타 출력
-- 1) case문
SELECT name, deptno,
    CASE deptno
        WHEN 101 THEN '컴퓨터공학과'
        WHEN 102 THEN '멀티미디어공학과'
        WHEN 201 THEN '소프트웨어공학과'
        ELSE '기타'
        END AS 학과명
FROM professor;

-- 2) DECODE
SELECT name, deptno,
    DECODE(deptno, 101, '컴퓨터공학과', 102, '멀티미디어공학과', 201, '소프트웨어공학과', '기타') AS 학과명
FROM professor;

-- student 테이블에서 학생을 3개의 팀으로 분류함
-- studno를 3으로 나누어
-- 나머지가 0이면 A팀, 1이면 B팀, 2이면 C팀
-- studno, name, deptno1, 팀이름
-- CASE
SELECT studno, name, deptno1,
    CASE MOD(studno, 3)
        WHEN 0 THEN 'A'
        WHEN 1 THEN 'B'
        WHEN 2 THEN 'C'
        END AS 팀이름
FROM student;

-- DECODE()
SELECT studno, name, deptno1,
    DECODE(MOD(studno, 3), 0, 'A', 1, 'B', 2, 'C') AS 팀이름
FROM student;

-- 1. 학생 테이블에서 jumin 7번째 숫자가 1이면 남자, 2면 여자
-- studno, name, jumin, 새 컬럼(성별)
SELECT studno, name, jumin,
    DECODE(SUBSTR(jumin, 7, 1), 1, '남자', 2, '여자') AS 성별
FROM student;
