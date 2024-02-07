## 2024-02-07
# 서브 쿼리
# 쿼리 문 안에 쿼리문이 포함된 구문

CREATE TABLE tEmployee
(
     name CHAR(10) PRIMARY KEY,
     salary INT NOT NULL,
     addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES ('김상형', 650, '이천시');
INSERT INTO tEmployee VALUES ('문종민', 480, '대구시');
INSERT INTO tEmployee VALUES ('권성직', 625, '안동시');

CREATE TABLE tProject
(
     projectID INT PRIMARY KEY,
     employee CHAR(10) NOT NULL,
     project VARCHAR(30) NOT NULL,
     cost INT
);

INSERT INTO tProject VALUES (1, '김상형', '홍콩 수출건', 800);
INSERT INTO tProject VALUES (2, '김상형', 'TV 광고건', 3400);
INSERT INTO tProject VALUES (3, '김상형', '매출분석건', 200);
INSERT INTO tProject VALUES (4, '문종민', '경영 혁신안 작성', 120);
INSERT INTO tProject VALUES (5, '문종민', '대리점 계획', 85);
INSERT INTO tProject VALUES (6, '권성직', '노조 협상건', 24);

INSERT INTO tProject VALUES (7, '홍길동', '원자재 매입', 900);

-- 회원 테이블
CREATE TABLE tMember
(
    member VARCHAR(20) PRIMARY KEY,      -- 아이디
    age INT NOT NULL,                           -- 나이
    email VARCHAR(30) NOT NULL,                -- 이메일
    addr VARCHAR(50) NOT NULL,                 -- 주소
    money INT DEFAULT 1000 NOT NULL,          -- 예치금
    grade INT DEFAULT 1 NOT NULL,              -- 고객등급. 1=준회원, 2=정회원, 3=우수회원
    remark VARCHAR(100) NULL                  -- 메모 사항
);

-- 회원 데이터
INSERT INTO tMember VALUES ('춘향',16,'1004@naver.com','전남 남원시',20000, 2, '');
INSERT INTO tMember VALUES ('이도령',18,'wolf@gmail.com','서울 신사동',150000, 3, '');
INSERT INTO tMember VALUES ('향단',25,'candy@daum.net','전남 남원시',5000, 2, '');
INSERT INTO tMember VALUES ('방자',28,'devlin@ssang.co.kr','서울 개포동',1000, 1, '요주의 고객');

-- 상품 분류 테이블
CREATE TABLE tCategory
(
   category VARCHAR(10) PRIMARY KEY,     -- 분류명
   discount INT NOT NULL,               -- 할인율
   delivery INT NOT NULL,                        -- 배송비
   takeback CHAR(1)                              -- 반품 가능성
);

-- 분류 데이터
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('식품', 0, 3000, 'n');
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('패션', 10, 2000, 'y');
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('가전', 20, 2500, 'y');
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('성인', 5, 1000, 'n');


-- 상품 테이블
CREATE TABLE tItem
(
    item VARCHAR(20) PRIMARY KEY,        -- 상품명
    company VARCHAR(20) NULL,                 -- 제조사
    num INT NOT NULL,                           -- 재고
    price INT NOT NULL,                          -- 정가
    category VARCHAR(10) NOT NULL,            -- 분류
    CONSTRAINT item_fk FOREIGN KEY(category) REFERENCES tCategory(category)
);

-- 상품 데이터
INSERT INTO tItem (item,company,num,price,category) VALUES ('노트북', '샘성', 3, 820000, '가전');
INSERT INTO tItem (item,company,num,price,category) VALUES ('청바지', '방방', 80, 32000, '패션');
INSERT INTO tItem (item,company,num,price,category) VALUES ('사과', '문경농원', 24, 16000, '식품');
INSERT INTO tItem (item,company,num,price,category) VALUES ('대추', '보은농원', 19, 15000, '식품');
INSERT INTO tItem (item,company,num,price,category) VALUES ('전자담배', 'TNG', 4, 70000, '성인');
INSERT INTO tItem (item,company,num,price,category) VALUES ('마우스', '논리텍', 3, 90000, '가전');

CREATE TABLE tOrder
(
  orderID INT AUTO_INCREMENT PRIMARY KEY,     -- 주문 번호
  member VARCHAR(20) NOT NULL,             -- 주문자
  item VARCHAR(20) NOT NULL,               -- 상품
  orderDate DATE DEFAULT CURDATE() NOT NULL,     -- 주문 날자
  num INT NOT NULL,                    -- 개수
  status INT DEFAULT 1 NOT NULL,               -- 1:주문, 2:배송중, 3:배송완료, 4:반품
  remark VARCHAR(1000) NULL               -- 메모 사항
);


-- 주문 데이터
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('춘향','청바지','2019-12-3',3,2);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('향단','대추','2019-12-4',10,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('방자','전자담배','2019-12-2',4,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('향단','사과','2019-12-5',5,2);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('흥부','노트북','2019-12-5',2,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('방자','핸드폰','2019-11-1',1,3);

# 서브 쿼리(SubQuery)는 '쿼리문 안에 또 다른 쿼리문이 포함된 구문'.
# 단발적인 질문이 아닌 '복합적이고 단계적인 질문을 할 때는 여러 개의 쿼리를 중첩해서 사용.'

# SQL문을 실행할 때, 추가로 필요한 데이터를 조회할 때 사용합니다. 

# 보통은 WHERE문에서 사용되지만, FROM, SELECT문 등에서도 사용이 가능합니다.

# 사용방법

# SELECT 열
# FROM 테이블
# WHERE 조건식 (SELECT 열 FROM 테이블 WHERE 조건식);

# 리턴하는 행과 열의 개수에 따라 다음과 같이 분류.
# - 단일행 서브쿼리 : 하나의 값만 리턴
# - 다중행 서브쿼리 : 여러개의 행을 리턴
# - 다중행렬 서브쿼리 : 여러개의 열로 구성된 여러 개의 행인 테이블을 리턴

# 또 외부쿼리와의 관계에 따라 독립 서브쿼리와 연관 서브쿼리로도 구분.
# 서브 쿼리부터는 난이도가 올라간다.



# 우리의 목적은 SQL 문장을 코드에 넣는게 목적

# case1. 단일행 서브쿼리

# SELECT 명령은 DB 엔진에게 정보를 요구하는 질문.
# SELECT로 할 수 있는 질문은 아주 짧은 단문만 가능하면 FROM 절이 하나밖에 없어 한 테이블에있는 정보만 조사할 수 있었음.

# 하지만 실제 작업을 할 때는 복잡한 여러 단계의 질문을 한꺼번에 하는 경우가 많이 생김.

# DB에서도 복잡한 쿼리를 실행할 수있으며 그 방법이 서브쿼리.

# e.g) 집계합수에서 다룬 최대 인구수를 가진 도시를 구하는 문제를 다시 풀어 보자면.
SELECT MAX(popu), name FROM tcity;


# 기계가 이 명령을 알아 들으려면 문법적으로 가능한 질문을 순서대로 해야함.
SELECT MAX(popu) FROM tcity; # 전체 도시 인구중 가장 큰 값을 조사
# 도시 목록 전체를 하나의 그룹으로 보고 그 중 최대값을 찾았으니 문법적으로 타당하며 974의 결과를 리턴.
# 최대 인구수를 알았으니 이제 이 인구수를 가진 도시를 찾음
SELECT NAME FROM tcity WHERE popu = 974; # 결과는 서울
# 최대 인구수를 조사하고 이 수로부터 도시의 이름글 구해야 하니 두 번의 쿼리가 필요함.
# 목적은 달성했지만 사람이 첫 번째 쿼리의 결과를 확인한 후 두 번쨰 쿼리의 조건문을 직접 기입하는 식이라 불편한.
# 


# 이 둘을 묶어 주는게 서브쿼리

# 서브쿼리로 하면.
SELECT NAME FROM tcity WHERE popu = (SELECT MAX(popu) FROM tcity);
# 괄호로 묶는 이유 : 괄호안에 있는 문장부터 먼저 실행해서 974를 구하고 쿼리문을 실행하도록 하기 위함

# 한번에 서울을 구함 DB 엔진은 괄호 안의 서브 쿼리를 먼저 실행하여 최대 인구수를 구함.
#

SELECT MAX(num) FROM titem; # titem 테이블의 num 필드 중 최대값은 80.
# 이제 이 최대량으로 부터 num 필드가 80개인 상품을 조사.
SELECT item FROM titem WHERE num = 80;
# 결과는 청바지
# 두 결과를 하나로 합칩
# 최대 재고량이 80인 자리에 이 값을 조사하는 서브 쿼리를 작성하여 두 쿼리를 하나로 합침.
SELECT * FROM titem;

SELECT item FROM titem WHERE num = (SELECT max(num) FROM titem);
# 결과 : 청바지

# 단일행 서브쿼리는 쉬운편임.

# 문제
# 1. tstaff 에서 성취도가 제일 높은 직원을 조사하라.
SELECT MAX(score) FROM tstaff;

SELECT NAME FROM tstaff WHERE score=92;

SELECT NAME,salary FROM tstaff WHERE score = (SELECT MAX(score) FROM tstaff);

# 2. tstaff 에서 평균 이상의 월급을 받는 직원 목록을 출력하라.
SELECT AVG(salary) FROM tstaff;
SELECT name FROM tstaff WHERE salary >= 347.3;
SELECT NAME,salary FROM tstaff WHERE salary >= (SELECT AVG(salary) FROM tstaff);

# 3. tEmployee 와 tProject에서 노조 협상건을 맡은 직원의 이름과 월급을 구하라.
SELECT * FROM temployee;
SELECT * FROM tproject;
SELECT employee FROM tproject WHERE project='노조 협상건';
SELECT NAME, salary FROM temployee WHERE NAME  ='권성직';

SELECT NAME, salary FROM temployee WHERE NAME =(SELECT employee FROM tproject WHERE project='노조 협상건');

# 4. tMember에서 나이가 가장 많은 회원의 이름과 주소를 조사하라.
SELECT * FROM tmember;
SELECT MAX(age) FROM tmember;
SELECT member,addr FROM tmember WHERE age = 28;
SELECT MEMBER,addr from tmember WHERE age = (SELECT MAX(age) FROM tmember);




# 시험 준비 

CREATE TABLE Book (
bookId INT PRIMARY KEY,
bookName VARCHAR(40),
publisher VARCHAR(40),
price INT
);

CREATE TABLE Customer (
customerId INT PRIMARY KEY,
name VARCHAR(40),
address VARCHAR(50),
phone VARCHAR(20)
);

CREATE TABLE Orders (
orderId INT PRIMARY KEY,
customerId INT REFERENCES Customer(customerId),
bookId INT REFERENCES Book(bookId),
salePrice INT,
orderDate DATE
);

-- Book, Customer, Orders 데이터 생성
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구 아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '배구 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);


INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스터', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO Customer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, '2024-07-01');
INSERT INTO Orders VALUES (2, 1, 3, 21000, '2024-07-03');
INSERT INTO Orders VALUES (3, 2, 5, 8000, '2024-07-03');
INSERT INTO Orders VALUES (4, 3, 6, 6000, '2024-07-04');
INSERT INTO Orders VALUES (5, 4, 7, 20000, '2024-07-05');
INSERT INTO Orders VALUES (6, 1, 2, 12000, '2024-07-07');
INSERT INTO Orders VALUES (7, 4, 8, 13000, '2024-07-07');
INSERT INTO Orders VALUES (8, 3, 10, 12000, '2024-07-08');
INSERT INTO Orders VALUES (9, 2, 10, 7000, '2024-07-09');
INSERT INTO Orders VALUES (10, 3, 8, 13000, '2024-07-10');


### 2. 서브쿼리 중첩 ###

# 서브쿼리는 독립적인 하나의 명령이기 때문에 외부쿼리와는 '다른 테이블을 읽을 수도 있음'.
# 어짜피 순차적으로 실행되므로 '두 쿼ㅣ리문의 FROM 절에 각각 다른 테이블을 지정해도 상관이 없음'.

# 그래서 더 복잡한 형태의 질문도 가능
# 청바지 배송비가 얼마인지 조사
# 청바지는 상품 테이블 titem 에 있지만 배송비는 유형 테이블 tcategory 에 있어서 두 테이블을 읽어야함.
# 먼저 titem 테이블에서 청바지는 어떤 유형의 카테고리인지 조사

SELECT * FROM titem; # 여기서 청바지의 카테고리를 조사
SELECT * FROM tcategory; # 카테고리에 맞는 배송비를 조사

SELECT category FROM titem WHERE item = '청바지'; # 패션
# 청바지는 '패션' 유형
# 다음은 패션 유형의 배송지를 조사
# tcategory 테이블에서 앞 쿼리의 결과로 나온 '패션' 유형의 배송비를 조사.
SELECT delivery FROM tcategory WHERE category ='패션'; # 배송비는 2000원임

# DB엔진이 서브쿼리를 먼저 실행하고 그 결과를 외부쿼리에 쓰듯이 사고의 흐름 순서대로 명령문을 하나씩 작성하면 됨.
# 이 질문을 말로 표현해 보면 '청바지의 유형을 조사하고 그유형의 배송비를 출력하라'임

# 7만원짜리 상품을 구입한 사람의 나이를 조사하라.
SELECT * FROM tcategory;
SELECT * FROM titem;
# 7만원 짜리 상품을 조회 하고 titem << 전자담배가 7만원짜리 상품임

SELECT item FROM titem WHERE price = 70000; # 7만원 짜리 상품을 파악
# 잘 구해진거같으면 괄호로 묶고 문장을 써도 된다.
SELECT MEMBER FROM torder WHERE item = 
(SELECT item FROM titem WHERE price = 70000); # 전자담배를 구매한 사람의 이름을 조사.

SELECT age FROM tmember WHERE MEMBER = 
( SELECT MEMBER FROM torder WHERE item = 
(SELECT item FROM titem WHERE price = 70000)); # 방자라는 사람의 나이를 조사.

# 지금까지 단일행이라 문제가 없었는데 혹시나 상품이 여러 개이거나 구입한 사람이 둘 이상이라면 에러 처리가 되는데
# 이떄는 TOP 1 (LIMIT 1) 을 넣어 첫 구입자를 찾으면 됨.


# 문제
# 1. 대추를 구입한 회원의 이름과 이 회원의 예치금을 구하라.
SELECT MEMBER, money FROM tmember WHERE MEMBER =
(SELECT member FROM torder WHERE item='대추');
# 2. 춘향이가 구입한 상품의 가격을 조사하라
SELECT price FROM titem WHERE item = 
(SELECT item FROM torder WHERE MEMBER =
(SELECT member FROM tmember WHERE MEMBER ='춘향'));
# 3. 배송비가 2000원인 상품을 구매한 회원의 주소를 조사하라.

SELECT MEMBER,addr FROM tmember WHERE MEMBER = 
(SELECT member FROM torder WHERE item = 
(SELECT item FROM titem WHERE category = 
(SELECT category FROM tcategory WHERE delivery = 2000)));
# 4. 배송비가 3000원인 상품을 구매한 회원의 주소 하나를 조사하라.
SELECT MEMBER,addr FROM tmember WHERE MEMBER =
(SELECT member FROM torder WHERE item = 
(SELECT item FROM titem WHERE category =
(SELECT category FROM tcategory WHERE delivery = 3000) LIMIT 0,1));

### 3. 다중행 서브쿼리
# 서브쿼리의 '결과가 하나뿐인 유형'을 단일행 서브쿼리
# 단일값이므로 조건절에서 =, <, > 등의 비교 연산자와 함께 사용할 수 있음.
# 비교 연산자는 필드의 값과 비교하는 것이어서 '우변이 반드시 하나의 확정된 값'이어야함

# 이에 비해 여러 개의 결과를 리턴하는 것이 다중행 서브쿼리.
# 단일값이 아닌 목록을 리턴하기 때문에 값끼리 비교하는 비교 연산자와 함께 사용할 수 없음.

SELECT price FROM titem WHERE item = 
(SELECT item FROM torder WHERE MEMBER = '향단');
# 서브쿼리는 구입목록인 tOrder 테이블에서 향단이가 뭘 샀는지 조사.
# 안쪽 서브쿼리만 실행해 보면 향단이가 산 것은 대추와 사과 2개.
# = 연산자는 필드 값 두 개의 결과를 비교할 수 없어 다음 에러를 출력.

/* SQL 오류 (1242): Subquery returns more than 1 row */

# 해결방법1 LIMIT 사용
# LIMIT 를 이용해 서브 쿼리의 결과값을 하나만 가지고 오도록 하면 됨.


SELECT item, price FROM titem WHERE item = 
(SELECT item FROM torder WHERE MEMBER = '향단' 
ORDER BY item LIMIT 0,1);

# 해결방법2 IN 연산자사용(=연산자 대신)

SELECT item, price FROM titem WHERE item IN
(SELECT item FROM torder WHERE MEMBER = '향단');
# 이 방법은 하나만 조사하는 것이 아닌 여러 개의 값을 알고 싶을 떄 사용

# = 연산자의 경우 결과값에 따라 에러가 뜰 수 있는데
# in 연산자를 이용할 경우 결과값에 관계없이 에러에 대응을 할 수 있음.

### 4. 다중열 서브쿼리

# 단일행, 다중행 서브쿼리는 '결과셋의 컬럼이 하나' 밖에 없으며 그래서 특정값과 비교할 수 있음.
# 이에 비해 다중열 서브쿼리는 결과셋의 컬럼이 여러 개이며 한꺼번에 여러 값과 비교.
# 오라클과 마리아 디비는 다중열 서브쿼리를 잘 지원하지만 SQL Server는 아직 지원하지 않음.


SELECT depart, gender FROM tstaff WHERE NAME ='윤봉길'; # 영업부 , 남

SELECT * FROM tstaff WHERE depart ='영업부' AND gender = '남';

# 
SELECT * FROM tstaff where  depart =
(SELECT depart FROM tstaff WHERE NAME = '윤봉길')
AND gender = 
(SELECT gender FROM tstaff WHERE NAME = '윤봉길');

# 다중열 서브쿼리로 하면							# 아래의 경우 단일 행이라 가능한거임
SELECT * FROM tstaff WHERE (depart, gender) =
(SELECT depart, gender FROM tstaff WHERE NAME = '안중근');
# WHERE 절에 비교 대상 필드를 괄호 안에 (depart, gender)로 적으면 서브쿼리의 컬럼과 1:1로 비교하여 두 필드가 일치하는 레코드를 검색
# 여러 필드를 한꺼번에 비교할 수 있어 편리.
# 단 일괄 비교가 성립하려면 비교 대상과 서브쿼리의 컬럼 개수는 반드시 일치해야함

# 좀 더 복잡한 문제를 풀어봄.
# 서브쿼리가 다중열이면서 다중행인 결과셋을 리턴하면 복수 레코드의 복수 필드를 한꺼번에 비교 가능.
# 다음 쿼리문은 부서별 최고 월급자의 목록을 조사.


# 다중 열이면서 다중 행인 경우.	# 이런류를 묶은 것을 튜플이락도 함
SELECT * FROM tstaff WHERE (depart, salary) IN
(SELECT depart, MAX(salary) FROM tstaff GROUP BY depart);
# 부서별로 최고 월급을 받고 있는 사람 조회.


# 이 멸령은 



# 문제1.판매 데이터베이스에서 달콤비스킷을 생산한
# 제조업체가 만든 제품들의 제품명과 단가를 검색해보자.

SELECT * FROM torder;
SELECT 제품명, 단가 FROM 제품 WHERE 제조업체 =
(select 제조업체  from 제품 WHERE 제품명='달콤비스킷'); #한빛 제과

# 문제2. 판매 데이터베이스에서 적립금이 가장 많은
# 고객의 고객이름과 적립금을 검색해보자.

SELECT 고객이름,적립금 FROM 고객 WHERE 적립금=
(SELECT MAX(적립금) FROM 고객) LIMIT 0,1;

# 문제3. 판매 데이터베이스에서 banana 고객이 주문
# 한 제품의 제품명과 제조업체를 검색해보자.

SELECT 제품명, 제조업체 FROM 제품 WHERE 제품번호 
IN(SELECT 주문제품 FROM 주문 WHERE 주문고객='banana');

# 4. 판매 데이터베이스에서 banana 고객이 주문
#하지 않은 제품의 제품명과 제조업체를 검색해 보자.

SELECT 제품명, 제조업체 FROM 제품 WHERE 제품번호 
NOT IN(SELECT 주문제품 FROM 주문 WHERE 주문고객='banana');

### 1. 무결성 관리

# 세상에 완벽한 것이 없듯이 데이터베이스나 그 안에 저장된 데이터도 항상 완벽할 수 없음.
# 모든 데이터가 결합없이 완벽한 상태를 무결성 Intergrity 이라고 함.
# 데이터베이스 관리 시스템은 무결성을 지키기 위해 최선의 노력을 하며
# 그래서 이전의 단순한 정보 저장 방식과 차원이 다름.

# 데이터 무결성을 지켜내는 것을 참조 무결성이라고 함.


# titem 테이블 사용.  상점에서 상품명이 사과를 제일 많이 구매한 회원 정보 전부를 가져오시오.
SELECT * FROM tmember WHERE MEMBER =
(SELECT member from torder WHERE item IN # IN 연산자든 = 연산자든 현 시점에선 동일함
(SELECT item FROM titem WHERE item='사과'));

# NULL 허용
# NULL은 아무것도 입력되지 않은 것이며 알 수 없거나 정렬되지 않은 특수한 상태를 의미.
# 필드의 NULL 허용 속성은 NULL 상태가 존재하는지를 지정.
# '반드시 입력해야 하는 필수 필드는 NULL 을 허용해서는 안되며 없어도 그만인 옵션 필드는 NULL을 허용해도 상관없음.

INSERT INTO tcity (NAME, popu, metro, region) VALUES ('울산', 114,'y', '경상');
INSERT INTO tcity (NAME, metro, region) VALUES ('삼척','n','강원');

INSERT INTO tcity (AREA, popu, metro, region) VALUES (456,123,'n','충청');  # name (기본키)가 없음
INSERT  tcity (NAME, AREA, popu) VALUES ('의정부',456,123); # mtero,region 이 없음 not null 이라 값이 필수로 들어가야함

CREATE TABLE tNullable (	# 테이블 생성
NAME CHAR(10) NOT NULL,	# 값이 필수로 들어가야함
age INT	# 값을 주지 않아도 됨
);

INSERT INTO tNullable (NAME, age) VALUES ('흥부',36);
INSERT INTO tNullable (NAME) VALUES ('놀부');
INSERT INTO tNullable (age) values (44); # name 이 없어서 오류. NOT NULL 속성임

### 3. 기본값
# NULL 허용 속성은 데이터베이스의 성능을 저해하는 주범.
# 항상 NULL 상태를 감안하여 필드값이 존재하는지 점검해야 하고 보통의 값과는 다루는 밥ㅇ식이 달라 느릴 수 밖에 없음.
# 응용 프로그램도 NULL을 항상 고려해야 하는 부담이 있음.

# NULL 허용 대신 기본값 DEFAULT 을 사용하는 것이 성능상 유리.
# '기본값은 필드값을 지정하지 않을 떄 자동으로 입력할 값.'
# 보통 무난한 값을 지정하는데 수치형은 0이 적당하고 문자열을 비워 두거나 'N/A' 등을 많이 사용.

# 대부분의 경우 일정한 값이 입력되는데 가끔 예외가 있는 필드에 기본값을 적용.
# 도시중 광역시는 몇 개 되지 않으며 대부분 지역에 소속.
# 이럴 때 metro 필드 속성에 DEFAULT 키워드와 함께 디폴트 값을 'n'으로 지정.

CREATE TABLE tcitydefault (
	NAME CHAR(10) PRIMARY KEY,
	AREA INT NULL,	# 기본값 null
	popu INT NULL, # 기본값 null
	metro CHAR(1) DEFAULT 'n' NOT NULL, # <<< 기본값 'n'
	region CHAR(6) NOT null
	);


# 값을 괄호로 감싸 DEFAULT('n') 이라고 적어도 됨. DEFAULT 키워드는 NULL 허용 속성보다 앞에 와야함.

INSERT INTO tcityDefault (NAME, AREA, popu, region) VALUES('진주',712,34,'경상'); # metro는 기본값으로 설정한 n이들어감
INSERT INTO tcitydefault (NAME,AREA,popu,metro,region) VALUES ('인천', 1063, 295, 'y', '경기');
SELECT * FROM tcitydefault;
# 진주시는 면적, 인구, 지역만 지정하고 광역시 여부는 생략. 필드 목록에 metro 가 아예 없는데
# 이 경우 디폴트가 적용되어 광역시가 아닌 것으로 삽입.
# 인천시는 모든 필드의 값을 다 제공하여 광역시로 등록.

# 디폴트 값을 키워드로도 사용이 가능함.

INSERT INTO tcitydefault VALUES ('강릉',1111,22,DEFAULT,'강원');

SELECT * FROM tcitydefault;

# 기본값으로 변경할 때도 DEFAULT 키워드를 사용.
# 다음 명령을 인천의 metro 필드를 기본값인 'n'으로 변경.
UPDATE tcitydefault SET metro = DEFAULT WHERE NAME = '인천';

## '기본값의 유무와 NULL 허용 여부는 완전히 별개의 속성임을 주의'
# 생략시 자동 적용되는 기본값이 있으면 항상 NULL 은 아닐거라고 오해할 수 잇음.
# 그러나 기본값이 지정되어 있더라도 NULL을 직접 입력할 수 잇고
# UPDATE 명령으로 NULL로 바꿀 수도 있음.
# 기본값은 생략시 적용할 값일 뿐이지 NULL 허용 여부까지 통제하는 것은 아님.
