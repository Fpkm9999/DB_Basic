

# 2. 단순 조인

# 생각보다 안쓰는 이유

SELECT * FROM tcar, tmaker WHERE tcar.maker = tmaker.maker;


SELECT tcar.car, tcar.price, tmaker.maker, tmaker.factory FROM tcar, tmaker
WHERE tcar.maker = tmaker.maker;
# 차이름, 가격, 제조사, 공장만 표시.
# 두 테이브르이 값을 조합하면서도 원하는 필드만 선택적으로 표시
# 1)

SELECT car, price, maker, factory FROM tcar, tmaker 
WHERE tcar.maker = tmaker.maker;


SELECT car, price, factory FROM tcar, tmaker 
WHERE tcar.maker = tmaker.maker;

### 3. 테이블 별명
SELECT car, price, tmaker.maker, factory # tmaker이든 tcar이든 같음
FROM tcar, tmaker 
WHERE tcar.maker = tmaker.maker;

SELECT C.car, C.price, M.maker, M.factory 
FROM tcar C, tmaker M
WHERE C.maker = M.maker;

# 쿼리문을 짧게 줄이는 것이 목적인 별명을 길게 쓰면 의미가 없음
# 테이브르이 첫 글자 하나만 대문자로 붙이는 것이 관례이지만 그것도 귀찮다면 
# 아무 알파벳이나 순서대로 붙여도 상관 없음.

# 조인문에서 테이블의 별명은 선택 사항이 아니라 거의 필수

### 4. 내부 조인
# 내부 조인(INNER JOIN) 은 ' 각테이블의 필드값을 비교하여

SELECT c.car, c.price, m.maker, m.factory 
FROM tcar c
INNER JOIN tmaker m ON c.maker = m.maker;
# from 절에서 tcar와 tmaker 를 조인하고 on 절에 두 테이블의 회사명이 같다는
조건을 지정.
# 단순 조인한 결과에서 on 조건에 맞는 레코드만 나타남.

# 기본 형식
# SELECT 필드 FROM A [INNER] JOIN B ON 조건;
# 조인의 디폴트가 inner join 이라서 join만 적어도 되기는 하지만 명시적으로 적어주는게 좋다.

SELECT c.car, c.price, m.maker, m.factory
FROM tmaker m
INNER JOIN tcar c ON m.maker = c.maker;
# inner join에서 tmaker와 tcar와 조인을 하거나 반대로 하거나 달라 질 것은 없음
# ON 의 조건에 따라 레코드를 선택하고 필드 목록에 따라 해당 필드를 보여줄 뿐.
# 단순 조인과 구문을 비교해 보면 콤마가 INNER JOIN 키워드로 바뀌고 
# WHER 조건절이 ON 절로 바뀐 것만 다름.

SELECT c.car, c.price, maker, m.factory
FROM tcar c
INNER JOIN tmaker m USING (maker);
SELECT * FROM tmaker;
# 필드명이 같으면 using() 으로 묶어서 사용이 가능함

# 연습 문제
# 1. 내부 조인으로 tEmployee의 직원 목록과 월급을 출력하고 tProject 에서 이 직원이
# 맡은 프로젝트를 같이 출력하라.
SELECT a.name, a.salary
FROM temployee a
INNER JOIN tproject b on a.name = b.employee;
;

# 2. 춘향이가 구입한 상품의 가격을 JOIN 을 이용해서 조사하라.

SELECT i.price
FROM titem i
INNER JOIN torder o ON i.item = o.item
WHERE o.member='춘향';


# 3. 대추를 구입한 회원의 이름과 이 회원의 예치금을 JOIN 을 이용해서 구하라.

SELECT a.member, b.money 
FROM torder a 
INNER JOIN tmember b on b.member = a.member
WHERE item = '대추';


### 외부 조인
# 내부 조인은 ON 조건에 맞는 레코드만 출력하며 그 외의 레코드는 제외.
# 앞 항에서 작성한 내부 조인문의 실행 결과를 살펴보면
# 제조사명이 일치하지 않는 SM5와 기아차는 조인 결과셋에 나타나지 않음.

