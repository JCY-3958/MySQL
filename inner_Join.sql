select * from buytbl
	inner join usertbl
		on buytbl.userid = usertbl.userid
	order by num;

-- userid에서 오류가 발생
select userid, name, prodname, addr, concat(mobile1, mobile2) as '연락처'
	from buytbl
	inner join usertbl
		on buytbl.userid = usertbl.userid
	order by num;
    
-- 별칭 사용
select b.userid, u.name, b.prodname, u.addr, concat(u.mobile1, u.mobile2) as '연락처'
	from buytbl  B
	inner join usertbl U
		on b.userid = u.userid
	order by num;
    
 -- 별칭 사용(연락처 보기 좋게)
select b.userid, u.name, b.prodname, u.addr, concat_ws('-', u.mobile1, u.mobile2) as '연락처'
	from buytbl  B
	inner join usertbl U
		on b.userid = u.userid
	order by num;  
    
-- 회원 테이블 기준 JYP라는 아이디가 구매한 물건의 목록
select * 
	from usertbl u
		inner join buytbl b
			on u.userid = b.userid
		where b.userid = 'JYP';
        
-- inner join : 교집합이라고 볼 수 있다.


select u.userid, u.name, b.prodname, u.addr, concat(u.mobile1, u.mobile2) as '연락처'
	from usertbl u
		inner join buytbl b
			on u.userid = b.userid
	order by u.userid;
    

-- distinct : 중복 제거, 한번이라도 구매한 회원이 정보
select distinct u.userid, u.name, u.addr
	from usertbl u
    inner join buytbl b
		on u.userid = b.userid
	order by u.userid;


select u.userid, u.name, u.addr
	from usertbl u
    where exists (
		select *
        from buytbl b
        where u.userid = b.userid);