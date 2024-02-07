-- SHOW DATABASES;
-- CREATE DATABASE fpkm999test;
-- USE fpkm999test;
# CREATE DATABASE Mydatabase;
-- SHOW DATABASES;

-- 테이블 새성

CREATE TABLE tcity (
	NAME CHAR(10) PRIMARY KEY,
	area INT NULL,
	popu INT NULL,
	metro CHAR(1) NOT NULL,
	region CHAR(6) NOT NULL
	);
USE db_test;
SELECT * FROM tcity;
# USE db_test;

 CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Salary INT
	);

 SELECT * FROM Employees;
 SELECT * FORM tcity;

INSERT INTO tcity VALUES ('서울',605,974,'y','경기');
INSERT INTO tcity VALUES ('부산',765,342,'y','경상');
INSERT INTO tcity VALUES ('오산',42,21,'n','경기');
INSERT INTO tcity VALUES ('청주',940,83,'n','충청');
INSERT INTO tcity VALUES ('전주',205,65,'n','전라');
INSERT INTO tcity VALUES ('순천',910,27,'n','전라');
INSERT INTO tcity VALUES ('춘천',1116,27,'n','강원');
INSERT INTO tcity VALUES ('홍천',1819,7,'n','강원');
SELECT *FROM db_test.tcity; 
SHOW DATABASES;
SELECT *FROM tcity;
CREATE TABLE tStaff 
(
	NAME CHAR (15) PRIMARY KEY,
	depart CHAR (10) NOT NULL,
	gender CHAR (3) NOT NULL,
	joindate DATE NOT NULL,
	grade CHAR (10) NOT NULL,
	salary INT NOT NULL,
	score DECIMAL(5,2) NULL	
	);
INSERT INTO tStaff VALUES ('김유신','총무부','남','2000-2-3','이사',420,88.8);
INSERT INTO tStaff VALUES ('유관순','영업부','여','2009-3-1','과장',380, NULL);
INSERT INTO tStaff VALUES ('안중근','인사과','남','2012-5-5','대리',256,76.5);
INSERT INTO tStaff VALUES ('윤봉길','영업부','남','2015-8-15','과장',350,71.25);
INSERT INTO tStaff VALUES ('강감찬','영업부','남','2018-10-9','사원',320,56.0);
INSERT INTO tStaff VALUES ('정몽주','총무부','남','2010-9-16','대리',370,89.5);
INSERT INTO tStaff VALUES ('허난설헌','인사과','여','2020-1-5','사원',285,44.5);
INSERT INTO tStaff VALUES ('신사임당','영업부','여','2013-6-19','부장',400,92.0);
INSERT INTO tStaff VALUES ('성삼문','영업부','남','2014-6-8','대리',285,87.75);
INSERT INTO tStaff VALUES ('논개','인사과','여','2010-9-16','대리',340,46.2);
INSERT INTO tStaff VALUES ('황진이','인사과','여','2012-5-5','사원',275,52.5);
INSERT INTO tStaff VALUES ('이율곡','총무부','남','2016-3-8','과장',385,65.4);
INSERT INTO tStaff VALUES ('이사부','총무부','남','2000-2-3','대리',375,50);
INSERT INTO tStaff VALUES ('안창호','영업부','남','2015-8-15','사원',370,74.2);
INSERT INTO tStaff VALUES ('을지문덕','영업부','남','2019-6-29','사원',330, NULL);
INSERT INTO tStaff VALUES ('정약용','총무부','남','2020-3-14','과장',380,69.8);
INSERT INTO tStaff VALUES ('홍길동','인사과','남','2019-8-8','차장',380,77.7);
INSERT INTO tStaff VALUES ('대조영','총무부','남','2020-7-7','차장',290,49.9);
INSERT INTO tStaff VALUES ('장보고','인사과','남','2005-4-1','부장',440,58.3);
INSERT INTO tStaff VALUES ('선덕여왕','인사과','여','2017-8-3','사원',315,45.1);


SELECT * FROM tstaff;
SELECT * FROM tcity;

# 도시명과 인구수에만 관심이 있다면.
SELECT NAME, popu FROM tcity;

SELECT name AS "이름", depart AS "부서", gender AS "성별" FROM tstaff;

# gui 안쓰고 gender 변수의 char3 크기를 4로 변경할려고 한다면.
ALTER TABLE `tstaff` CHANGE COLUMN `gender` `gender` CHAR(4) NOT NULL COLLATE 'utf8mb4_general_ci' AFTER `depart`;
	
# 실무에선 부하를 줄이기 위해 전체 다 들고오는 * 을 잘 안씀.
SELECT NAME,AREA,popu FROM tcity;
SELECT region, NAME, AREA FROM tcity;
# 가능
SELECT region, NAME, AREA, area FROM tcity;

# 순서는 상관없음.
SELECT NAME,AREA,popu,metro,region FROM tcity;
SELECT * FROM tcity;
# 둘다 같은 결과를 보여줌

# 어디서 차이가 발생하는가? 
# => 테이블이 수정(컬럼을 추가하는 등)되면 결과가 달라짐
# 먼저 필드를 추가 되는 경우, 시장의 이름을 mayor 필 드에 추가하면 * 로 읽으면 
# 새 필드를 인식 하지만, 필드를 적는 경우에는 따로 추가 해줘야 함. 필드를 수정하는
# 경우, popu 필드를 ingu로 바꾸면 * 로 읽을 때는 에러가 없지만 결과셋에서
#  popu 필드를 읽는 코드는 에러가 남.
# 실무적으로는 *을 쓰지 않음. *는 뭐뭐 들어 있는지 확인하는 용도로 사용함 


/*
	문제 1. 직원 테이블에서 이름과 부서, 직급 필드만 출력하라
*/
SELECT NAME,depart,grade FROM tstaff;


# 별명 
# 필드면 [AS] "별명"
SELECT NAME AS "도시명", AREA AS '면적(제곱Km)', popu AS "인구(만명)" FROM tcity;
# "" 는 안써도 큰 문제는 없지만 특수문자등으로 오류가 날 수 있으니 습관적으로 하는 것이 좋다.


SELECT NAME AS "도시명", AREA AS "면적(제곱Km)", popu [인구( 만명)] FROM tcity;


# 2. 결과창에 다음과 같이 출력 되도록 필드를 수정하여라
SELECT NAME AS "도시", popu AS "인구(만명)", region AS "지역" FROM tcity;

# 계산값 출력
SELECT name, popu * 10000 AS "인구(명)" FROM tcity;

# 계산식을 사용하면 테이블에 있는 정보도 만들어서 표시할 수 있음
SELECT NAME, AREA, popu, popu*10000/AREA AS "인구밀도" FROM tcity;

# tCity 테이블에는 도시의 면적과 인구수 정보가 있는 데 
# 이 둘을 계산하면 제곱킬로미터당 인구수인 인구밀 도를 구할 수 있음. 
# 계산에 의해 구한 필드는 이름이 없으므로 설명적인 별명을 붙이는 것이 좋음.
# as를 빼면 계산식의 가독성이 아주 나빠진다. 별명을 붙이자.

# 계산식을 이용하면 원래 없었던 것을 만들 수 잇다.
# 꼭 테이블에 있는 필드만 출력할 수 있는게 아니라, 테이블과 상관없는
# 단순한 계산식도 출력 가능

SELECT 60 * 60 * 24 AS "하루" FROM DUAL;
SELECT 60*60*24*365 AS "1년" FROM DUAL;

# 2024-02-01

