### 1. GROUP BY

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

SELECT depart, COUNT(*), MAX(joindate), AVG(score) FROM tStaff GROUP BY depart; 
# 여러 개의 집계함수를 동시에 사용 가능.
# 부서별 인원수, 최근 신입 입사일, 성취도 평균을 한꺼번에 구함.




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

### 2. 기준 필드

# GROUP BY의 기준필드는 중복 값이 있을 때만 의미.
# 레코드별로 고유한 값을 가지는 필드는 그룹핑 기준으로 부적합하며(예 : 아이디), 구분이나 분류 필드가 적합.
# 한 부서에서 여러 직원이 소속되어 있고 부서가 앝은 직원이 많기 때문에 부서별 집계가 가능.

# 성별도 중복값이여서 그룹핑 필드로 적합
SELECT gender, AVG(salary) FROM tstaff GROUP BY gender;

# 남녀 성별로 평균 월급을 구함.
SELECT NAME, SUM(salary) FROM tstaff GROUP BY NAME; # 중복이 없음
# 중복 값을 가지는 필드만 그룹핑의 기준이 되는 것은 아니며 임의의 필드를 기준으로 그룹핑 할 수 잇음.

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

# GROUP BY 절이 있으면 필드 목록에는 기준 필드나 집계 함수만 와야함.

SELECT depart, SUM(salary) FROM tstaff GROUP BY depart;	# 이렇게 하는게 맞다
SELECT SUM(salary) FROM tstaff;

# 종합 : SELECT 기준필드, 집계함수() FROM WHERE GROUP BY

###  4. HAVING # GROUP BY 다음으로 옴

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
# 월급이 300 초과인 직원들을 대상을 부서별 평균 월급을 
# 구하고 그 결과 평균 월급이 360 이상인 부서만 고른 후 부서명 으로 정렬

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

# GROUP BY 앞뒤로 WHERE 와 HAVING이 오고 ORDER BY는 마지막. 

# 서버가 느린경우 
# 서버의 처리량보다 요규랑이 높은 경우, 최적화가 안된 쿼리문실행

# 1. 각 지역에서 가장 큰 면적을 구하되 단 인구가 50만 이상인 도시만 대상으로 한다.
SELECT region, MAX(AREA) FROM tcity WHERE popu>=50 GROUP BY region;

# 2. 각 지역별 평균 면적을 구하되 평균 면적이 1000 이상인 지역만 출력하라.
SELECT region, AVG(AREA) AS avg_area FROM tcity GROUP by region HAVING avg_area >= 1000;
SELECT region, avg(AREA) AS avg_area FROM tcity WHERE AREA >=1000 GROUP BY region; #답은 어거지로 맞는데 사실 틀린 거임


# 아래꺼가 맞음 평균값 기준으로 조건을 걸어야 하는데 where 로는 집계함수 조건을 걸 수가 없다
SELECT region, avg(AREA) AS avg_area FROM tcity  GROUP BY region HAVING avg_area>=1000;


# ---- 숙제 
# 1. 주문 테이블에서 주문제품별 수량의 합계를 검색해보자
SELECT 주문제품, SUM(수량) AS `총주문수량` FROM 주문 group BY 주문제품;

# 2. 제품 테이블에서 제조업체별로 제조한 제품의 개수와 제품 중 가장 비싼 단가를
#검색하되, 제품의 개수는 제품수라는 이름으로 출력하고 가장 비싼 단가는 최고가라는 이름으로 
# 출력해보자

SELECT 제조업체, COUNT(*)  AS `제품수`, MAX(단가) AS `최고가` FROM 제품 group BY 제조업체;

# 3. 제품 테이블에서 제품을 3개 이상 제조한 제 조업체별로 제품의 개수와, 제품 중 가장 비싼 단가를 검색해보자.
SELECT 제조업체, COUNT(*) AS `제품수`, MAX(단가) AS `최고가` FROM 제품 group BY 제조업체 HAVING 제품수 >=3;
SELECT 제조업체,COUNT(*) AS `제품수`, MAX(단가) AS `최고가`  FROM 제품 GROUP BY 제조업체 HAVING `제품수` >=3;

# 4. 고객 테이블에서 적립금 평균이 1,000원 이 상인 등급에 대해 등급별 고객수와 적립금 평균 을 검색해 보자.
SELECT 등급, COUNT(*) AS `고객수` , AVG(적립금) AS `평균적립금` FROM 고객 GROUP BY 등급 HAVING 평균적립금 >=1000;

# 5. 주문 테이블에서 각 주문고객이 주문한 제품의 총 주문 수량을 주문제품별로 검색해보자.
SELECT 주문제품, 주문고객, SUM(수량) AS "총주문수량" FROM 주문 group BY 주문제품,주문고객;