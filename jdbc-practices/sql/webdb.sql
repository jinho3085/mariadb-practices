--
-- JDBC Test SQL
--

desc dept;

-- select 
select id, name from dept where name like '%개발%';

-- insert
insert into dept(name) values('UX팀');

-- delete
delete from dept where id = 7;

-- update
update dept set name = '서비스개발팀' where id = 2;

--
-- email application
-- 

desc email;

-- count
select count(*) from email;

-- findAll
select id, first_name, last_name, email from email order by id desc;

-- deleteByEmail
delete from email where email = 'dooly@gamil.com';

-- insert
insert into email(first_name, last_name, email) values ('둘','리', 'dooly@gmail.com');