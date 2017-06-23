CREATE DATABASE IF NOT EXISTS manastory
DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE manastory;  

CREATE TABLE 1min(
	lit VARCHAR(16392)
);

CREATE TABLE 5min(
	lit VARCHAR(16392)
);

CREATE TABLE 10min(
	lit VARCHAR(16392)
);


LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/phrase' INTO table 1min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/poem1' INTO table 5min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/poem2' INTO table 5min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/poem3' INTO table 5min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/poem4' INTO table 5min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/novel1' INTO table 10min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/novel2' INTO table 10min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/novel3' INTO table 10min lines terminated by '@';
LOAD DATA LOCAL INFILE '/home/ubuntu/바탕화면/request/novel4' INTO table 10min lines terminated by '@';


 SELECT REPLACE(lit, '\n','<br>') from 10min;
 
 UPDATE 1min SET lit = REPLACE(lit ,'\n','<br>');