db_testdb_test`고객`
CREATE TABLE 고객 (
 고객아이디 VARCHAR(20) NOT NULL,
 고객이름 VARCHAR(10) NOT NULL,
 나이 INT,
 등급 VARCHAR(10) NOT NULL,
 직업 VARCHAR(20),
 적립금 INT DEFAULT 0, PRIMARY KEY(고객아이디)
);
INSERT INTO 고객 VALUES ('apple', '정소화', 20, 'gold', '학생', 1000);
INSERT INTO 고객 VALUES ('banana', '김선우', 25, 'vip', '간호사', 2500);
INSERT INTO 고객 VALUES ('carrot', '고명석', 28, 'gold', '교사', 4500);
INSERT INTO 고객 VALUES ('orange', '김용욱', 22, 'silver', '학생', 0);
INSERT INTO 고객 VALUES ('melon', '성원용', 35, 'gold', '회사원', 5000);
INSERT INTO 고객 VALUES ('peach', '오형준', NULL, 'silver', '의사', 300);
INSERT INTO 고객 VALUES ('pear', '채광주', 31, 'silver', '회사원', 500);
CREATE TABLE 제품 (
제품번호 CHAR(3) NOT NULL,
제품명 VARCHAR(20),
재고량 INT,
단가 INT,
제조업체 VARCHAR(20), PRIMARY KEY(제품번호), CHECK (재고량 >= 0 AND 재고량 <=10000)
);
INSERT INTO 제품 VALUES ('p01', '그냥만두', 5000, 4500, '대한식품');
INSERT INTO 제품 VALUES ('p02', '매운쫄면', 2500, 5500, '민국푸드');
INSERT INTO 제품 VALUES ('p03', '쿵떡파이', 3600, 2600, '한빛제과');
INSERT INTO 제품 VALUES ('p04', '맛난초콜릿', 1250, 2500, '한빛제과');
INSERT INTO 제품 VALUES ('p05', '얼큰라면', 2200, 1200, '대한식품');
INSERT INTO 제품 VALUES ('p06', '통통우동', 1000, 1550, '민국푸드');
INSERT INTO 제품 VALUES ('p07', '달콤비스킷', 1650, 1500, '한빛제과');
CREATE TABLE 주문 (
주문번호 CHAR(3) NOT NULL,
주문고객 VARCHAR(20),
주문제품 CHAR(3),
수량 INT,
배송지 VARCHAR(30),
주문일자 DATE, PRIMARY KEY(주문번호), FOREIGN KEY(주문고객) REFERENCES 고객(고객아이디), FOREIGN KEY(주문제품) REFERENCES 제품(제품번호)
);
INSERT INTO 주문 VALUES ('o01', 'apple', 'p03', 10, '서울시 마포구', '19/01/01');
INSERT INTO 주문 VALUES ('o02', 'melon', 'p01', 5, '인천시 계양구', '19/01/10');
INSERT INTO 주문 VALUES ('o03', 'banana', 'p06', 45, '경기도 부천시', '19/01/11');
INSERT INTO 주문 VALUES ('o04', 'carrot', 'p02', 8, '부산시 금정구', '19/02/01');
INSERT INTO 주문 VALUES ('o05', 'melon', 'p06', 36, '경기도 용인시', '19/02/20');
INSERT INTO 주문 VALUES ('o06', 'banana', 'p01', 19, '충청북도 보은군', '19/03/02');
INSERT INTO 주문 VALUES ('o07', 'apple', 'p03', 22, '서울시 영등포구', '19/03/15');
INSERT INTO 주문 VALUES ('o08', 'pear', 'p02', 50, '강원도 춘천시', '19/04/10');
INSERT INTO 주문 VALUES ('o09', 'banana', 'p04', 15, '전라남도 목포시', '19/04/11');
INSERT INTO 주문 VALUES ('o10', 'carrot', 'p03', 20, '경기도 안양시', '19/05/22');

# 1. 고객 테이블에서 고객아이디, 고객이름, 등급 속성을 검색해보자.
SELECT `고객아이디`,`고객이름`,`등급` FROM `고객`;
# ` 백틱을 이용하는게 좋다. 테이블 칼럼 딱 구분해줘서

# 조건문 pdf 
SELECT * FROM tcity WHERE AREA >1000;

SELECT NAME, AREA FROM tcity WHERE AREA > 1000;

SELECT NAME FROM tcity WHERE AREA > 1000;
# 조건문이 맞는지 확인이 불가능해 이런것은 좋지않다.

# A <> B, A != B  A와 B는 다르다. 또는 같지 않다.
# ex) WHERE region <> '경기'

# 숫자는 상수를 그냥 쓰지만 문자열과 날짜 상수는 항상 작음 따옴표로 감싸야함.
# 이건 PDF 주면 그거봐라
SELECT * FROM tcity WHERE name = '서울'; #맞다

USE db_test;
SELECT * FROM tcity;
SELECT * FROM tcity WHERE metro = 'y';

SELECT * FROM tcity WHERE metro = 'Y';

# 1. 인구가 10만명 미만인 도시의 이름을 출력하라.
SELECT * FROM tcity WHERE popu <10;
# 아래가 정답이지만 
SELECT name, popu FROM tcity WHERE popu <10;
SELECT name FROM tcity WHERE popu <10;

# 2. 전라도에 있는 도시의 정보를 출력하라
SELECT * from tcity WHERE region = '전라';

# 3. 월급이 400만원 이상인 직원의 이름을 출력하라
SELECT NAME AS "직원이름", salary AS"월급" FROM tstaff WHERE salary >= 400;
# 정답은 밑에꺼지만 우선 위에꺼 부터 만들어 봐서 확인을 하고 밑에껄로 해야한다.
SELECT NAME AS "직원이름" FROM tstaff WHERE salary >= 400;

# null 비교 
# 값이 입력되어 있지 않은 특수한 상태를 표현.
# 값을 알 수 없거나 결정할 수 없다는 뜻이며 0이나 빈 문자열과는 다름.
# 필드를 선언할 때 NULL 가능성을 미리 지정.
# 선언문 뒤에 NULL 이 있으면 이 필드에는 값을 입력하지 않아도 된다는 뜻.
# NOT NULL 로 선언되어 있으면 값이 없으면 레코드를 삽입할 수 없음.

SELECT * FROM tstaff;
# 필드명 = null 이라면. null 은 값이 아니라 상태임 그래서 안나옴

SELECT * FROM tstaff WHERE score IS NULL; 
# null을 검색할때는 is null 을 하면 된다. 비교 연산자를 쓰면 안된다.

SELECT * FROM tstaff WHERE score IS NOT NULL;
# null 이 아니라는 조건은 IS NOT NULL로 표기.

# 논리 연산자

SELECT * FROM tcity WHERE popu >= 100 AND AREA >= 700;

SELECT * FROM tcity WHERE popu >= 100 OR AREA >= 700;

# 세 개 이상의 조건문 지정시 
SELECT * FROM tcity  WHERE region = '경기' OR popu >= 50 AND AREA >=500;
# # region 이 '경기' 인 행 또는 '`popu`가 50이상이고 `AREA` 가 500 이상인 행
# AND 연산자의 우선순위가 OR 보다 높아서 문제가 발생

SELECT * FROM tcity WHERE (region = '경기' OR popu >= 50) AND AREA >= 500;
# 순서대로 실행하고 싶으면 괄호를 써라.

SELECT * FROM tcity WHERE region = '경기' AND popu >= 50 OR AREA >=500;

# 괄호를 어떻게 치냐에 따라 결과는 달라짐

SELECT * FROM tcity WHERE (AREA >= 500 OR REGION = '경기') AND popu >= 50;
# 경기도 도시중 인구가 50만이상이거나 또는 경기권이 아니고 50만보다 적다라도 면적이 500이상인 도시를 검색

SELECT * FROM tcity WHERE region = '경기' AND (popu >=50 or AREA >=500); 
# `region`이 '경기' 이고 `popu`가 50 이상인 행 또는 `AREA` 가 500 이상인 행


# NOT 연산자

SELECT * FROM tcity WHERE region !='경기';
# 경기도가 아닌 것을 골라내라

SELECT * FROM tcity WHERE NOT(region = '경기');
# 이것도 위와 동일하다.


# 아래 조건의 반대 조건을 만들어라
SELECT * FROM tcity WHERE region = '전라' OR metro = 'y';


SELECT * FROM tcity WHERE region != '전라' AND metro != 'y';
# 드모르간의 법칙
SELECT * FROM tcity WHERE NOT( region = '전라' OR metro = 'y');

# 1. 직원 목록에서 월급이 300 미만이면서 성취도는 60이상인 직원이 누구인지 조사하라.
select NAME,salary,score from tstaff where salary <300 and score >=60;
# 반대로 해봐라
SELECT NAME, salary, score FROM tstaff WHERE salary >=300 OR score < 60;

select name from tstaff where salary <300 and score >=60;

# 2. 영업부의 여직원 이름을 조사하라.
select * from tstaff WHERE depart='영업부' and gender = '여';

