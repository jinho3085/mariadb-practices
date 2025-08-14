--
-- inner join
--

-- 예제01) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하세요.
select a.first_name, b.title
	from employees a, titles b
    where a.emp_no = b.emp_no 		-- join 조건 (n-1)
	 and b.to_date = '9999-01-01'; 	-- row 선택 조건 
     
-- 예제02) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하되, 여성 엔지니어만 출력하세요.
select a.first_name, a.gender, b.title
	from employees a, titles b
    where a.emp_no = b.emp_no		-- join 조건 (n-1)
    and b.to_date = '9999-01-01'	-- row 선택 조건1
    and a.gender = 'f'				-- row 선택 조건2
    and b.title = 'Engineer';		-- row 선택 조건3
    
--
-- ANSI/ISO SQL1999 Join 문법
--

-- 1) natural join
--    조인 대상이 되는 두 테이블에 같은 이름의 커럼이 있는 경우
-- 	  조인 조건을 명시하지 않고 암시적으로 조인이 된다.

-- 예제01) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하세요.
select a.first_name, b.title
 from employees a natural join titles b -- on a.emp_no = b.emp_no
 where b.to_date = '9999-01-01';
 
-- 2)join ~ using

-- natural join의 문제점
select count(*)
 from salaries a natural join titles b -- on a.emp_no = b.emp_no and a.from_date = b.from_date and a.to_date = b.to_date
 where a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01';

-- 해결방안
select count(*)
 from salaries a join titles b using(emp_no)
 where a.to_date = '9999-01-01'
   and b.to_date = '9999-01-01';

-- 3) join ~ on 
-- 예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력하세요.
select b.title, avg(a.salary)
	from salaries a, titles b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by b.title 
order by avg(a.salary) desc;

select b.title, avg(a.salary)
	from salaries a join titles b on a.emp_no = b.emp_no
    where a.to_date = '9999-01-01'
	  and b.to_date = '9999-01-01'
group by b.title 
order by avg(a.salary) desc;   

-- 실습문제 01
-- 현재, 직책별 평균연봉과 직원수를 구하되 직원수가 100명 이상인 직책만 출력하세요.
-- projection: 직책 평균 급여 직원수
select b.title as '직책', avg(a.salary) as '평균급여', count(*) as '직원수'
	from salaries a, titles b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
group by b.title
	having 직원수 >= 100;

-- 실습문제 02
-- 현재, 부서별로 직책이 Enginner인 직원들에 대해서만 평균 연봉을 구하세요.
-- projection: 부서이름 평균급여

	select a.dept_name, avg(salary)
	from departments a, dept_emp b, titles c, salaries d
	where a.dept_no = b.dept_no
    and b.emp_no = c.emp_no
    and c.emp_no = d.emp_no
    and c.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
    and d.to_date = '9999-01-01'
    and c.title = 'Engineer'
group by a.dept_name
order by avg(salary) desc;