# 매출이 전혀 없는 회원이라든가, 아무도 구입하지 않은 상품,
# 맡은 업무도없이 빈둥 빈둥 놀고 있는 직원을 색출하는 것도 실용적인 가치가 있음.
# 외부 조인은 내부 조인과는 달리 조건에 맞지 않는 레코드도 같이 출력.

# 결론은. 조인이 할당되지 않는 것도 구해야 할 떄 가 있다.

### 1) 왼쪽 조인
# 다음은 왼쪽 조인문.

SELECT c.car, c.price, m.maker, m.factory
FROM tcar c LEFT # tcar가 주 테이블이 됨.
OUTER JOIN tmaker m ON c.maker = m.maker;
SELECT * FROM tmaker; # 기아,서울은 안나옴 

# 조인 키워드가 INNER JOIN 에서 LEFT OUTER JOIN으로 바뀜.
# OUTER 키워드를 생략하고 짧게 LEFT JOIN이라고 써도 됨.
# 조인 조건에 맞는 레코드는 당연히 출력하고 이 외에 왼쪽 테이블인
# tcar의 모든 레코드도 출력.

# 외부 조인은 주종 관계가 있는 테이블에서 주 테이블(이 경우 tcar)의 모든 레코드를 보여주고
# 조건을 만족하는 부테이블(이 경우 tmaker)의 필드를 같이 출력.
# 조건을 충족하지 않아도 주테이블의 모든 레코드를 출력한다는 점에서 내부 조인과 다름

# 외부 조인은 어떤 테이블이 주 테이블이 되는가,
# 즉 모두 보여줄 테이블이 어떤 것인가에 따라 왼쪽, 오른쪽, 완전 조인으로 분류.
# 

# 내부 조인은 서로 평등한 관계 # 외부 조인은 주종 관계

# 오른쪽 조인


SELECT c.car, c.price, m.maker, m.factory
FROM tcar c RIGHT # tcar가 주 테이블이 됨.
OUTER JOIN tmaker m ON c.maker = m.maker;


SELECT c.car, c.price, m.maker, m.factory
FROM tmaker m LEFT
OUTER JOIN tcar c ON c.maker = m.maker;


# ---2024-02-21
# 연습문제
# 1. 다음 세 명령문은 직원과 프로젝트 테이블을 내부, 왼쪽 내부, 오른쪽 외부 조인으로 조하하여 출력한다.
# 이 세 명령의 출력 결과가 어떻게 다를지 예측해 보고 그 이유를 설명하라.

select * from temployee;
select * from tproject;
select * from temployee E inner join tproject t on E.name = t.employee;

select * from temployee E left outer join tproject P on E.name = p.employee;

select * from temployee E right outer join tproject t on E.name = t.employee;

### 3. 삼중 조인

select * from tcar C
inner join tmaker M ON C.maker = M.maker
inner join tcity T ON M.factory = T.NAME;

# 이를 통해 세 테이블의 정보를 한꺼번에 볼 수 있음
# 소나타는 현대에서 만들며 현대는 부산에 공장이 있고 부산의 인구는 342만명이라는 것을 알  수도 있음.

select * from tcar C # 주테이블은 tcar
    left outer join tmaker M ON C.maker = M.maker
    left outer join tcity T ON  M.maker = T.NAME;


# 문제
# 1. 식품 카테고리를 구매한 고객의 이름과 상품명을 JOIN 을 이용해서 조사하라.
select item from titem where category='식품';
select member,item from torder where item in('대추','사과');

select t2.member,t2.item from titem T
inner join torder t2 on T.item = t2.item
where t.category='식품';


# 2. 배송비가 2000원인 상품을 구매한 회원의 주소와 상품명, 제조사를 JOIN을 이용해서 조사하라.

select T.company from titem T
inner join tcategory T2 ON T.category = T2.category
inner join;
#where T2.delivery=2000;

select * from tmember where  member='춘향';
select member from torder where item='청바지';
select * from titem where category='패션';
select  category from tcategory where delivery = 2000;

show databases;
use testdb;
select * from tcity;

