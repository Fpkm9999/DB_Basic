
### ORDER BY - 정렬 ###

# 기본형식
# SELECT 필드목록 FROM 테이블 [WHERE 조건] [ORDER  BY 정렬기준]
 
# SELECT 명령에 별 지정이 없을 경우 레코드의 출력 순 서는 DBMS의 디폴트 순서를 따름. 
# 오라클은 입력 순서을 기억해 그대로 출력하고, MariaDB는 기본키에 대해 오름차순(ASC)으로 정렬. 
# 관계형 DB에서 레코드의 물리적 순서는 큰 의미가 없 고, 대신 출력할 때 ORDER BY 절로 정 렬 순서를 원하는대로 지정.

# 기본형식 
# ORDER BY 필드 [asc | DESC]
# 연습1
SELECT * FROM tcity ORDER BY popu; # popu를 기준으로 오름차순(ASC) 정렬됨

# 위의 SELECT 문과 동일한 결과 ASC
SELECT * FROM tcity ORDER BY popu ASC; # 인구수를 기준으로 오름차순으로 정렬하여 인구가 적은 도시부터 출력

# popu 필드를 내림차순으로 해본다면
SELECT * FROM tcity ORDER BY popu DESC; # 인구수를 기준으로 내림차순으로 정렬해서 인구가 많은 도 시부터 출력.

# ORDER BY 다음에 정렬 기준 필드를 적고 오름차순 일 경우 ASC 키워드를,
# 내림차순일 경우 DESC 키워드를 지정. 순서를 생략하면 디폴트인 오름차순으로 적용 되므로 키워드 ASC는 보통 생략하는편.



# 두 개 이상의 기준 필드를 지정할 수 있음.

## 첫 번째 기준 필드의 값이 같으면, 두번 째 기준 필드를 비교하여 정렬 순서를 결정. ##
select region, name, area, popu from tcity order by region, name DESC;	# 지역별로 정렬하되 같은 지역에 속한 도시끼리는 이름의 내림 차순으로 정렬.
# ORDER BY 뒤에 기준 필드를 콤마로 구분하여 나열하되 각 기준별로 오름차순과 내림차순을 따로 지정 가능함.
# 지역은 따로 순서를 정하지 않았으므로 디폴트 설정인 ASC가 적용 됨.
# 1차 정렬 기준인 지역이 같으면 2차 기준인 이름 순으로 정렬하되 이때는 DESC 내림차순으로 정렬.

select region, name, area, popu from tcity order by region ASC, name DESC; # 위와 동일한 결과를 보여줌

# region 기준이 같은 강원의 경우 두번 째 기준 필드인 홍천과 춘천이 ASC or DESC에 따라 달라짐, 지역이 경기도 마찬가지로 오산과 서울도 바뀜
select region, name, area, popu from tcity order by region asc, name ASC;

SELECT region, NAME, AREA, popu FROM tcity ORDER BY AREA ASC, NAME DESC; 
# 1차 기준인 AREA필드가 동일한 값이 없으므로 두 번째 정렬 기준인 NAME은 호력을 발휘 하지 않음

SELECT region, NAME, AREA, popu FROM tcity ORDER BY AREA ASC, NAME ASC;
# 이 경우도 1차 기준인 AREA필드가 동일한 값이 없어서 두 번째 정렬 기준은 실행되지 않는다.
# 이 경우는 AREA가 동일한 값이 없을 경우 이름으로 정렬을 하는 경우가 없다
# 1차 기준은 정렬 기능 동작함.

SELECT * from tcity ORDER BY region asc ,name ASC; # 지역별로 정렬하되 같은 지역에 속한 도시끼리는 이름을 기준으로 오른차순으로 정렬.

SELECT * from tcity ORDER BY region asc ,name DESC; # 지역별로 정렬하되 같은 지역에 속한 도시끼리는 이름을 기준으로 내림차순으로 정렬.

# ORDER BY 기준은 컬럼 기준(순서값)으로도 가능함
# ORDER BY 기준은 보통 필드명으로 하지만 순서값 으로도 지정 가능

# 필드 순서 값 : 테이블 생성시에 등록한 순서.
SELECT * FROM tcity ORDER BY AREA; # name : 1번, area : 2번, popu : 3번, metro : 4번, region : 5번

SELECT * FROM tcity ORDER BY 2; # 지역을 기준으로 오름차순
# 면적순으로 정렬하려면 area를 기준으로 하는 대신 2 번 필드 기준으로 해도 결과는 같음.