select name from tstaff where depart='영업부' and gender = '여';

# like
# 비교 연산자를 완전히 일치하는 조건식을 표현하는데 비해 LIKE 연산자는 패턴으로 '부분 문자열' 을 검색.
# ex) 성이 김씨인 사람, 주소가  강남구인 사람들을 검색할 때 편리.
SELECT * FROM tcity;
SELECT * FROM tcity WHERE NAME LIKE '%천%';
# 내가 찾고자 하는 글자 앞뒤로 %을 붙인다.

SELECT * FROM tcity;

SELECT * FROM tcity WHERE NAME LIKE '%홍%';

SELECT * FROM tcity WHERE NAME NOT LIKE '%천%';
# 천이 아닌것만 뽑아내기

select * from tcity where name not LIKE '%오%';

SELECT * FROM tcity WHERE NAME LIKE '청%';
SELECT * FROM tcity WHERE NAME LIKE '천%';
# 천으로 시작하는 것을 찾아라 => 없음
# e.g ) 성이 홍씨인 사람만 불러와라 같은 경우에 사용함. 뒤에 %만 붙이는 경우. 첫글자 기준으로 뽑아내는 케이스.

SELECT * FROM tcity WHERE NAME LIKE '천%';
# 천으로 끝나는 글자만 출력
# 천안이 있다면 안나옴

# 1. 직원 목록에서 '정'씨를 조사하라.
# 2. 이름에 '신'자가 포함된 직원을 조사하라.

SELECT * FROM tstaff ;
# 1. 직원 목록에서 '정'씨를 조사하 라.
SELECT * FROM tstaff WHERE NAME LIKE '정%';
SELECT NAME FROM tstaff WHERE NAME LIKE '정%';


#2 이름에 '신'자가 포함된 직원을 조사하라.

SELECT * FROM tstaff WHERE NAME LIKE '%신%';
SELECT NAME FROM tstaff WHERE NAME LIKE '%신%';

# 3 . 성이 아니라 이름에 '신'자가 포함된 직원을 조사하라.
SELECT NAME FROM tstaff WHERE( NAME NOT LIKE '신%') AND (NAME LIKE '%신%'); 
SELECT * FROM tstaff WHERE (name NOT LIKE '신%') AND  (name LIKE '%신%');

# BETWEEN  
# BETWEEN 최소값 AND 최대값 형식 => "BETWEEN 최소값 AND 최대값"

SELECT * FROM tcity WHERE popu BETWEEN 50 AND 100;

#위와 아래는 동일함
# 인구가 50 ~ 100만 사이의 도시를 구함
SELECT * FROM tcity WHERE popu >=50 AND popu <= 100;
SELECT * FROM tcity WHERE popu BETWEEN 50 AND 100;

# 범위 조건은 주로 수치 값에 사용하지만 문자열이나 날짜에도 사용 가능

SELECT * FROM tstaff WHERE NAME BETWEEN '가' AND '사';

SELECT * FROM tstaff WHERE joindate BETWEEN '20150101' AND '20180101';


# 1. 면적이 500 ~ 1000 사이의 도시목록을 조사하라.
# 2. 월급이 200만원대인 직원의 목록을 구하라.

#1 
SELECT * FROM tcity WHERE area BETWEEN 500 AND 1000;

#2 
SELECT * FROM tstaff WHERE salary BETWEEN 200 AND 299;


# IN 
# IN 연산자는 불연속적인 값 여러 개의 목록을 제공하여 이 목록과 이리하는 레코드를 검색

# 경상도 이거나 전라도 인 지역
SELECT * FROM tcity WHERE region IN('경상','전라');

# 위와 같음
SELECT * FROM tcity WHERE region ='경상' OR region = '전라';

# 2개라서 쉬워 보이는데 10개 이상의 값을 찾아야 한다면?

SELECT * FROM tcity WHERE region NOT IN('경상','전라');


# LIKE 와 IN 결합은 안됨
# 이런 검색을 하고 싶으면 각각의 LIKE 조건을 OR 연산 자로 연결

SELECT * FROM tstaff WHERE NAME LIKE IN ('이%', '안%');

SELECT * FROM tstaff WHERE NAME LIKE '이%' OR NAME LIKE '안%';

SELECT * FROM tstaff WHERE (NAME LIKE '이%') OR (NAME LIKE '안%');

# 1. 총무부나 영업부에 근무하는 직원의 목록을 조사하라.
# 2. 총무부나 영업부에 근무하는 대리의 목록을 조사하라.
# 3. 차장급 이상의 여직원 목록을 조사하라.
SELECT * FROM tstaff WHERE depart IN('영업부','총무부') ;

SELECT * FROM tstaff WHERE depart IN('영업부','총무부') AND grade='대리';

SELECT * FROM tstaff WHERE grade IN('부장') AND gender ='여';
# 과장 < 차장 < 부장
SELECT * FROM tstaff WHERE gender ='여';

# 1번
SELECT 고객아이디, 고객이름, 등급 FROM 고객;

# 2번
SELECT 고객아이디, 고객이름, 나이, 등급, 직업, 적립금 FROM 고객;

# 3번
SELECT * FROM 고객;

# 4번
SELECT 제조업체  FROM 제품;

# 5번 ALL 키워드를 사용해서 제조업체를 검색
SELECT ALL 제조업체 FROM 제품;
SELECT  제조업체 FROM 제품;	# ALL 은 안적어도 동일함(ALL 이 생략된 형태)

# 변경 - 중복제거
SELECT DISTINCT 제조업체 FROM 제품;

# 7번
SELECT 제품명, 단가 as "가격" FROM 제품;

# 8번
SELECT 제품명,(단가+500) AS "조정 단가"  FROM 제품;

select 고객이름, 나이  from 고객 where 나이>=30;

# "주문" 테이블에서 2019년 2월에 이루어진 모든 주문의 주문번호와 
# 주문일자를 선택하는 SQL 쿼리를 작성하세요.

select 주문번호, 주문일자 from 주문 WHERE 주문일자 BETWEEN '2019-02-01' AND '2019-02-28';

# "제품" 테이블에서 재고량이 2000 이상이고 단가가 3000 이하인 제품들의 제품번호,
# 제품명, 재고량,  단가를 선택하는 SQL 쿼리를 작성하세요.
select 제품번호,제품명,재고량,단가 from 제품 where 재고량>=2000 and 단가<=3000;

# "고객" 테이블에서 등급이 'gold'이고 적립금이 3000 이상인 고객들의 고객아이디, 고객이름, 등급, 적립금을 선택하는 SQL 쿼리를 작성하세요.

select 고객아이디, 고객이름, 등급, 적립금  from 고객 where 등급='gold' AND 적립금 >= 3000;

SHOW TABLES;
SELECT * FROM 주문;

select 주문제품,수량,주문일자,주문고객 from 주문 where 주문고객='apple' OR  수량>=15;

select * from 고객 WHERE 고객이름='김%';

select 고객이름 from 고객 where 나이 is null;

SELECT * FROM 고객 WHERE 고객이름 LIKE '김%';
 
 /*
 "주문" 테이블에서 각 주문별로 주문한 제품의 총 가격을 계산하여,
  주문번호와 해당 주문의 총 가격을 나타내는 SQL 쿼리를 작성하세요. 
  주문의 총 가격은 수량(수량)과 해당 제품의 단가(제품 테이블의 단가)를 곱한 값입니다. 
 (힌트: JOIN을 사용하세요.) */
 
 # join 맛보기 
 
 select 주문번호, 주문고객, 주문제품, 수량,배송지, 수량*단가 AS "총가격" from 주문 join 제품 ON 주문.주문제품 = 제품.제품번호;
 
 SELECT 고객아이디, 고객이름, 등급 FROM 고객  WHERE LENGTH(`고객아이디`) = 5;
 
 SELECT 고객아이디, 고객이름, 등급 FROM 고객  WHERE 고객아이디 LIKE 'a____';
 SELECT * FROM 고객;
 
 # "고객" 테이블에서 등급이 'silver'인 고객들의 고객아이디, 
 # 고객이름, 나이를 선택하는 SQL 쿼리를 작성하세요.
 SELECT * FROM 고객;
 SELECT 고객아이디,고객이름,나이 FROM 고객 WHERE 등급='silver';
 
 # "주문" 테이블에서 2019년에 이루어진 모든 주문의 주문번호, 
 # 주문고객, 주문일자를 선택하는 SQL 쿼리를 작성하세요.
 
 SELECT 주문고객,주문일자  FROM 주문 WHERE 주문일자 BETWEEN '2019-01-01' AND '2019-12-31';

 
 # "제품" 테이블에서 제품명이 '라면'을 포함하는 모든 제품들의 제품번호와 
 # 제품명을 선택하는 SQL 쿼리를 작성하세요.
 SELECT * FROM 제품;
 SELECT 제품번호,제품명 FROM 제품 WHERE 제품명 LIKE '%라면%'
 
 # "고객" 테이블에서 나이가 25세 이상인 고객들 중에서 등급이 'gold' 또는 'vip'인 고객들의
 # 고객아이디,  고객이름, 나이, 등급을 선택하는 SQL 쿼리를 작성하세요.
 SELECT 고객아이디, 고객이름, 나이, 등급  FROM 고객 WHERE 나이 >= 25 AND 등급 IN('gold','vip');
  
  ##########################################################
