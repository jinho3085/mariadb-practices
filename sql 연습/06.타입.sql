-- cast
select 
	'12345' + 10, 
	cast('12345' as signed int) + 10 
    from dual;
select date_format('2025-08-14', 'Y년 %m월 %d일'), 
		date_format(cast('2025-08-14' as date), 'Y년 %m월 %d일') 
	from dual; 
    
select cast(1-2 as unsigned),
	cast(cast(1-2 as unsigned) as signed) 
    from dual;

select cast(cast(1-2 as unsigned) as signed),
		cast(cast(1-2 as unsigned) as int),
		cast(cast(1-2 as unsigned) as integer),
		cast(cast(1-2 as unsigned) as signed int),
		cast(cast(1-2 as unsigned) as signed integer) 
    from dual;

-- type
-- 문자: varchar, char, text. CLOB(Character Large OBject)
-- 정수: medium int, int(signed, integer), unsigned big int
-- 실수: float, double
-- 시간: date, datetime
-- LOE: CLOB, BLOB(Binary Large OBject)