# 결론 : 테이블에 존재하는 모든 필드는 정렬 기준으로 사용가능하다.
# 그러나 정렬 기준 필드를 출력 목록에 꼭 포함할 필요는 없다.
SELECT name FROM tCity ORDER BY popu;
SELECT * FROM tcity ORDER BY 3;

# 테이블에 존재하지 않은 계산값도 정렬 기준으로 사용 할 수 있음.

SELECT name, popu * 10000 / area FROM tCity ORDER BY popu * 10000 / AREA; 

# 탕상 계산에 별명을 지어서 사용함.
SELECT name, popu * 10000 / area AS tmp FROM tCity ORDER BY tmp;	 # 인구수와 면적으로 계산한 인구밀도의 오름차순으로 도시를 정렬

# 정렬 기준을 꼭 같이 출력할 필요는 없지만 제대로 정 렬했는지 확인하기 위해 인구밀도를 같이 출력.

# 레코드의 조건을 지정하는 WHERE 절과 출력 순서를 지 정하는 ORDER BY 절을 동시에 사용 가능.

# 대신 순서는 SELECT - FROM - WHERE - ORDER BY 순이다. 안지키면 에러뜬다

SELECT * FROM tcity WHERE region = '경기' ORDER BY AREA; # 경기도에 있는 도시만 골라 면적별로 정렬 # 이때 ORDER BY는 WHERE 절보다 뒤에 있어야함
SELECT * FROM tcity ORDER BY AREA WHERE region = '경기' ;
# 순서가 틀려서 에러가 뜸


# 관련 문제
# 1. 직원 목록을 월급이 적은 사람부터 순서대로 출력하되 월급이 같다면
# 성취도가 높은 사람을 먼저 출력하라.
SELECT * FROM tstaff;
SELECT * FROM tstaff ORDER BY salary, score desc;
SELECT name FROM tstaff ORDER BY salary, score desc;

# 2. 영업부 직원을 먼저 입사한 순서대로 정렬하라.\
SELECT * FROM tstaff;
SELECT * FROM tstaff WHERE depart ='영업부' ORDER by joindate;

### 2. DISTINCT -  중복제거 ###

SELECT region FROM tcity;

# 도시 테이블에서 region 필드만 읽어 도시가 속한 지역의 목록을 조사.
# 단순하게 중복된 것만을 제거 하고 싶은 경우 
# ex) 몇 종류가 있는지

SELECT DISTINCT region FROM tcity;	# DISTINCT 키워드가 있는 필드는 중복값을 합쳐 한 번만 출력
# DISTINCT 키워드로 중복 제거를 하다 보면 순서가 달라지는 문제가 있음.
# 만약 중복도 제거하고 정렬도 하고 싶으면 ORDER BY 절을 붙임

SELECT DISTINCT region FROM tcity ORDER BY region;

# 같은 도시가 여럿 있으니 중복된 이름이 출력. 지역별로 몇 개의 도시가 있는지 알고 싶다면 상관 없 지만, 
# 단순이 어떤 지역이 있는지만 조사한다면 굳이 중복된 값을 여러 번 출력할 필요가 없음. 중복된 값을 제거할 때 DISTINCT 키워드를 붙임.

# 중복 제거 하고 싶은 필드명에 DISTINCT 를 붙이면 고유한 값만 출력

# distinct 의 반대는 ALL 임  # ALL : 중복 제거 없이 모든 레코드를 출력함
# 출력의 디폴트 값이 ALL 이라 굳이 지정해서 쓰지는 않음

SELECT ALL depart FROM tstaff;
SELECT  depart FROM tstaff; # 위와 결과는 동일함

SELECT DISTINCT depart FROM tstaff; # 회사에 어떤 부서가 있는지 조사할 경우 DISTINCT 키워드를 붙이면 중복 부서명을 합쳐 한 번씩만 보여줌.

# 매출 테이블에서 매출액이나 판매 개수는 관심이 없고 오늘 어떤 상품이 팔렸는지만 알고 싶을때
# DISTINCT


# 1. 2020년 이후 신입 사원을 받은 적이 있는 부서 목록을 조사하라.
SELECT * FROM tstaff;

SELECT * FROM tstaff WHERE joindate>= '20200101';

SELECT DISTINCT depart FROM tstaff WHERE joindate>= '20200101';

SELECT DISTINCT depart FROM tstaff WHERE joindate>= '2020-01-01';

# 2030년 전까지는 아래 코드도 실행가능
SELECT * FROM tstaff WHERE joindate LIKE '202%';

SELECT DISTINCT depart FROM tstaff WHERE joindate LIKE '202%';