# 3일차 ORDER BY - 정렬

# 끝

# 2024-02-05

# 함수 : COUNT 
# *은 전체를 세는거

SELECT * FROM tstaff;
SELECT COUNT(*) FROM tstaff;
SELECT COUNT(*) AS "총 직원수" FROM tstaff; # 가동성이 좋아 AS로 별명도 부여하는 편임

# 조건문에도 사용한다면

# 월급이 400만원 이상인 직원의 수를 조사하고, 결과는 3명.
SELECT COUNT(*) FROM tstaff where salary >= 400;


# 해당하는 조건이 없는 경우 0이 옴
# 월급이 1억이 넘는 직원의 수를 조사하고, 결과는 0
SELECT * FROM tstaff;
SELECT COUNT(*) FROM tstaff WHERE salary >= 10000;

# * 대신에 필드명을 이용할 수 있음 (현재는 필드값만 했을떄와 ALL을 헀을 떄 큰 차이가 안남)

SELECT COUNT(NAME) FROM tstaff;

SELECT COUNT(depart) FROM tstaff;

# 지정한 필드값이 존재하는 레코드의 개수를 구함

# 중복 부서를 제외하고 부서의 종류가 몇 개인지 알고 싶으면 필드명 앞에 DISTINCT 키워드를 붙임.
# 중복을 제거하고 3개의 부서가 있다고 출력.
SELECT COUNT(DISTINCT depart) FROM tstaff;

# count 함수는 '필드값이 제대로 들어 있는 레코드의 개수만 구하며' 필드값이 NULL 인 레코드는 개수에서 제외함.
SELECT COUNT(score) FROM tstaff; # NULL 2개 있는 필드는 제외됨
SELECT score FROM tstaff;


# 이렇게 계산할 수도 있다 (널값을 구하는 방법)
SELECT COUNT(*) - COUNT(score) FROM tstaff;

# 위 아래 결과는 동일하고 보통 아래의 것을 사용하는편임 (가독성)
# 총 직원수에서 score 의 값이 NULL 인 직원의 수를 구할 경우엔는 이러한 문을 사용함.

SELECT COUNT(*) FROM tstaff WHERE score IS NULL;


# count 함수의 인수로 필드를 지정하는 경우는 드물고 count(*)로 전체 레코드의 개수를 구하는 경우가 일반적임.

	
# 연습문제
# 1. 실적도 없이 놀고 있는 두 직원은 두구인지 목록을 출력하는 쿼리를 작성하라. 몇명이란 말이 없어서 count 아님 널 조사

SELECT * FROM tstaff;
SELECT NAME,score FROM tstaff WHERE score IS NULL;

# 2. 성취도가 80점 이상인 직원이 몇 명이나 되는지 조사하라.

SELECT * FROM tstaff;
SELECT COUNT(*) FROM tstaff WHERE score>= 80;

# 2024-02-05 2. 합계와 평균
# 통계값을 계산하는 함수.

# 종류 : SUM, AVG, MIN, MAX, STDDEV(표준편차), VARIANCE(분산)  *표준편차와 분산은 잘 사용할 일이 없음

# 도시 목록에서 인구의 총합과 평균을 구함
SELECT SUM(popu), AVG(popu) FROM tcity;

# 도시 목록에서 면적의 최솟값과 면적의 최대값을 구함. 모든 도시의 area 필드를 조사하여 가장 작은 값과 가장 큰 값을 찾음.
SELECT MIN(AREA), MAX(AREA) FROM tcity;

# order by , limit을 이용해서도 min max 값을 구할 수도 있음


# 인사과에서 성취도의 총합과 성취도의 평균을 가져와라
SELECT SUM(score), AVG(score) FROM tstaff WHERE depart ='인사과';
# count는 all을 많이 사용하고 여기는 all을 쓰는 경우가 적어서 count와는 따로 분리해서 사용함

# 영업부에서 최대 월급을 받는사람 최소 월급을 받는 사람
SELECT MIN(salary), MAX(salary) FROM tstaff WHERE depart ='영업부';

# 문자열끼리는 더 할 수 없어 총합을 계산할 수 없고, 평균도 의미 없음
SELECT MIN(NAME) FROM tstaff;

# 문자열끼리는 사전순으로 비교할 수 있고, 날짜도 마찬가지 여서 문자열, 날짜에 대해서는 MIN, MAX 함수는 사용 가능
SELECT MAX(popu), NAME FROM tcity;

# 인구가 제일 많은 도싱니 서울의 값이 나올 것 같지만, 서울의 인구수와 부산이 나옴
# 집계함수와 일반필드는 같이 사용해서는 안된다! # 
# 서로 따로노니까..

# 만약 인구가 제일 도시값을 NAME 필드랑 같이 가져오고 싶다면 이렇게 할 수 있다.
SELECT popu, NAME FROM tcity ORDER BY popu DESC limit 1;


# 연습 문제1

# 1. 여직원 중 최고 월급은 얼마인지 조사하라. case1. 집계함수 case2. ORDERBY + LIMIT 조합해서 해봐라
# 2. 총무부 직원이 최초로 입사한 날짜를 구하라.

# 1번 
SELECT * FROM tstaff WHERE gender='여';
SELECT MAX(salary) FROM tstaff WHERE gender='여';

SELECT * FROM tstaff WHERE gender='여' ORDER BY salary DESC LIMIT 1;
SELECT salary FROM tstaff WHERE gender='여' ORDER BY salary DESC LIMIT 1;

# 2번
SELECT * FROM tstaff WHERE depart ='총무부';

SELECT MIN(joindate) FROM tstaff WHERE depart ='총무부';
SELECT joindate FROM tstaff WHERE depart='총무부' ORDER BY joindate ASC LIMIT 1;

# 2024-02-05 3. 집계 함수와 NULL
# NULL은 값을 알 수 없는 특수한 상태.
# 모든 집계 함수는 NULL을 무시하고 통계를 계산.
# 단, 예외적으로 레코드 개수를 세는 count(*)는 NULL도 포함하지만, 인수로 필드를 지정하면 NULL을 세지 않음.

SELECT AVG(salary) FROM tstaff;

## 둘다 동일함. 위에꺼가 좀 더 편함
SELECT SUM(salary)/COUNT(*) FROM tstaff;

# 평균은 총합을 개수로 나누어서 구함.
# 그래서 두 명령은 동일한 결과를 보여줌.

SELECT AVG(score) FROM tstaff;

# 얘는 값이 다르게 나옴 why?
# score 에는 null값이 2개가 있는데
# avg 함수는 null 값을 제외하고 계산을 하지만
# count(*)의 경우 null 값을 포함해서 계산함
SELECT SUM(score) / COUNT(*) FROM tstaff;	# 모든 집계 함수는 null값을 포함해서 카운트를 게산함.

SELECT SUM(score) / COUNT(score) FROM tstaff; # 이렇게 해야한다

# score의 경우에는 다른 값이 나옴
# AVG 함수는 NULL 값을 제외하고 계싼을 하지만, count(*)의 경우 NULL 값도 포함함.


