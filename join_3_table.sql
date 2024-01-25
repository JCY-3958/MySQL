use sqldb;

create table stdtbl (
	stdname varchar(10) not null primary key,
    addr char(4) not null
    );

create table clubtbl (
	clubname varchar(10) not null primary key,
    roomno char(4) not null
    );
    
create table stdclubtbl (
	num int auto_increment not null primary key,
    stdname varchar(10) not null,
    clubname varchar(10) not null,
    foreign key(stdname) references stdtbl(stdname),
    foreign key(clubname) references clubtbl(clubname)
    );
    
insert into stdtbl values('김범수', '강남'), ('성시경', '서울'),
	('조용필', '경기'), ('은지원', '경북'), ('바비킴', '서울');
    
insert into clubtbl values('수영', '101호'), ('바둑', '102호'),
	('축구', '103호'), ('봉사', '104호');
    
insert into stdclubtbl values(null, '김범수', '바둑'), (null, '김범수', '축구'), (null, '조용필', '축구'),
	(null, '은지원', '축구'), (null, '은지원', '봉사'), (null, '바비킴', '봉사');
    
select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

-- 학생 기준으로 학생이름, 지역, 가입한 동아리, 동아리방 출력
select s.stdname, s.addr, c.clubname, c.roomno
	from stdtbl s
		inner join stdclubtbl sc
			on s.stdname = sc.stdname -- 기본키 - 외래키
		inner join clubtbl c
			on sc.clubname = c.clubname -- 기본키 - 외래키
	order by s.stdname;
    
/*
학생 이름, 지역은 stdtbl에 있고
가입한 동아리, 동아리방은 clubtbl에 있다.

stdtbl -> stdclubtbl <- clubtbl이 되어야하니
inner join 2개를 써준다.
*/

-- 동아리 기준으로 가입한 학생의 목록
select	c.clubname, c.roomno, s.stdname ,s.addr
	from stdtbl s
		inner join stdclubtbl sc
			on s.stdname = sc.stdname -- 기본키 - 외래키
		inner join clubtbl c
			on sc.clubname = c.clubname -- 기본키 - 외래키
	order by c.clubname;