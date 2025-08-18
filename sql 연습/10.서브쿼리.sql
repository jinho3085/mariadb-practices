--
-- subquery
-- 

--
-- 1) select (subquery) from t
-- 	 insert into t values (val1, val2, (subquery), val3);


-- select (select now() from dual) from dual;

--
-- 2) from 절의 서브쿼리
--
select now() as n, sysdate(), 3 + 1 as r from dual;

select a.n, a.s, a.r
	from(select now() as n, sysdate() as s, (3 + 1) as r from dual) a;

--
-- 3) where 절의 서브쿼리
--

-- 예제) 현재, 'Fai Bale'이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요.

-- SOL1: 두개의 쿼리로 해결
-- 1st query: 'Fai Bale'이 근무하는 부서번호 가져오기
-- 2nd query: 1st query에서 구한 부서번호를 가지고 동료 구하기

select *
	from employees a, dept_emp b 
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and concat(a.first_name, ' ', a.last_name) = 'Fai Bale';

-- 'd004'

select a.emp_no, a.first_name
  from employees a, dept_emp b
  where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.dept_no = 'd004';

-- SOL2: 서브쿼리로 해결

select a.emp_no, a.first_name
  from employees a, dept_emp b
  where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
  and b.dept_no = (select dept_no
					from employees a, dept_emp b 
					where a.emp_no = b.emp_no
					and b.to_date = '9999-01-01'
					and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');

-- 3-1) 단일행 연산자: =, >, <, >=, <=, !=, <> 
-- 예제2) 현재, 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름(first_name), 급여(salary)를 출력하세요.
-- 72012.2359
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
    and b.salary < (select avg(salary)
					from salaries
					where to_date = '9999-01-01')
order by b.salary desc;

-- 예제3) 현재, 직책별 평균급여 중에 가장 적은 평균급여의 직책의 직책이름과 그 평균 급여를 출력하세요.

-- 1) 직책별 평균급여
select a.title, avg(b.salary)
	from titles a, salaries b
    where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
    group by a.title;

-- 2) 직책별 가장  적은 평균급여
select min(avg_salary)
	from (select a.title, avg(b.salary) as avg_salary
			from titles a, salaries b
			where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
    group by a.title) a;
    
-- SOL1: where절(having절) 서브쿼리 사용
select a.title, avg(b.salary)
	from titles a, salaries b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by a.title
	having avg(b.salary) = (select min(avg_salary)
							from (select a.title, avg(b.salary) as avg_salary
							from titles a, salaries b
							where a.emp_no = b.emp_no
							and a.to_date = '9999-01-01'
							and b.to_date = '9999-01-01'
							group by a.title) a);

-- SOL2: top-k  (limit, 보통 order by뒤에 온다)
select a.title, avg(b.salary)
	from titles a, salaries b
	where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'	
group by a.title
order by avg(b.salary) asc
    limit 0, 1;
    
-- 3-2) 복수행 연산자: in, not in, (비교연산자)any, (비교연산자)all

-- (비교연산자)any 사용법
-- 1. =any: in
-- 2. <>any, !=any: not in
-- 3. >any, >=any: 최소값
-- 4. <any, <=any: 최대값 

-- (비교연산자)all 사용법
-- 1. =all: (x)
-- 2. <>all, !=all
-- 3. >all, >=all; 최대값
-- 4. <all, <=all; 최소값

-- 예제4) 현재, 급여가 50,000 이상인 직원의 이름(first_name)과 급여(salary)를 출력
-- 둘리 60000
-- 마이콜 80000

-- SOL1: join
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date ='9999-01-01'
    and b.salary > 50000
order by b.salary asc;

-- SOL2: subquery: where(in)
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date ='9999-01-01'
    and (a.emp_no, b.salary) in (select emp_no, salary
								from salaries
								where to_date = '9999-01-01'
								and salary > 50000)
order by b.salary asc;

-- SOL3: subquery: where(=any)
select a.first_name, b.salary
	from employees a, salaries b
    where a.emp_no = b.emp_no
    and b.to_date ='9999-01-01'
    and (a.emp_no, b.salary) = any (select emp_no, salary
								from salaries
								where to_date = '9999-01-01'
								and salary > 50000)
order by b.salary asc;

-- 예제5) 현재, 각 부서별로 최고 급여를 받고 있는 직원의 부서이름(dept_name), 이름(first_name), 연봉(salary)
-- 총무 둘리 40000
-- 개발 마이콜 50000

select a.dept_no, max(b.salary) as max_salary
 from dept_emp a, salaries b
 where a.emp_no = b.emp_no
 and a.to_date = '9999-01-01'
 and b.to_date = '9999-01-01'
group by a.dept_no;

-- SOL1: where절 subquery (in)
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
  and (a.dept_no, d.salary) in (select a.dept_no, max(b.salary)
								from dept_emp a, salaries b
								where a.emp_no = b.emp_no
								and a.to_date = '9999-01-01'
								and b.to_date = '9999-01-01'
							group by a.dept_no);

-- SOL2: from절 subquery 
select a.dept_name, c.first_name, d.salary
 from departments a,
	  dept_emp b,
      employees c,
      salaries d,
      (select a.dept_no, max(b.salary) as max_salary
		from dept_emp a, salaries b
		where a.emp_no = b.emp_no
		and a.to_date = '9999-01-01'
		and b.to_date = '9999-01-01'
		group by a.dept_no) e
 where a.dept_no = b.dept_no
  and b.emp_no = c.emp_no
  and c.emp_no = d.emp_no
  and a.dept_no = e.dept_no
  and b.to_date = '9999-01-01'
  and d.to_date = '9999-01-01'
  and d.salary = e.max_salary