# 결과값에서도 다른데
SELECT COUNT(*) FROM tstaff WHERE depart = '비서실'; # 0 출력

# 0 도 하나의 값이다.
SELECT MIN(salary) FROM tstaff WHERE depart ='비서실'; # null 출력

# count(*) 과 다른 집계 함수의 경우, count(*)는 없다는 뜻의 0을 리턴하지만,
# 다른 집계함수는 계산 대상이 없어서 존재하지 않는 0이 아니라 NULL 을 반환함.

# 집계 함수 관련된 문제 

# 1. 제품 테이블에서 모든 제품의 단가 평균을 검색해보자
SELECT * FROM 제품;
SELECT AVG(단가) FROM 제품;

# 2. 한빛제과에서 제조한 제품의 재고량 합계를 제품 테이블에서 검색해보자.
SELECT * FROM 제품;

SELECT * from 제품 where 제조업체 = '한빛제과';
SELECT SUM(재고량) AS `재고량합계` FROM 제품 WHERE  제조업체= '한빛제과';


# 3. 고객 테이블에 고객이 몇 명이 등록되어 있는지 검색해 보자.
SELECT * FROM 고객;
SELECT COUNT(*) AS `고객수` FROM 고객;

# 4. 제품 테이블에서 제조업체의 수를 검색해보자.
SELECT * FROM 제품;
SELECT COUNT(DISTINCT 제조업체) AS `제조업체 수` FROM 제품;

# GROUP BY

# 집계 함수는 조건에 맞는 그룹에 대한 통계를 냄

SELECT '영업부', AVG(salary) FROM tstaff WHERE depart='영업부';
# 부서별 월급 평균을 알고 싶으면 부서마다 avg 함수를 호출해야했음.



# GROUP BY 사용
# 기준이 되는 필드를 뒤에 적어주면 기준 필드가 같은 레코드를 모아 통계값을 구함.
# 게다가 기준 필드는 집계 함수와 같이 쓸 수 있어서 목록도 보기 좋게 출력할 수 있음.
SELECT depart, AVG(salary) FROM tstaff GROUP BY depart;
# 부서별 월급 평균을 구하려면 depart 필드를 기준으로 그룹핑
# 1) 기준 필드순으로 정렬하여 같은 그룹끼리 구분해 놓고
# 2) 통계 대상 필드를 순서대로 읽어 집계를 구함.
SELECT grade, AVG(salary) FROM tstaff GROUP BY grade;
# group by가 내부 구조로 보면 기준 필드로 order by로 한번 정렬하고 집계를 같은 그룹끼리 묶음
# group by 구문은 그룹핑을 해 줄 뿐이며 어떤 통계를 낼 것인 가는 필드 목록의 집계 함수에 따라 달라짐

# 1. 도시 목록에서 지역별 인구수를 구하라.
SELECT * FROM tcity;
SELECT region, SUM(popu) FROM tcity GROUP BY region;

# 2. 도시 목록에서 지역별 평균 면적을 구하라.
SELECT region, AVG(AREA) FROM tcity GROUP BY region;

SELECT region FROM tcity GROUP BY region;

# 3. 각 부서별 남자 직원의 평균 성취도를 조사하라.
SELECT * FROM tstaff;
SELECT * FROM tstaff WHERE gender='남';

SELECT depart ,AVG(score) FROM tstaff WHERE gender ='남' GROUP BY depart;

# 4. 직급별 여직원의 수를 조사하라.
SELECT * FROM tstaff WHERE gender= '여';
SELECT grade, COUNT(*) FROM tstaff WHERE gender = '여' GROUP BY grade;

SELECT grade FROM tstaff WHERE gender = '여' GROUP BY grade;

# 2. 기준 필드
# GROUP BY의 기준필드는 중복 값이 있을 때만 의미.
# 레코드별로 고유한 값을 가지는 필드는 그룹핑 기준으로 부적합하며(예 : 아이디), 구부닝나 분류 필드가 적합..
# 한 부서에서 여러 직원이 소속되어 있고 부서가 앝은 직원이 많기 때문에 부서별 집계가 가능.

# 성별도 중복값이여서 그룹핑 필드로 적합
SELECT gender, AVG(salary) FROM tstaff GROUP BY gender;

# 남녀 성별로 평균 월급을 구함.
SELECT NAME, SUM(salary) FROM tstaff GROUP BY NAME; # 중복이 없음
# 중복 값을 가지는 필드만 그룹핑의 기준이 되는 것은 아니며 임의의 필드를 기준으로 그룹핑 할 수 잇음.
#이름을 기준으로 그룹핑을 하는 것도 문법적으로 가능하지만 전 직원의 월급이 각각 출력이 되어 의미가 없음

# 이름을 기준으로 그룹핑을 하는 것도 문법적으로 가능하지만 전 직원의 월급이 각각 출력이 되어 의미가 없음

# group by는 

# 정렬은 depart 로 
SELECT depart, gender, COUNT(*) FROM tstaff GROUP BY depart, gender;
# 첫번째 그룹을 나누고 그 그룹 내에서 다시 두번째 기준으로 그룹을 나눔

# 위 아래는 순서만 다르지 결과는 동일함
SELECT gender, depart, COUNT(*) FROM tstaff GROUP BY gender, depart;

# group bt는 order by 와 같음 방식이 

SELECT depart, gender, COUNT(*) FROM tstaff GROUP BY depart, gender ORDER BY gender, depart;

# group by의 필드 목록
SELECT * FROM tstaff;
SELECT * FROM tstaff GROUP BY depart;
SELECT depart, salary FROM tstaff GROUP BY depart;
# group by는 집계함수를 사용하지 않으면  정렬한 것들중에 가장 위에꺼 한개만 들고온다

SELECT SUM(salary) FROM tstaff GROUP BY depart;
# 필드목록의 제일 처음에는 통상 기준 필드를 출력하여 어떤 그룹에 대한 통계인지 표시.
# 기준 필드를 빼고 집계 함수만으로 쿼리를 구성하면, 계산은 똑바로 뙜지만 각 행이
# 어떤 부서에 대한 통계치인지 알아 볼 수 없음.


SELECT depart, SUM(salary) FROM tstaff GROUP BY depart;	# 이렇게 하는게 맞다
SELECT SUM(salary) FROM tstaff;

# 종합 : SELECT 기준필드, 집계함수() FROM WHERE GROUP BY

# HAVING # GROUP BY 다음으로 옴

SELECT depart, AVG(salary) FROM tstaff GROUP BY depart;

# 위에서 이미 계산이 다 끝난 상태에서 출력할때 HAVING 으로 해당 조건에 맞는 필드만 출력함

SELECT depart, AVG(salary) FROM tstaff GROUP BY depart HAVING AVG(salary) >= 340;
# HAVING AVG(salary) >= 340; <-- 이건 결과값에는 영향이 x 출력 여부가 달라짐

SELECT depart, AVG(salary) FROM tstaff GROUP BY depart HAVING AVG(salary) >= 340 ORDER BY AVG(salary) DESC;

# 순서 중요
# WHERE 와 HAVING 은 조건을 적용하는 단계가 다름

SELECT depart, AVG(salary) FROM tstaff WHERE salary > 300 GROUP BY depart;
# 여기서 월급이 300 이상인것만 가져와서 평균을 구해서 값이 더 높게 나옴

# WHERE 절은 GROUP BY 앞에 나타나며 통계 대상 레코드의 조건을 제한.
# 월급 300 초과 조건에 의해 월급 300 이하의 직원은 평균에서 아예 제외되어 평균값이 더 높게 나타남.
# 만약 모든 직원의 월급이 300이하이면 이 부서는 아예 결과셋에 나타나지고 않음.

# HAVING 절은 GROUP BY 다음에 나타나며 집계한 결과셋의 조건을 제한.
# WHERE 와 HAVING 은 적용 시점과 제한 대상이 다름.

SELECT depart, AVG(salary) FROM tstaff WHERE salary > 300 GROUP BY depart HAVING AVG(salary) >= 360 ORDER BY depart;

# 위 로직을 설명할 줄 알아야 함.
# 월급이 300 초과인 직원들을 대상을 ㅗ부서별 평균 월급을 구하고 그 결과 평균 월급이 360 이상인 부서만 고른 후 부서명 으로 정렬

