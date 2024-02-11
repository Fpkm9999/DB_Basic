# 4장
### 1. COUNT

# 2024-02-05

# 함수 : COUNT 
# *은 전체를 세는거

# 함수는 입력값으로부터 모종의 계산을 하여 출력값을 리턴하는 장치. 

# 입력은 함수명 다음의 괄호 안에 인수로 전달하며 함 수 호출문은 실행결과를 리턴. 
# 테이블에 저장된 정보를 함수로 전달하면 원본 데이터 를 변형, 가공하여 돌려줌. 
# 함수 호출문이 하나의 값이므로 필드 목록이나 조건절 등에 값처럼 사용하면 됨.
# 집계 함수 Aggregate Function는 복수개의 레코드에 대해 집합적인 계산을 수행하여 합계, 평균, 분산 같 은 통계값을 산출.

 ## COUNT는 개수를 세는 기능을 하는데, 개 수를 조사할 필드명을 전달하는데 * 지정하면 필드에 상관없이 조건에 맞는 레코드 개수를 리턴

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

# 집계는 모든 레코드의 값을 참고하여 하나의 값을 구하는 것이어서 결과셋은 목록이 아닌 딱 하나의 값. 
# 집계하는 말 자체가 다중값으로 부터 단일 값을 산출 한다는 의미.

## 조건에 맞는 레코드가 없어도 결과값은 역시 하나.

# COUNT(*)로 조사한 개수에 해당하는 레코드를 알고 싶 으면 원하는 필드명을 적음.
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

SELECT COUNT(*) FROM tstaff WHERE score IS NULL;
# count 함수의 인수로 필드를 지정하는 경우는 드물고 count(*)로 전체 레코드의 개수를 구하는 경우가 일반적임.

	
# 연습문제
# 1. 실적도 없이 놀고 있는 두 직원은 두구인지 목록을 출력하는 쿼리를 작성하라. 몇명이란 말이 없어서 count 아님 널 조사

SELECT * FROM tstaff;
SELECT NAME,score FROM tstaff WHERE score IS NULL;

# 2. 성취도가 80점 이상인 직원이 몇 명이나 되는지 조사하라.

SELECT * FROM tstaff;

SELECT COUNT(*) FROM tstaff WHERE score>= 80;

# 2024-02-05
###  2. 합계와 평균
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

###  3. 집계 함수와 NULL
# NULL은 값을 알 수 없는 특수한 상태.
# 모든 집계 함수는 NULL을 무시하고 통계를 계산.
# 단, 예외적으로 레코드 개수를 세는 count(*)는 NULL도 포함하지만, 인수로 필드를 지정하면 NULL을 세지 않음.

SELECT AVG(salary) FROM tstaff;

## 둘다 동일함. 위에꺼가 좀 더 편함
SELECT SUM(salary)/COUNT(*) FROM tstaff;

# 평균은 총합을 개수로 나누어서 구함.
# 그래서 두 명령은 동일한 결과를 보여줌.

SELECT AVG(score) FROM tstaff;

SELECT COUNT(*) FROM tstaff;
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