### 3. LIMIT - 행수를 제한 #마리아db 와 mysql 에만 있는 기능 ###
# 인덱스처럼 0번 부터 시작함
# LIMIT 구문으로 행수를 제한.

# 기본형식 : SELECT ... FROM ... LIMIT [건너뛸 개수],총개수;
# [건너뛸 개수] 를 생략하면 0으로 적용하여 첫 행 부터 출력.

SELECT * FROM tcity ORDER BY AREA DESC; 
SELECT * FROM tcity ORDER BY AREA DESC LIMIT 4; # 면적이 넓은 상위 4개 도시를 구하는 구문.

# 위와 아래 문장은 같다.
SELECT * FROM tcity ORDER BY AREA DESC LIMIT 0,4;
														# 시작될 순서 0


# 쿼리문은 순서가 중요한데 이건 ORDER BY 뒤에 있다.

SELECT * FROM tcity ORDER BY AREA DESC LIMIT 2,3;
# 앞쪽 2개는 건너뛰고 이후 3개의 행을 구함.
# 2번 행부터 3개 가져와라

SELECT * FROM tcity ORDER BY AREA DESC LIMIT 3 OFFSET 2;

# 앞쪽 몇 개를 건너뛴 후 일정 개수 만큼 보여주는 이 구문은 게시물을 페이지 단위로 끊어 서 출력할 때 실용적
# LIMIT 는 인터넷이 활성화 되면어 페이징관리 때문에 잘 쓰이긴 한다. 
# 디시 50개글 페이지뷰 등
# 게시판에 페이지 단위로 끊어서 보여줄 떄 사용
# MySQL과 MariaDB가 게시판용으로 맹위를 떨치는 이유 중 하나가 이 구문.

### 4. OFFSET FETCH ###

# 테이블의 일부 레코드만 조회하는 작업은 빈도가 높고 실용적이지만 DBMS 별로 사용하는 문법이 다르다.

# LIMIT는 mysql에서 쓰는 사투리같은거임.
# LIMIT 문법이 SQL 표준에 안맞아서 표준에 맞게 수정한게 OFFSET FETCH임 기능은 동일하고 LIMIT 문법의 표준이 OFFSET FETCH 라는 점.
# mySQL에만 LIMIT가 있음

## 일부분을 특정하려면 순서를 지정해야 해서 ORDER BY 문이 반드시 있어야 함.
## 그래서 OFFSET FETCH 는 별도의 구문이 아니라 ORDER BY의 옵션이라 보면된다.

# ORDER BY 기준필드 OFFSET 건너뛸행 수 ROWS FETCH NEXT 출력할 행수 ROWS ONLY
SELECT * FROM tcity ORDER BY AREA DESC OFFSET 0 ROWS fetch NEXT 4 ROWS ONLY;
SELECT * FROM tcity ORDER BY AREA DESC LIMIT 0,4; # 면적 순으로 상쉬 4개의 도시를 출력. 면적 내림차순으로 정렬 후 4개의 행만 읽음

# LIMIT 는 사투리고 표준은 아님, OFFSET FETCH는 표준이지만 길어져서
# 있다는 것만 알아두자.

# OFFSET 을 지정해 앞쪽 일부를 건너뛰기
SELECT * FROM tcity ORDER BY AREA DESC OFFSET 2 ROWS fetch NEXT 3 ROWS ONLY;

SELECT * FROM tcity ORDER BY AREA DESC LIMIT 2,3;
# 상위 2개를 건너 뛰고 다음 순서인 3, 4, 5위 3개의 도시를 조사.
# WHERE 구문과 함께 사용하여 필터링을 먼저 하고 그 중 일부 레코드만 출력할 수 있음.

SELECT * FROM tcity WHERE metro = 'n' ORDER BY AREA DESC OFFSET 2 ROWS fetch NEXT 3 ROWS ONLY;
SELECT * FROM tcity WHERE metro = 'n' ORDER BY AREA DESC LIMIT 2,3;
# 광역시는 제외하고 순위를 매겨 3등에서 5등까지 출 력.

# limit 을 쓴다고 해서 부하가 줄어 들지는 않는다. 제일 마지막에 수행하기 때문.

# 연습문제
# 1. 직원월급을 월급순으로 낮은 순서로 정렬한 후 12위에서 16위 까지 출력하라.
# 월급이 같은 경우에는 이름을 가나다라 순서로 하라.
SELECT * FROM tstaff;
SELECT * FROM tstaff ORDER BY salary;

SELECT * FROM tstaff ORDER BY salary , name LIMIT 11,5;