## SELECT ... FROM .. WHERE ... GROUP BY ... HAVING ... ORDER BY ... LIMIT 

# 차이점을 알아라.
SELECT depart, MAX(salary) FROM tstaff WHERE depart IN ('인사과','영업부') GROUP BY depart;
SELECT depart, MAX(salary) FROM tstaff GROUP BY depart HAVING depart IN ('인사과','영업부');
														# 현재 총무부 필드꺼도 포함해서 계산을함		
# 결과는 동일하지만 과정이 다름 결론은 밑에꺼가 비효율적임. 부하가 상대적으로 큰 방식

# 두 쿼리 모두 인사과와 영업부의 최대 월급을 조사.
# 조건을 적용하는 시점은 다르지만 조건의 내용은 같아 최종 실행 결과는 같음
# 하지만 내부적인 실행 과정은 차이가 있음.

# 1. WHERE 절은 집계전에 총무부를 제외하여 꼭 필요한 계싼만 함.
# 2. HAVING 절은 모든 부서의 집계를 다 끝낸 후 총무부를 제거하는 식이라 출력하지도 않을 총무부의 집계 까지 계산하여
# 서 비효울적임


# 서버가 느린경우 
# 서버의 처리량보다 요규랑이 높은 경우, 최적화가 안된 쿼리문실행

# 1. 각 지역에서 가장 큰 면적을 구하되 단 인구가 50만 이상인 도시만 대상으로 한다.
SELECT region, MAX(AREA) FROM tcity WHERE popu>=50 GROUP BY region;

# 2. 각 지역별 평균 면적을 구하되 평균 면적이 1000 이상인 지역만 출력하라.
SELECT * FROM tcity;
SELECT region, avg(AREA) AS avg_area FROM tcity WHERE AREA >=1000 GROUP BY region; #답은 어거지로 맞는데 사실 틀린 거임

# 아래꺼가 맞음 평균값 기준으로 조건을 걸어야 하는데 where 로는 집계함수 조건을 걸 수가 없다
SELECT region, avg(AREA) AS avg_area FROM tcity  GROUP BY region HAVING avg_area>=1000;


# ---- 숙제 
# 1. 주문 테이블에서 주문제품별 수량의 합계를 검색해보자
SELECT 주문제품, SUM(수량) AS `총주문수량` FROM 주문 group BY 주문제품;
SELECT * FROM 주문;

# 2. 제품 테이블에서 제조업체별로 제조한 제품의 개수와 제품 중 가장 비싼 단가를
#검색하되, 제품의 개수는 제품수라는 이름으로 출력하고 가장 비싼 단가는 최고가라는 이름으로 
# 출력해보자
SELECT * FROM 제품;
SELECT 제조업체, COUNT(*)  AS `제품수`, MAX(단가) AS `최고가` FROM 제품 group BY 제조업체;

# 3.
SELECT 제조업체, COUNT(*) AS `제품수`, MAX(단가) AS `최고가` FROM 제품 group BY 제조업체 HAVING 제품수 >=3;

SELECT * FROM 고객;
# 4.
SELECT 등급, COUNT(*) AS `고객수` , AVG(적립금) AS `평균적립금` FROM 고객 GROUP BY 등급 HAVING 평균적립금 >=1000;

# 5.
SELECT * FROM 주문;
SELECT 주문제품, 주문고객, SUM(수량) AS "평균적립금" FROM 주문 GROUP BY 주문제품,주문고객;

# 2024-02-06 데이터 추가/ 삭제 / 

# INSERT
# INSERT INTO 테이블 (필드목록) VALUES (값목록)
# INSERT INTO 가 함께 사용됨

# 마리아DB는 INTO 생략을 허용하지만 SQL 표준에는 INTO가 필수임. 생략하는 습관 ㄴㄴ

SELECT * FROM tcity;
INSERT INTO tcity (NAME,AREA,popu,metro,region) VALUES ('서울',605,974,'y','경기');
# PRIMIARY KEY로 설정된 NAME 필드는 NULL 허용 X, 중복 허용 X

# 특징
# 필드명을 일일히 순서에 맞춰야함
# 생략하는 방법 => 2가지 있다 , 필드를 지우고 5개의 VALUE 개수와 순서를 맞추면됨

INSERT INTO tcity VALUES ('평택',453,51,'n','경기');
INSERT INTO tcity VALUES ('서울',605,974,'y','경기');

# INSERT INTO 등 추가 삭제를 하면 아래에 영향 받은 행 로그를 잘봐야함(영향 받은 행이  있어야됨)
/* 영향 받은 행: 1  찾은 행: 0  경고: 0  지속 시간 1 쿼리: 0.016 초 */


# ERROR CASE 

# 1개를 빼먹음
INSERT INTO tcity VALUES ('평택2',453,'n','경기');
/* SQL 오류 (1136): Column count doesn't match value count at row 1 */

# 순서가 틀림(타입이 틀려짐)
INSERT INTO tcity VALUES ('평택2',453,'n',51,'경기');
/* SQL 오류 (1366): Incorrect integer value: 'n' for column `db_test`.`tcity`.`popu` at row 1 */


# 되긴하는데 값이 들어가야 할 위치가 달라서 틀린 값이 들어감
# 오류가 안떠서 이런건 주의가 필요함
INSERT INTO tcity VALUES ('평택2',51,453,'n','경기');
# area와 popu 순서가 바뀜

# INSERT INTO 시 필드목록은 생략가능하다.
# 필드목록을 밝히면 순서를 바꿀 수 있다.


SELECT * FROM tcity;
INSERT INTO tcity (AREA,popu,metro,region,NAME) VALUES (605,974,'y','경기','서울');
# 이렇게도 가능함 프라이머리 키는 맨 뒤에 있는게 국룩옵션

# 연습
# 1. 도시 목록에 용인을 삽입하라. 면적 293에 인구 97만이되 데이터는 임의 값을 써도 상관없다

INSERT INTO tcity (NAME, AREA, popu, metro, region) VALUES ('용인',293,98,'y','경기');

# 2. 직원 목록에 자신의 신상을 삽입해 보라.
SELECT * FROM tstaff;
INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score) VALUES ('오세빈','인사과','남','2024-02-06','대리',350,65);

# 현재 날짜는 now() 함수로도 할 수있다. 시간까지 구해주는데 날짜까지만 쓰니까 경고 뜨는거라 상관없다.
INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score) VALUES ('정약전','인사과','남',NOW(),'과장',420,74.6);
INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score) VALUES ('정약전','인사과','남',CURRENT_DATE(),'과장',420,74.6);

# 확장 INSERT 문
# tcity 테이블로 실습을 하다가 원래대로 초기화 하고 싶다면 다음 명령으로 테이블을 싹 비움.
TRUNCATE TABLE tcity;

# 각 행마다 개별적으로 INSERT INTO 명령을 일일히 작성하면 쿼리문이 길어 번잡스러움.
INSERT INTO tcity (NAME, AREA, popu, metro, region) VALUES
('서울',605,974,'y','경기'),
('부산',765,342,'y','경상'),
('오산',42,21,'n','경기'),
('청주',940,83,'n','충청'),
('전주',205,65,'n','전라'),
('순천',910,27,'n','전라'),
('춘천',1116,27,'n','강원'),
('홍천',1819,7,'n','강원');

# 대량의 데이터를 삽입할 때는 더 편함.
# 백업을 복구하는 경우  속도는 개별보다 느림  (각 데이터마다 insrt into ~~r가 더 빠름)
 
# 원래는 각 필드마다 INSERT INTO ~ 로 시작했음.
# MySql에서 최초 도입했고 왠만한 DBMS에서는 지원하지만, 표준 SQL 문법은 아니고 오라클에서도 지원하지는 않음.

# 데이터의 갯수가 대략 10만개가 넘어서면 확장 INSERT 문 속도가 느려서 그때부터는 추천안함

# 1. 도시 목록에 이천(461 킬로미터, 21만)과 대구 (883 킬로미터, 248만), 영월 (1127킬로미터, 4만)을 삽입하라
SELECT * FROM tcity;

INSERT INTO tcity (NAME, AREA, popu, metro, region) VALUES
('대구',883,248,'y','경상'),
('영월',1127,4,'n','강원');


# 문제09.

