-- --함수, 상수, 리터럴, 연산식
select version(), current_date "hello", 1 +2 from dual;

-- 수학함수, 문자열 함수, 날짜함수
select sin(pi()/4), upper("seoul"), curdate() from dual;

-- 대소문자 구문이 없다.
select VERSION(), current_DATE From DuaL;

-- table 생성: DDL
create table pet (
	name varchar(100),
    owner varchar(50),
    species varchar(50),
    gender char(1),
    birth date,
    death date
);

-- schema  확인
describe pet;
desc pet;

-- table  삭제
drop table pet;
show tables;

-- insert: DML(C)
insert 
	into pet 
values('성탄이', '김주한', 'dog', 'm', '2007-12-25', null);

-- select: DML(R)
select * from pet;

-- update: DML(U)
update pet set name='성타니' where name = '성탄이';

-- delete: DML(D)
delete from pet where name = '성타니';

-- LOAD DATA: mysql(CLI) 전용
load data local infile '/root/pet.txt' into table pet;
update pet set death = null where name != 'bowser';

-- select 연습
select name, owner
	from pet
where name='bowser';

--    
-- 1998 이 후에 태어난 애들의 이름, 종, 생일을 출력하세요.
--
select name, species, birth
	from pet
where birth >= '1998-01-01';

--
-- 개들중에 암컷만 이름과 종과 성별를 출력하세요.
--

select name, species, birth
 from pet
 where species = 'dog' 
 and gender = 'f';
 
 --
 -- 새와 뱀들만 이름과 종을 출력하세요.
 -- 
 
 select name, species
 from pet
 where species = 'bird' 
  or species = 'snake';

--
-- 애완동물들의 이름과 생일을 나이가 적은 순서대로 출력하세요.
-- 

  select name, birth
	from pet
order by birth desc;

  
--
-- 애완동물들의 이름과 생일을 나이가 많은 순서대로 출력하세요.
-- 

  select name, birth
	from pet
order by birth asc;

--
-- 애완동물들 중에 살아있는 애들만 이름, 생일, 사망일을 출력하세요.
-- 
select name, birth, death
	from pet
    where death is null;
--
-- 애완동물들 중에 이름이 'b'로 시작하는 아이들의 이름만 출력하세요.
--  
select name
	from pet
    where name like 'b%';

--
-- 애완동물들 중에 이름이 'fy'로 끝나는 아이들의 이름만 출력하세요.
-- 
select name
	from pet
    where name like '%fy';
    
--
-- 애완동물들 중에 이름이 'W'가 들어 있는 아이들의 이름만 출력하세요.
--     
select name
	from pet
    where name like '%w%';

--
-- 애완동물들 중에 이름이 5문자인 아이들의 이름만 출력하세요.
--     

select name
	from pet
    where name like '_____';

--
-- 애완동물들 중에 이름이 b로 시작하고 6문자인 아이들의 이름만 출력하세요.
--        

select name
	from pet
    where name like 'b_____';
    
--
-- 집계 
--    
select count(*), max(birth) from pet;









