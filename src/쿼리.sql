
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
	