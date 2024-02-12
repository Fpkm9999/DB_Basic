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
INSERT INTO tOrder (MEMBER,item,orderDate,num,status) VALUES ('방자','전자담배','2019-12-2',4,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('향단','사과','2019-12-5',5,2);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('흥부','노트북','2019-12-5',2,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('방자','핸드폰','2019-11-1',1,3);

### 1. 서브 쿼리(SubQuery)는 '쿼리문 안에 또 다른 쿼리문이 포함된 구문'.

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

## case1. 단일행 서브쿼리

# SELECT 명령은 DB 엔진에게 정보를 요구하는 질문.
# SELECT로 할 수 있는 질문은 아주 짧은 단문만 가능하면 FROM 절이 하나밖에 없어 
# 한 테이블에있는 정보만 조사할 수 있었음.

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
# 목적은 달성했지만 사람이 첫 번째 쿼리의 결과를 확인한 후 두 번쨰 쿼리의 조건문을 직접 기입하는 식이라
#불편함.

# 이 둘을 묶어 주는게 서브쿼리

# 서브쿼리로 하면.
SELECT NAME FROM tcity WHERE popu = (SELECT MAX(popu) FROM tcity);
# 괄호로 묶는 이유 : 괄호안에 있는 문장부터 먼저 실행해서 974를 구하고 쿼리문을 실행하도록 하기 위함

# 한번에 서울을 구함 DB 엔진은 괄호 안의 서브 쿼리를 먼저 실행하여 최대 인구수를 구함.

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
# 단일행 서브쿼리는 하나의 결과만 리턴하며 주로 WHERE, HAVING 등의 조건절에 사용. 
# 복합 질문의 앞쪽 질문에 해당하는 값을 서브 쿼리로 조사해 놓고 외부쿼리에서
#  그 결과값 을 사용하는 식으로 작성.


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



### 2. 서브쿼리 중첩 ###

# 서브쿼리는 독립적인 하나의 명령이기 때문에 외부쿼리와는 '다른 테이블을 읽을 수도 있음'.
# 어짜피 순차적으로 실행되므로 '두 쿼리문의 FROM 절에 각각 다른 테이블을 지정해도 상관이 없음'.

# 그래서 더 복잡한 형태의 질문도 가능
# e.g ) 청바지 배송비가 얼마인지 조사
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
select delivery from tcategory where category = (
select category from titem where item='청바지');


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

# 지금까지 단일행이라 문제가 없었는데 혹시나 상품이 여러 개이거나 구입한 사람이 둘 이상이라
# 에러 처리가 되는데
# 이떄는 TOP 1 (LIMIT 1) 을 넣어 첫 구입자를 찾으면 됨.


# 문제
# 1. 대추를 구입한 회원의 이름과 이 회원의 예치금을 구하라.
SELECT MEMBER, money FROM tmember WHERE MEMBER =
(SELECT member FROM torder WHERE item='대추');


# 2. 춘향이가 구입한 상품의 가격을 조사하라
SELECT price FROM titem WHERE item = 
(SELECT item FROM torder WHERE MEMBER = '춘향');
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


## IN은 = 과 달리 여러 개의 값과 비교. ## 


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


# WHERE 절에 비교 대상 필드를 괄호 안에 (depart, gender)로 적으면 서브쿼리의 컬럼과 1:1 로 비교하여 
# 두 필드가 일치하는 레코드를 검색. 여러 필드를 한꺼번에 비교할 수 있어 편리. 
# 단 일괄 비교가 성립하려면 비교 대상과 서브쿼리의 컬럼 개수는 반드시 일치해야 함


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
 #여기부터
SELECT 제품명, 제조업체 FROM 제품 WHERE 제품번호 
IN(SELECT 주문제품 FROM 주문 WHERE 주문고객='banana');

# 4. 판매 데이터베이스에서 banana 고객이 주문
#하지 않은 제품의 제품명과 제조업체를 검색해 보자.

SELECT 제품명, 제조업체 FROM 제품 WHERE 제품번호 
NOT IN(SELECT 주문제품 FROM 주문 WHERE 주문고객='banana');


# 5. 판매 데이터베이스에서 대한식품이 제조한
# 모든 제품의 단가보다 
#비싼 제품의 제품명, 단 가, 제조업체를 검색해보자
select 제품명,단가,제조업체 from 제품 where 단가 > (
select max(단가) from 제품 WHERE 제조업체='대한식품');

# 6. 판매 데이터베이스에서 
# 2019년 3월 15일에 제품을 주문한 고객의
# 고객이름을 검색해보자.
select 고객이름 from 고객 where  고객아이디= (
select 주문고객 from 주문 where 주문일자 = '2019-03-15');