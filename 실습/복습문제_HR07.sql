--1. professor 테이블, department 테이블
--교수번호(profno)와 교수이름(name), 소속학과이름(dname)을 조회하는
--view 생성(v_prof_dept2)
CREATE OR REPLACE VIEW v_prof_dept2
AS
SELECT profno, name, dname
FROM professor
    NATURAL JOIN department;

--2.1번 뷰를 읽기 전용으로  v_prof_dept3
CREATE OR REPLACE VIEW v_prof_dept3
AS
SELECT profno, name, dname
FROM professor
    NATURAL JOIN department
WITH READ ONLY;

--3. student, department 테이블을 사용하여
--학과별(deptno1)로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력
SELECT deptno1, MAX(height), MAX(weight), dname
FROM student s
    JOIN department d
        ON s.deptno1 = d.deptno
GROUP BY deptno1, dname;
        
--4. 학과이름, 학과별 최대키, 학과별로 가장 키가 큰 학생들의 이름과 키를 출력
--인라인뷰
SELECT *
FROM (
        SELECT deptno1, name, MAX(height) max_height
        FROM student
        GROUP BY deptno1, name
    ) vw
    JOIN department d
        ON vw.deptno1 = d.deptno
    JOIN student s
        ON vw.name = s.name;

--5. student 테이블에서
--학생의 키가 동일 학년의 평균 키보다 큰 학생의                           
--학년, 이름, 키, 해당 학년의 평균키 출력 (인라인뷰 이용, 학년으로 오름차순)
SELECT vw.grade, s.name, s.height, vw.avg_height
FROM (
        SELECT grade, AVG(height) avg_height
        FROM student
        GROUP BY grade
    ) vw
    JOIN student s
        ON vw.grade = s.grade
WHERE height > avg_height
ORDER BY vw.grade;
