-- cast : 형식 변환
select cast('2020-10-10 12:35:29:123' as date) as 'date';
select cast('2020-10-10 12:35:29:123' as time) as 'time';
select cast('2020-10-10 12:35:29:123' as datetime) as 'datetime';

-- 변수 사용 실습
use sqldb;

set @myvar1 = 5;
set @myvar2 = 3;
set @myvar3 = 4.25;
set @myvar4 = '가수 이름 ==>';

select @myvar1;
select @myvar2 + @myvar3;
select @myvar4, name from usertbl where height > 180;

set @myvar1 = 3;
-- 명령어 준비 : 대입할 구문 지정
prepare myquery
	from 'select name, height from usertbl order by height limit ?';
-- 준비된 명령어 실행
execute myquery using @myvar1; -- ?에 myquery를 대입

select name, height from usertbl order by height limit @myvar1;

-- 형변환 cast, convert
use sqldb;
select avg(amount) as '평군 구매 개수' from buytbl;

-- 정수형으로 표현
select cast(avg(amount) as signed integer) as '평균 구매 개수' from buytbl;
select convert(avg(amount), signed integer) as '평균 구매 개수' from buytbl;

select cast('2020$12$12' as date);
select cast('2020/12/12' as date);
select cast('2020%12%12' as date);
select cast('2020@12@12' as date);

-- 숫자형을 문자형으로 출력 concat : 문자와 문자를 연결
select num, concat(cast(price as char(10)), 'X', cast(amount as char(4)), '=') as
	'단가x수량',
		price * amount as '구매액'
	from buytbl;
    
select '100' + '200';
select concat('100', '200');
select concat(100, '200');
select 1 > '2mega';
select 3 > '2mega';
select 0 = 'mega2';

select if (100 > 200, '참이다', '거짓이다');

select ifnull(null, '널널널');
select ifnull(100, '널널널');

-- 수식1과 수식2가 같으면 null 반환, 아니면 수식1 반환
select nullif(100, 100), nullif(200, 100);

-- case ~ when ~ else ~ end : switch문과 비슷
select case 10
	when 1 then '일'
    when 5 then '오'
    when 10 then '십'
    else '모름'
end as 'case연습';


select ascii('A'), char(65);
select bit_length('abc'), char_length('abc'), length('abc');
select bit_length('가나다'), char_length('가나다'), length('가나다');

select concat_ws('/', '2025', '01', '01');

select elt(2, '하나', '둘', '셋'), field('둘', '하나', '둘', '셋'),
	find_in_set('둘', '하나,둘,셋'), instr('하나둘셋', '둘'), locate('둘', '하나둘셋');
    
select format(123456.123456, 4);

select bin(10), hex(10), oct(10);

select insert('abcdefghi', 3, 4, '@@@@'), insert('abcdefghi', 3, 2, '@@@@');

select left('abcdefghi', 3), right('abcdefghi', 3);

select lower('abcdEFGH'), upper('abcdEFGH');

select lpad('이것이', 5, '##'), rpad('이것이', 5, '##');

select ltrim('         이것이');

select trim('  이것이  '), trim(both 'ㅋ' from 'ㅋㅋㅋ재밌어요.ㅋㅋㅋ');

select substring('980405-1234567', 8, 1);
select substring('980405-1234567', 1, 2);
select substring('980405-1234567', 3, 4);

select substring_index('cafe.naver.com', '.', 2), substring_index('cafe.naver.com', '.', -2);

select acos(), asin(), atan(), atan2(), sin(), cos(), tan();

select ceiling(4.7), floor(4.7), round(4.7);
select conv('AA', 16, 2), conv(100, 10, 8);
select degrees(pi()), radians(180);
select mod(157, 10), 157 % 10, 157 mod 10;
select pow(2, 3), sqrt(9);
select rand(), floor(1 + (rand() * (7-1)));
select floor(1 + (rand() * (50)));
select truncate(12345.12345, 2), truncate(12345.12345, -2);
select adddate('2025-01-01', interval 31 day), adddate('2025-01-01', interval 1 month);
select subdate('2025-01-01', interval 31 day), subdate('2025-01-01', interval 1 month);
select addtime('2025-01-01 23:59:59', '1:1:1'), addtime('15:00:00', '2:10:10');
select subtime('2025-01-01 23:59:59', '1:1:1'), subtime('15:00:00', '2:10:10');
select year(curdate()), month(curdate()), day(curdate());
select hour(curtime()), minute(current_time()), second(current_time),
	microsecond(current_time);
select date(now()), time(now());
select datediff(now(), '1998-04-05'), timediff('23:23:59', '12:11:10');
select dayofweek(curdate()), monthname(curdate()), dayofyear(curdate());
select last_day('2025-02-01');
select makedate(2024, 132);
select maketime(12, 11, 10);
select period_add(202501, 11), period_diff(202501, 202312);
select quarter('2025-07-07');
select time_to_sec('12:11:10');
select current_user(), database();
use sqldb;
update buytbl set price=price * 2;
select row_count();
select sleep(5);
select '5초 후에 이게 보여요';
