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





