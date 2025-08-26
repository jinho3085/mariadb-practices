--
-- JDBC Test SQL 
--

show databases;
use bookmall;
show tables;

-- count
select count(*) from Book;

-- findAll
SELECT no, title, price, category_id FROM Book ORDER BY no DESC;

-- deleteByBook
delete from Book where title = '?';

-- insert
 INSERT INTO Book(title, price, category_id) VALUES ('?', '?', '?');
 
 