# 1. 
SELECT * FROM 고객;
INSERT INTO 고객 (고객아이디,고객이름,나이,등급,직업,적립금) VALUES 
('strawberry','최유경',30,'vip','공무원',100);

# 2.
#
SELECT * FROM 고객;
INSERT INTO 고객 (고객아이디,고객이름,나이,등급,적립금) VALUES 
('tomaro','정은심',36,'gold',4000);

# INSERT SELECT

# INSERT 명령은 한번에 하나의 레코드만 삽입하지만, 다른 테이블 또는 자기 자신에게 이미 저장되어 있는 대량의 정보를 복사할 때는
# 조사한 결과셋을 한꺼번에 삽입할 수 있음.

# 기본형 : INSERT INTO 대상테이블 (필드목록) SELECT 필드목록 FROM 원본테이블

INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score)
SELECT NAME, region, metro, '20210629', '신입', AREA, popu FROM tcity WHERE region = '경기';

# 필드 명의 숫자, 데이터 타입이 맞아야됨

# CREATE SELECT

CREATE TABLE tSudo AS SELECT name, AREA, popu FROM tcity WHERE region ='경기';
# 경기도 지역의 도시만으로 tSudo 테이블을 생성.
tsudoSELECT * FROM tsudo;


# tstaff 테이블에 대량의 변경을 가해야 하는데 불안할 경우 다음 명렁으로 복사를 뜸.
CREATE TABLE tstaff_backup_20240206 AS SELECT * FROM tstaff;
# 대게 백업을 해서 그 백업본으로 테스트 하는 경우가 있음
# 백업은 여러번 뜰 수 있어서 관행상 날짜를 명시.
# 혹시 잘못 조작해서 데이터가 의도와 다르게 손상이 되었으면 백업에서 데이터를 가져오고,
# 이상이 없으면 적당한 때에 백업을 삭제하면 됨.
# 백업본 특징이 기본키 속성은 가지고 오지 못함.


# 연습 문제
# 1. 성취도가 80점 이상인 직원만 골라 이름과 월급에 대한 보고서를 별도의 테이블로 작성하라.
SELECT * FROM tstaff;

CREATE TABLE tstaff_backup_20240206_2 AS SELECT NAME,salary FROM tstaff WHERE score>=80;


# DELETE
# 레코드를 삭제할 때 사용.

# delete와 update는 잘못하면 복구 불가능하다. 

# DELETE FROM 테이블 WHERE 조건
# 삭제 동작은 특정 조건에 맞는 레코드를 찾아 제거라는 경우가 대부분 이어서 WHERE 절이 항상 뒤따라 옴

# 도시명이 '부산'인 레코드를 삭제.
DELETE FROM tcity WHERE NAME = '부산';

# 도시명이 '경기'인 레코드를 삭제
DELETE FROM tcity WHERE region = '경기';

# 여기서 설명이 잘못되어서 경기도가 아닌 전라도였다면 방법이 없다.
# 미리 백업을 해놨다면 다시 복구는 가능하다..
# insert into 로 다시 만들 수 있는데 갯수가 늘어남에 따라 힘들다.

# 문제
# 1. 영업부 직원을 전부 해고 시켜 보자.

CREATE TABLE tstaff_backup_20240206_3 AS SELECT * FROM tstaff;

DELETE FROM tstaff WHERE depart ='영업부';

# 삭제 안전 장치

# 삭제시 문제가 되는 부분은 
# 1) 조건절을 뺴거나 2) 잘못된 조건을 사용하는 경우
# select 문제없음
# insert 다시 지우면 됨 
# DELETE 명령은 치명적. 명령 즉시 처리해 버림.
# 

# case 1
# where 문을 안적고 실행하면 경고문이 뜸 # 하이디SQL 기준
DELETE FROM tcity;

# case 2 조건절을 잘못 지정하는 경우
# DELETE 명령을 내리기 전에 먼저 SELECT 로 삭제 대상 레코드를 고름
# 인구수가 50만 초과인 도시를 삭제할려고한다면?
SELECT * FROM tcity WHERE popu > 50;

# 조건이 맞는지 확인 후 제거한다.
DELETE * FROM tcity WHERE popu > 50;

# delete와 가장 유사한 문장 구조를 가진게 select 이기 떄문에 먼저
# select 로 뭐가 삭제가 될지 문법이 맞는지 검증하고 
# DELETE 를 실행한다.


# 3. TRUNCATE

# WHERE 절이 없는 DELETE 명령은 상당히 위험하지만 테이블을 비울 목적이라면 사용 가능.
#

# TRUNCATE TABLE 테이블

# 이 명령은 테이블을 완전히 비움
# 물리적인 기억 장소를 깨끗이 비우고 임시 영역에 로그도 남기지 않아 훨씬 빠름.
# DELETE 는 삭제하면서 로그도 남기는 등 부하가 걸리는데 TRUNCATE는 로그도 없이 날려서 빠름

# WHERE 을 안쓰고 완전히 지울떄는 이거 쓰는 편이 좋다.
TRUNCATE TABLE tcity;

# 클라이언트가 웹 특정부분에서 느리다고 하면 slowly query log 를 이용해 테스트 하면됨
# 내가 짠 쿼리문이 잘못되었는지 테스트 할때 log을 봐야할떄 사용함.

# UPDATE
# UPDATE 도 DELETE 만큼 위험하다.
# 레코드의 필드 값을 변경할 때 사용.
# 대입문으로 테이블의 필드 값을 임의대로 변경.

# UPDATE 테이블 SET 필드 = 값 [, 필드 = 값] WHERE 조건

# UPDATE 키워드 다음에 변경 대상 테이블을 지정. 1대1로 됨
# SET 키워드 다음에 필드에 값을 대입하는 대입문이 오며 콤마로 끊어 복수 개의 필드를 한꺼번에 변경.
# WHERE 절에는 변경 대상 레코드를 지정하는 조건문을 작성.

# 조건문을 생략하면 모든 레코드가 갱신되는데 이런 경우는 흔하지 않음.
# 조건에 맞는 특정 레코드를 찾아 변경하는 것이 일반적이므로 UPDATE 문도 DELETE 문과 마찬가지도
# 통상 WHERE 절과 함께 사용.

UPDATE tcity SET popu = 1000, region = '충정' WHERE NAME ='서울';
# 서울의 인구를 1000만명으로, 지역을 충청도로 변경.
# 갱신 후 스크립트 창에 1행이 업데이트 메시지 출력이 됨.


UPDATE tcity SET popu = 1000, region = '충청';
# 이거 실행하면 모든 레코드가 인구수는 1000만 지역은 충청으로 다 수정된다.

UPDATE tcity SET popu = popu*2 WHERE NAME ='오산';
# popu의 원래 값을 읽어 그 두 배 값을 다시 popu에 대입하여 오산의인구를 두 배로 늘림.
# SET 문에는 보통 필드에 상수를 대입하는데 필드끼리 연산도 가능.

# 문제
# 1. 여자 사원급을 모두 대리로 진급시켜라
SELECT * FROM tstaff;

UPDATE tstaff SET grade='대리' WHERE gender='여' AND grade='사원';

# 2. 영업부 직원의 월급을 10% 인상하라.

select * from tstaff_backup_20240206;

UPDATE tstaff_backup_20240206 SET salary= salary*1.1 WHERE depart='영업부';


# 문제 10 데이터 수정
#1. 
SELECT * FROM 제품;
SELECT 제품명  FROM 제품 where 제품번호='p03';
UPDATE 제품 SET 제품명='통큰파이' WHERE 제품번호='p03';

#2.
SELECT 단가, 단가*1.1 FROM 제품;
UPDATE 제품 SET 단가=단가*1.1;
SELECT * FROM 제품;

#3.
SELECT * FROM 주문;
SHOW TABLES;
SELECT * FROM 고객;

# Case1
SELECT *  FROM 고객 WHERE 고객이름='정소화';

# 주문한 제품은 apple

UPDATE 주문 SET 수량= 5 WHERE 주문고객='apple';

# case2
UPDATE 주문 set 수량 = 5 WHERE 주문고객 IN(SELECT 고객아이디 FROM
고객 WHERE 고객이름 ='정소화');


# DELETE 문제 11
#1 
SELECT * FROM 주문 WHERE 주문일자='2019-05-22';

