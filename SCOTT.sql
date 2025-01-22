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