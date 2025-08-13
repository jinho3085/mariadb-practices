--
-- select 연습
--

-- 예제01 : deaprtments 테이블의 모든 데이터를 출력.
select * from departments;

-- 프로젝션(Projection)
-- 예제02 : employees 테이블에서 직원의 이름,  성별, 입사일을 출력
select first_name, gender, hire_date
	from employees;
    
-- as(alias, 별칭, 생략가능)
-- 예제03 : employees 테이블에서 직원의 이름,  성별, 입사일을 출력
select first_name as '이름',
	gender as '성별',
    hire_date as '입사일'
	from employees;

-- as(alias, 별칭, 생략가능)
-- 예제04 : employees 테이블에서 직원의 전체이름,  성별, 입사일을 출력
select concat(first_name, ' ', last_name) as '전체이름',
	gender as '성별',
    hire_date as '입사일'
from employees;

-- distinct
-- 예제05 : titles 테이블에서 모든 직급의 이름 출력
select title 
 from titles;

-- 예제06 : titles 테이블에서 직급은 어떤 것들이 있는지 직급이름을 한 번씩만 출력
select distinct(title) 
 from titles;

--
-- where --
--
-- 예제07 : employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select first_name as '이름',
	   gender as '성별',
       hire_date as '입사일'
	from employees
    where hire_date < '1991-01-01';

-- 논리연산
-- 예제08 : employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
select first_name as '이름',
	   gender as '성별',
       hire_date as '입사일'
	from employees
    where hire_date < '1989-01-01'
    and gender = 'F';

-- in 연산자
-- 예제09 : dept_emp 테이블에서 부서 번호가 d005 이거나 d009에 속한 사원의 사번, 부서번호 출력
select emp_no, dept_no 
	from dept_emp
    where dept_no = 'd005'
	or	dept_no = 'd009';
    
select emp_no, dept_no 
	from dept_emp
    where dept_no in ('d005', 'doo9');
    
-- LIKE 검색
-- 예제10 : employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력
select first_name as '이름',
       hire_date as '입사일'
	from employees
    where '1989-01-01' <= hire_date 
	and hire_date <= '1989-12-31';

select first_name as '이름',
       hire_date as '입사일'
	from employees
    where hire_date between '1989-01-01' and '1989-12-31';

select first_name as '이름',
       hire_date as '입사일'
	from employees
    where hire_date like '1989-&';

--
-- order by 
--

-- 예제11 : employees 테이블에서 직원의 전체이름,  성별, 입사일을  입사일을 빠른 순으로 출력
select first_name as '이름',
	gender as '성별',
    hire_date as '입사일'
    from employees
    order by hire_date asc;

-- 예제12 : salaries에서 테이블에서 2001년 윌급이 가장 높은 순으로 사번, 월급을 출력
SELECT emp_no, salary, from_date, to_date
FROM salaries
WHERE from_date LIKE '2001-%'
  AND to_date LIKE '2001-%'
ORDER BY salary DESC;

-- 예제13: 남자 직원의 이름, 성별, 입사일을 선임순(입사일이 작은순)으로 출력 하세요.
select first_name, gender, hire_date
	from employees
    where gender = 'm'
    order by hire_date asc;