DELETE * FROM 주문 WHERE 주문일자 = '2019-05-22';

CREATE SCHEMA TestDB;
CREATE TABLE  `employees` (
  `EmployeeID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ;
CREATE TABLE  `exampletable` (
  `Column1` int(11) DEFAULT NULL,
  `Column2` varchar(50) DEFAULT NULL,
  `Column3` date DEFAULT NULL
) ;
CREATE TABLE  `pokemon` (
  `PokemonID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Type` varchar(20) NOT NULL,
  `Level` int(11) DEFAULT NULL,
  `EvolutionStage` varchar(20) DEFAULT NULL,
  `TrainerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PokemonID`),
  KEY `fk_trainer` (`TrainerID`),
  CONSTRAINT `fk_trainer` FOREIGN KEY (`TrainerID`) REFERENCES `trainer` (`TrainerID`)
) ;
CREATE TABLE  `tcity` (
  `NAME` char(10) NOT NULL,
  `area` int(11) DEFAULT NULL,
  `popu` int(11) DEFAULT NULL,
  `metro` char(1) NOT NULL,
  `region` char(6) NOT NULL,
  PRIMARY KEY (`NAME`)
) ;

INSERT INTO `tcity` (`NAME`, `area`, `popu`, `metro`, `region`) VALUES
	('부산', 765, 342, 'y', '경상'),
	('서울', 605, 974, 'y', '경기'),
	('순천', 910, 27, 'n', '전라'),
	('오산', 42, 21, 'n', '경기'),
	('전주', 205, 65, 'n', '전라'),
	('청주', 940, 83, 'n', '충청'),
	('춘천', 1116, 27, 'n', '강원'),
	('홍천', 1819, 7, 'n', '강원');
	
	CREATE TABLE  `trainer` (
  `TrainerID` int(11) NOT NULL AUTO_INCREMENT,
  `TrainerName` varchar(50) NOT NULL,
  PRIMARY KEY (`TrainerID`)
) ;
INSERT INTO `trainer` (`TrainerID`, `TrainerName`) VALUES
	(1, 'Ash Ketchum'),
	(2, 'Misty'),
	(3, 'Brock');

CREATE TABLE  `tstaff` (
  `NAME` char(15) NOT NULL,
  `depart` char(10) NOT NULL,
  `gender` char(3) NOT NULL,
  `joindate` date NOT NULL,
  `grade` char(10) NOT NULL,
  `salary` int(11) NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`NAME`)
) ;

INSERT INTO `tstaff` (`NAME`, `depart`, `gender`, `joindate`, `grade`, `salary`, `score`) VALUES
	('강감찬', '영업부', '남', '2018-10-09', '사원', 320, 56.00),
	('김유신', '총무부', '남', '2000-02-03', '이사', 420, 88.80),
	('논개', '인사과', '여', '2010-09-16', '대리', 340, 46.20),
	('대조영', '총무부', '남', '2020-07-07', '차장', 290, 49.90),
	('선덕여왕', '인사과', '여', '2017-08-03', '사원', 315, 45.10),
	('성삼문', '영업부', '남', '2014-06-08', '대리', 285, 87.75),
	('신사임당', '영업부', '여', '2013-06-19', '부장', 400, 92.00),
	('안중근', '인사과', '남', '2012-05-05', '대리', 256, 76.50),
	('안창호', '영업부', '남', '2015-08-15', '사원', 370, 74.20),
	('유관순', '영업부', '여', '2009-03-01', '과장', 380, NULL),
	('윤봉길', '영업부', '남', '2015-08-15', '과장', 350, 71.25),
	('을지문덕', '영업부', '남', '2019-06-29', '사원', 330, NULL),
	('이사부', '총무부', '남', '2000-02-03', '대리', 375, 50.00),
	('이율곡', '총무부', '남', '2016-03-08', '과장', 385, 65.40),
	('장보고', '인사과', '남', '2005-04-01', '부장', 440, 58.30),
	('정몽주', '총무부', '남', '2010-09-16', '대리', 370, 89.50),
	('정약용', '총무부', '남', '2020-03-14', '과장', 380, 69.80),
	('허난설헌', '인사과', '여', '2020-01-05', '사원', 285, 44.50),
	('홍길동', '인사과', '남', '2019-08-08', '차장', 380, 77.70),
	('황진이', '인사과', '여', '2012-05-05', '사원', 275, 52.50);
	
	CREATE TABLE  `고객` (
  `고객아이디` varchar(20) NOT NULL,
  `고객이름` varchar(10) NOT NULL,
  `나이` int(11) DEFAULT NULL,
  `등급` varchar(10) NOT NULL,
  `직업` varchar(20) DEFAULT NULL,
  `적립금` int(11) DEFAULT 0,
  PRIMARY KEY (`고객아이디`)
) ;
INSERT INTO `고객` (`고객아이디`, `고객이름`, `나이`, `등급`, `직업`, `적립금`) VALUES
	('apple', '정소화', 20, 'gold', '학생', 1000),
	('banana', '김선우', 25, 'vip', '간호사', 2500),
	('carrot', '고명석', 28, 'gold', '교사', 4500),
	('melon', '성원용', 35, 'gold', '회사원', 5000),
	('orange', '김용욱', 22, 'silver', '학생', 0),
	('peach', '오형준', NULL, 'silver', '의사', 300),
	('pear', '채광주', 31, 'silver', '회사원', 500);
	CREATE TABLE  `제품` (
  `제품번호` char(3) NOT NULL,
  `제품명` varchar(20) DEFAULT NULL,
  `재고량` int(11) DEFAULT NULL,
  `단가` int(11) DEFAULT NULL,
  `제조업체` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`제품번호`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`재고량` >= 0 and `재고량` <= 10000)
) ;


INSERT INTO `제품` (`제품번호`, `제품명`, `재고량`, `단가`, `제조업체`) VALUES
	('p01', '그냥만두', 5000, 4500, '대한식품'),
	('p02', '매운쫄면', 2500, 5500, '민국푸드'),
	('p03', '쿵떡파이', 3600, 2600, '한빛제과'),
	('p04', '맛난초콜릿', 1250, 2500, '한빛제과'),
	('p05', '얼큰라면', 2200, 1200, '대한식품'),
	('p06', '통통우동', 1000, 1550, '민국푸드'),
	('p07', '달콤비스킷', 1650, 1500, '한빛제과');
	CREATE TABLE  `주문` (
  `주문번호` char(3) NOT NULL,
  `주문고객` varchar(20) DEFAULT NULL,
  `주문제품` char(3) DEFAULT NULL,
  `수량` int(11) DEFAULT NULL,
  `배송지` varchar(30) DEFAULT NULL,
  `주문일자` date DEFAULT NULL,
  PRIMARY KEY (`주문번호`),
  KEY `주문고객` (`주문고객`),
  KEY `주문제품` (`주문제품`),
  CONSTRAINT `주문_ibfk_1` FOREIGN KEY (`주문고객`) REFERENCES `고객` (`고객아이디`),
  CONSTRAINT `주문_ibfk_2` FOREIGN KEY (`주문제품`) REFERENCES `제품` (`제품번호`)
) ;

INSERT INTO `주문` (`주문번호`, `주문고객`, `주문제품`, `수량`, `배송지`, `주문일자`) VALUES
	('o01', 'apple', 'p03', 10, '서울시 마포구', '2019-01-01'),
	('o02', 'melon', 'p01', 5, '인천시 계양구', '2019-01-10'),
	('o03', 'banana', 'p06', 45, '경기도 부천시', '2019-01-11'),
	('o04', 'carrot', 'p02', 8, '부산시 금정구', '2019-02-01'),
	('o05', 'melon', 'p06', 36, '경기도 용인시', '2019-02-20'),
	('o06', 'banana', 'p01', 19, '충청북도 보은군', '2019-03-02'),
	('o07', 'apple', 'p03', 22, '서울시 영등포구', '2019-03-15'),
	('o08', 'pear', 'p02', 50, '강원도 춘천시', '2019-04-10'),
	('o09', 'banana', 'p04', 15, '전라남도 목포시', '2019-04-11'),
	('o10', 'carrot', 'p03', 20, '경기도 안양시', '2019-05-22');
	