-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 

-- 문제1.
-- 현재 전체 사원의 평균 급여보다 많은 급여를 받는 사원은 몇 명이나 있습니까?
select count(*)
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and b.salary > (select avg(salary)
					from salaries
                    where to_date = '9999-01-01');
-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 급여을 조회하세요. 단 조회결과는 급여의 내림차순으로 정렬합니다.
select a.dept_name, c.first_name, d.salary
	from departments a,
		 dept_emp b,
         employees c,
         salaries d
	where a.dept_no = b.dept_no
     and b.emp_no = c.emp_no
     and c.emp_no = d.emp_no
     and b.to_date = '9999-01-01'
     and d.to_date = '9999-01-01'
     and (a.dept_no, d.salary ) in (select a.dept_no, max(b.salary) as max_salary
									from dept_emp a, salaries b
									where a.emp_no = b.emp_no
									and a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
									group by a.dept_no);

-- 문제3.
-- 현재, 사원 자신들의 부서의 평균급여보다 급여가 많은 사원들의 사번, 이름 그리고 급여를 조회하세요 
select a.dept_name, c.first_name, d.salary
	from departments a,
		 dept_emp b,
         employees c,
         salaries d
	where a.dept_no = b.dept_no
     and b.emp_no = c.emp_no
     and c.emp_no = d.emp_no
     and b.to_date = '9999-01-01'
     and d.to_date = '9999-01-01'
     and d.salary > (select avg(salary)
					from dept_emp b2, salaries d2
                    where b2.emp_no = d2.emp_no
					 and b2.to_date = '9999-01-01'
                     and d2.to_date = '9999-01-01'
                     and b2.dept_no = b.dept_no
                    );
     
-- 문제4.
-- 현재, 사원들의 사번, 이름, 그리고 매니저 이름과 부서 이름을 출력해 보세요.

-- 문제5.
-- 현재, 평균급여가 가장 높은 부서의 사원들의 사번, 이름, 직책 그리고 급여를 조회하고 급여 순으로 출력하세요.

-- 문제6.
-- 현재, 평균 급여가 가장 높은 부서의 이름 그리고 평균급여를 출력하세요.

-- 문제7.
-- 현재, 평균 급여가 가장 높은 직책의 타이틀 그리고 평균급여를 출력하세요.