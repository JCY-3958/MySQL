use shopdb;

create table indexTBL(first_name varchar(14), last_name varchar(16), hire_date date);
insert into indexTBL
	select first_name, last_name, hire_date from employees.employees Limit 500;
select * from indexTBL;

select * from indextbl where first_name = 'mary';
-- 인덱스가 없는 상황에서 500행 검색 비용은 50.75

create index idx_indextbl_firstname on indextbl(first_name);

select * from indextbl where first_name = 'mary';
-- 인덱스가 있는 상황에서는 1개의 행만 검색하여 비용이 0.35

use shopdb;
select * from productTbl;
delete from producttbl;
select * from productTbl;

-- 대용량 테이블 생성
use sqldb;
create table bigtbl1 (select * from employees.employees);
create table bigtbl2 (select * from employees.employees);
create table bigtbl3 (select * from employees.employees);

-- 삭제 delete, drop, truncate
delete from bigtbl1;
drop table bigtbl2;
truncate table bigtbl3;

desc bigtbl1; -- 뼈대(구조)는 남아있음
desc bigtbl2; -- 테이블 자체가 사라짐
desc bigtbl3; -- 뼈대(구조)는 남아있음



-- insert 실습
-- insert 중 앞에서 오류 시 뒤에 입력이 되지 않는 경우
use sqldb;
create table membertbl (select userid, name, addr from usertbl limit 3);
alter table membertbl
	add constraint pk_membertbl primary key (userid); -- pk를 지정

select * from membertbl;
desc membertbl;

-- 3개 블럭지정 후 실행하면 오류 때문에 데이터가 하나도 안들어가짐
insert into membertbl values('BBK', '비비코', '미국'); -- pk에 중복x
insert into membertbl values('SJH', '서장훈', '서울'); -- 앞에서 에러나서 뒤에도 실행x
insert into membertbl values('HJY', '현주엽', '경기');

-- ignore문으로 앞에서 발생한 입력 오류에 대해 무시하고 입력 실행
insert ignore into membertbl values('BBK', '비비코', '미국'); -- x
insert ignore into membertbl values('SJH', '서장훈', '서울'); -- o
insert ignore into membertbl values('HJY', '현주엽', '경기'); -- o
select * from membertbl;

-- 데이터 입력 시 기본 키가 중복되면 데이터가 수정이 되게 하기
insert into membertbl values('BBK', '비비코', '미국')
	on duplicate key update name = '비비코', addr = '미국';
insert into membertbl values('DJM', '동짜몽', '일본')
	on duplicate key update name = '동짜몽', addr = '일본';
select * from membertbl;

-- 비재귀 CTE
select userid as '사용자', sum(price * amount) as '총구매액'
	from buytbl group by userid;

-- 총구매액 기준 내림차순
select userid as '사용자', sum(price * amount) as '총구매액'
	from buytbl group by userid order by sum(price * amount) desc;
    
-- 위 구문 단순화
with abc(userid, total)
as
(select userid, sum(price * amount)
	from buytbl group by userid)
select * from abc order by total desc;