--
-- JDBC Test SQL 
--

show databases;
use bookmall;
show tables;

SELECT * FROM user;

desc user;

-- count
select count(*) from Book;

-- find
SELECT * 
FROM user 
WHERE email IN ('test01@test.com', 'test02@test.com');

SELECT no, name, email, password, phone
FROM user
WHERE email IN ('test01@test.com', 'test02@test.com');

-- deleteByBook
delete from Book where title = '?';

-- insert
 INSERT INTO Book(title, price, category_id) VALUES ('?', '?', '?');
 
 