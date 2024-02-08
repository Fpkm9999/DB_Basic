-- 테이블 생성
CREATE TABLE tcity (
NAME CHAR(10) PRIMARY KEY,
area INT NULL,
popu INT NULL,
metro CHAR(1) NOT NULL,
region CHAR(6) NOT NULL
);
	
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Salary INT
);

CREATE TABLE tstaff (
NAME CHAR (15) PRIMARY KEY,
depart CHAR (10) NOT NULL,
gender CHAR (3) NOT NULL,
joindate DATE NOT NULL,
grade CHAR (10) NOT NULL,
salary INT NOT NULL,
score DECIMAL(5,2) NULL	
);
INSERT INTO tcity VALUES ('서울',605,974,'y','경기');
INSERT INTO tcity VALUES ('부산',765,342,'y','경상');
INSERT INTO tcity VALUES ('오산',42,21,'n','경기');
INSERT INTO tcity VALUES ('청주',940,83,'n','충청');
INSERT INTO tcity VALUES ('전주',205,65,'n','전라');
INSERT INTO tcity VALUES ('순천',910,27,'n','전라');
INSERT INTO tcity VALUES ('춘천',1116,27,'n','강원');
INSERT INTO tcity VALUES ('홍천',1819,7,'n','강원');

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
