--
-- JDBC Test SQL
--

select * from book;
select count(*) from book;

show tables;
desc board;

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

desc board;
select * from board;
select count(*) from board;

SELECT * FROM board
WHERE title LIKE '%검색어%' OR contents LIKE '%검색어%' OR writer LIKE '%검색어%';

-- 1페이지
SELECT * FROM board ORDER BY no DESC LIMIT 5 OFFSET 0;

-- 2페이지
SELECT * FROM board ORDER BY no DESC LIMIT 5 OFFSET 5;



-- count
select count(*) from email;

-- findAll
select id, first_name, last_name, email from email order by id desc;

-- deleteByEmail
delete from email where email = 'dooly@gamil.com';

-- insert
insert into email(first_name, last_name, email) values ('둘','리', 'dooly@gmail.com');

--
-- mysite: user
--

desc user;

-- 회원가입
insert into user(name, email, password, gender, join_date) values('둘리', 'dooly@g.com', password('1234'), 'male', current_date());

-- 회원리스트
select * from user;

-- 삭제
delete from user where id = 2;


select id, name from user where email = 'jinho3085@naver.com' and password = password('1234'); /* 로그인 */


update webdb.user
where id=10; -- 회원정보 수정

ALTER TABLE board ADD COLUMN parent_id BIGINT DEFAULT NULL;

ALTER TABLE board ADD COLUMN file_name VARCHAR(255);

SELECT no, title, contents, writer, hit, reg_date, depth, parent_id, file_name AS fileName
FROM board;

ALTER TABLE board CHANGE COLUMN file_name fileName VARCHAR(255);

SELECT no, title, contents, fileName 
FROM board 
WHERE no = 1;

