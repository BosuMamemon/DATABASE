-- 1. professor 테이블에서,
-- 학과별로 소속 교수들의 평균급여, 최소급여, 최대급여 출력
-- 단, 평균 급여가 300이 넘는 것만 출력

SELECT
    deptno 학과, avg(pay) 평균급여, min(pay) 최소급여, max(pay) 최대급여
FROM professor
GROUP BY deptno
HAVING avg(pay) > 300;

-- 2. student 테이블에서,
-- 학년, 학생수, 평균 키, 평균 몸무게를 계산하되,
-- 학생 수가 4명 이상인 학년에 대해서 출력
-- 단, 평균 키와 평균 몸무게는 소숫점 첫번째 자리에서 반올림
-- 출력 순서는 평균 키가 높은 순부터 내림차순으로 출력
SELECT
    grade 학년, count(*) 학생수, round(avg(height)) "평균 키", round(avg(weight)) "평균 몸무게"
FROM student
GROUP BY grade
HAVING count(*) >= 4
ORDER BY avg(height) DESC;

-- 3. professor, student 테이블에서,
-- 학생이름과 지도교수 이름을 출력
SELECT
    student.name 학생, professor.name 지도교수
FROM student
    JOIN professor
    ON student.profno = professor.profno;
    
-- 4. gift, customer 테이블에서,
-- 고객이름(gname), 포인트(point), 선물(gname)을 출력
SELECT
    customer.gname 고객이름, TO_CHAR(point, '999,999') 포인트, gift.gname 선물
FROM customer JOIN gift
    ON customer.point >= gift.g_start
        AND customer.point <= gift.g_end;
-- 오라클 문법
SELECT
    customer.gname 고객이름, TO_CHAR(point, '999,999') 포인트, gift.gname 선물
FROM
    customer, gift
WHERE
    customer.point BETWEEN gift.g_start AND gift.g_end;
    
-- 5. student, score, hakjum 테이블에서
-- 학생이름(name), 점수(total), 학점(grade) 출력
SELECT
    name 학생이름, total 점수, hakjum.grade 학점
FROM student
    JOIN score
        ON student.studno = score.studno
    JOIN hakjum
        ON score.total BETWEEN hakjum.min_point AND hakjum.max_point;
    
-- 오라클 문법
SELECT
    name 학생이름, total 점수, hakjum.grade 학점
FROM
    student, score, hakjum
WHERE
    student.studno = score.studno
    AND
    score.total BETWEEN hakjum.min_point AND hakjum.max_point;
    
-- professor, student 테이블
-- 1. 학생 이름과 지도교수 이름을 출력
-- 단, 지도교수가 정해지지 않은 학생의 이름도 출력
SELECT
    student.name "학생 이름", professor.name "지도교수 이름"
FROM student
    LEFT OUTER JOIN professor
        ON student.profno = professor.profno;

-- 2. deptno1가 101인 학생을 출력
-- 단, 지도교수가 없는 학생도 출력
-- 학과번호, 학생이름, 지도교수 이름 출력
SELECT
    studno 학과번호, student.name "학생 이름", professor.name "지도교수 이름"
FROM student
    LEFT OUTER JOIN professor
        ON student.profno = professor.profno
WHERE deptno1 = 101;


-- 3. dept2 테이블에서 area가 Seoul Branch Office인 사원의
-- 사원번호, 이름, 부서번호 출력
-- 1) 서브쿼리 사용
SELECT name, empno, deptno
FROM emp2
WHERE deptno IN
    (SELECT dcode
    FROM dept2
    WHERE area = 'Seoul Branch Office');

-- 2) JOIN 사용
SELECT name, empno, deptno
FROM emp2
    JOIN dept2
    ON emp2.deptno = dept2.dcode
WHERE dept2.area = 'Seoul Branch Office';

-- 4. student 테이블에서 각 학년별 최대 몸무게를 가진 학생의
-- 학년, 이름, 몸무게 출력
SELECT grade, max(weight), name, weight
FROM student
WHERE weight IN(SELECT max(weight)
                FROM student
                GROUP BY grade)
GROUP BY grade, name, weight;