use thisisjava;
-- 사용자 정보
create table users (
	userid varchar(50) primary key,
    username varchar(50) not null,
    userpassword varchar(50) not null,
    userage numeric(3) not null,
    useremail varchar(50) not null
    );
desc users;

-- 게시물 정보
create table boards (
	bno int primary key auto_increment,
    btitle varchar(100) not null,
    bcontent longtext,
    bwriter varchar(50) not null,
    bdate datetime default now(),
    bfilename varchar(50) null,
    bfiledata longblob null
    );
desc boards;

-- 계좌 정보
create table accounts (
	ano varchar(20) primary key,
    owner varchar(20) not null,
    balance numeric not null
    );
desc accounts;

insert into accounts (ano, owner, balance)
values('111-111-1111', '하여름', 100000);

insert into accounts (ano, owner, balance)
values('222-222-2222', '한겨울', 0);

select * from accounts;
select * from users;
select * from boards;

-- 트랜잭션
start transaction;

delete from boards;

update boards
	set btitle = "나 돌아갈래"
    where bno = 6;

select * from boards;

-- 확인, 취소
commit;
rollback;

select * from boards;