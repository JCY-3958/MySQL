-- 영화 데이터베이스(movieDB), 영화 테이블(movieTBL)
create database moviedb;

use moviedb;
create table movietbl
	(movie_id int,
    movie_title varchar(30),
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext,
    movie_film longblob
    ) default charset=utf8mb4;

desc movietbl;
    
insert into movietbl values(1, '쉰들러 리스트', '스필버그', '리암 니슨',
	load_file('C:/SQL/Movies/Schindler.txt'), load_file('C:/SQL/Movies/Schindler.mp4'));

-- 영화 대본이랑 동영상은 들어가지 않아서 null로 나온다.
select * from movietbl;

-- 최대 파일 크기 확인, 6MB 확인, 그래도 안됨
show variables like 'max_allowed_packet';

-- 파일 업/다운로드할 폴더 경로를 별도로 허용해 줘야한다. 여기 경로가 나온다. 이 경로 수정 필요
show variables like 'secure_file_priv';

/*
원격에서는 수정 불가. 설치된 곳에서 ini파일 수정해야함
programdata 안에 mysql 안에 server 안에 my.ini
찾기에서 max_allowed 검색하면 64MB 나옴 -> 1024M(1GB)로 수정, 4GB까지 가능
secure-file-priv 찾아서 secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads"로 변경
그 다음 윈도우키 누르고 '서비스 앱' 키기 mysql80 -> 중지 -> 시작(안되는 경우가 많음)
수정 ini 지우고 원본넣고 다시 시작 누르면 일단 됨.
다시 워드패드로 수정해본다. 다시 중지하고 시작...은 안됨. 노트패드++로 수정 시도 -> 안됨
일단 파일을 서버의 C:/ProgramData/MySQL/MySQL Server 8.0/Uploads에 파일들 복사
*/

use moviedb;
truncate movietbl;

insert into movietbl values(1, '쉰들러 리스트', '스필버그', '리암 니슨',
	load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Schindler.txt'), load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Schindler.mp4'));
    
insert into movietbl values(2, '쇼생크 탈출', '프랭크 다라본트', '팀 로빈스',
	load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shawshank.txt'), load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shawshank.mp4'));
    
insert into movietbl values(3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스',
	load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Mohican.txt'), load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Mohican.mp4'));
    
select * from movietbl;

-- 다운로드 outfile(텍스트)
select movie_script from movietbl where movie_id = 1
	into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Schindler_out.txt'
	lines terminated by '\\n';

-- 다운로드 dumpfile(각종 미디어)
select movie_film from movietbl where movie_id = 3
	into dumpfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Mohican_out.mp4';
    
    
    
    
    
