# 조건문 
# 1. 필드 비교
# WHERE 절은 읽을 레코드의 조건을 지정. 
# 필드 목록은 읽을 열을 지정하는데 비해 WHERE 절은 읽을 행을 지정.
# WHERE 절이 없으면 모든 레코드를 다 조회. 

# SELECT 명령은 조건에 맞는 레코드를 검 색하는 것이 주 기능이어서 대개의 경우 WHERE 절과 함께 사용. 
# WHERE 절은 DELETE, UPDATE 등의 명령과 함께 삭제 및 변경할 레코드를 선택할 때도 사용. 
# WHERE 절에는 레코드를 선택하는 조건문이 옴. 주로 필드와 특정값을 비교하는 조건문 형태로 작성
SELECT * FROM tcity WHERE AREA >1000; # 면적이 1000제곱킬로미터 보다 큰 도시만 검색.

SELECT NAME, AREA FROM tcity WHERE AREA > 1000; # 필드 목록에 * 대신 원하는 필드만 적으면 조건에 맞 는 레코드의 지정한 필드만 표시.

SELECT NAME FROM tcity WHERE AREA > 1000;
# 조건문이 맞는지 확인이 불가능해 이런것은 좋지않다.

# 조건문은 필드와 상수, 변수 등을 표현식이되고 비교 대상끼리 타입이 호환되어야 함.
# 정수형을 문자열과 비교한다거나 실수형을 날짜와 비교해서는 안됨.

/*
조건문에 사용하는 비교 연산자 연산자 설명 
예 A = B 같다. WHERE NAME = '서 울' 
A > B A가 더 크다. WHERE area > 50 
A < B A가 더 작다. WHERE popu < 100 
A >= B A가 B보다 크거나 같다. WHERE popu >= 100 
A <= B A가 B보다 작거나 같다. WHERE area <= 50 
A <> B, A != B A와 B는 다르다. 또 는 같지 않다. WHERE region <> '경기'

# A <> B, A != B  A와 B는 다르다. 또는 같지 않다.
# ex) WHERE region <> '경기' */

# 숫자는 상수를 그냥 쓰지만 문자열과 날짜 상수는 항상 작음 따옴표로 감싸야함.

SELECT * FROM `tCity` WHERE `name` = '서울' #맞다

SELECT * FROM `tCity` WHERE `name` = '서울' -- 맞음 
SELECT * FROM tCity WHERE NAME = '서울' -- 맞음 
SELECT * FROM tCity WHERE NAME = 서울 -- 틀림 
SELECT * FROM tCity WHERE NAME = "서울" -- 틀림. 단, 마리아는 인정한다.
# 따옴표없이 그냥 서울이라고 하면 이때의 서울은 필드 명을 의미.


SELECT * FROM tcity WHERE metro = 'y';

SELECT * FROM tcity WHERE metro = 'Y';

# 필드의 영문자를 비교할 때는 대소문자 주의. 
# SQL문 자체는 대소문자를 가리지 않아 키워드나 테이블명, 
# 필드명을 아무렇게나 적어도 상관이 없지만,    필드안에 저장된 값은 대소문자를 구분. 
# 필드값의 대소문자 구분 여부는 DBMS에 따라, 설정에 따라 다름. 
# 어떤 DBMS를 사용하건 따옴표 내의 문자열 상수는 가 급적 대소문자를 정확히적는 것이 바람직.


# 연습문제

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


### 2. null 비교 
# 값이 입력되어 있지 않은 특수한 상태를 표현.
# 값을 알 수 없거나 결정할 수 없다는 뜻이며 0이나 빈 문자열과는 다름.
# 필드를 선언할 때 NULL 가능성을 미리 지정.
# 정보가 아직 조사되지 않았거나 모르는 상태일 때 이 필드를 NULL로 남겨 둠.
# 선언문 뒤에 NULL 이 있으면 이 필드에는 값을 입력하지 않아도 된다는 뜻.

# NOT NULL 로 선언되어 있으면 값이 없으면 레코드를 삽입할 수 없음.

SELECT * FROM tstaff;
# 필드명 = null 이라면.
# NULL 값을 검색할려고 조건절에서 = NULL 로 작성. 
# 하지만 NULL은 값이 아니라 상태이기 때문에 = 연산자 로 비교할 수 없음.

SELECT * FROM tstaff WHERE score IS NULL; # 필드는 값이고 NULL은 상태라서 IS NULL 연산자를 따 로 제공.
# null을 검색할때는 is null 을 하면 된다. 비교 연산자를 쓰면 안된다.

SELECT * FROM tstaff WHERE score IS NOT NULL;
# null 이 아니라는 조건은 IS NOT NULL로 표기.


### 3. 논리 연산자
# 두 개 이상의 조건을 동시에 검색할 때는 AND, OR 논리 연산자를 사용. 
# AND는 두 조건이 모두 참인 레코드를 검 색하며 OR는 주 조건 중 하나라도 참인 레코드를 검사.
SELECT * FROM tcity WHERE popu >= 100 AND AREA >= 700; # 인구 100만명 이상, 면적 700제곱킬로미터 이상인 도 시를 검색. 두 조건을 만족하는 부산만 출력.

SELECT * FROM tcity WHERE popu >= 100 OR AREA >= 700; # AND를 OR로 변경하면 두 조건중 하나라도 참인 레코드 검색

# 세 개 이상의 조건문 지정시.
# 마찬가지로 WHERE절을 작성하되 조건의 우선순위에 주의

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
# 인구가 50만이 넘거나 면적이 500이상인 경기도 도시 를 검색

### 2.  NOT 연산자
# NOT 연산자는 표현식의 진위 여부를 반대로 바꿈. 
# 즉 뒤의 표현식이 참이면 거짓으로 바꾸고 거짓이면 참으로 바꾸어 반대 조건을 취함

SELECT * FROM tcity WHERE region !='경기';
# 경기도가 아닌 것을 골라내라

SELECT * FROM tcity WHERE NOT(region = '경기');
# 이것도 위와 동일하다.

# 아래 조건의 반대 조건을 만들어라
SELECT * FROM tcity WHERE region = '전라' OR metro = 'y';

SELECT * FROM tcity WHERE region != '전라' AND metro != 'y';
# 드모르간의 법칙

SELECT * FROM tcity WHERE NOT( region = '전라' OR metro = 'y');
# 복합 조건의 반대를 취할때는 NOT이 편리

# 연습문제

# 1. 직원 목록에서 월급이 300 미만이면서 성취도는 60이상인 직원이 누구인지 조사하라.
select NAME,salary,score from tstaff where salary <300 and score >=60;
# 반대로 해봐라
SELECT NAME, salary, score FROM tstaff WHERE salary >=300 OR score < 60;
select NAME,salary,score from tstaff WHERE !(salary <300 and score >=60);

# 2. 영업부의 여직원 이름을 조사하라.
select * from tstaff WHERE depart='영업부' and gender = '여';

select name from tstaff where depart='영업부' and gender = '여';

### 4. LIKE

# 비교 연산자를 완전히 일치하는 조건식을 표현하는데 비해 LIKE 연산자는 패턴으로 '부분 문자열' 을 검색.
# ex) 성이 김씨인 사람, 주소가  강남구인 사람들을 검색할 때 편리.

# LIKE 문의 패턴에는 다음의 와일드 카드를 사용.
#   %   : 복수개의 문자와 대응. %자리에는 임의 개 수의 임의 문자가 올 수 있음.
#   _   : 하나의 문자와 대응. _자리에는 하나의 임의의 문자가 올수 있음. 
#  []   : []안에 포함된 문자 리스트 중 하나의 문자 와 대응. 
# [^]   : [^]안에 포함된 문자 리스에 포함되지 않은 하나의 문자와 대응

# >>> 임의 개수와 임의 문자와 대응하는 % 와일드 카드를 주로 사용.

SELECT * FROM tcity WHERE NAME LIKE '%천%'; # 이름에 "천"자가 들어가는 도시를 검색.
# 내가 찾고자 하는 글자 앞뒤로 %을 붙인다.
# 임의의 글자이기 때문에 앞쪽에 문자가 없어도됨.
# LIKE 연산자는 부분 문자열이 포함된 모든 필드를 검색.
# 반대 연산자는 NOT LIKE 이며 부분 문자열을 포함하지 않는 모든 필드를 검색.

SELECT * FROM tcity WHERE NAME LIKE '%홍%';

SELECT * FROM tcity WHERE NAME NOT LIKE '%천%'; # 이름에 "천"이 들어가지 않는 도시 다섯 개를 검색.
# 천이 아닌것만 뽑아내기

select * from tcity where name NOT LIKE '%오%';

SELECT * FROM tcity WHERE NAME LIKE '청%';
SELECT * FROM tcity WHERE NAME LIKE '천%';
# 천으로 시작하는 것을 찾아라 => 없음
# e.g ) 성이 홍씨인 사람만 불러와라 같은 경우에 사용함. 뒤에 %만 붙이는 경우. 첫글자 기준으로 뽑아내는 케이스.

SELECT * FROM tcity WHERE NAME LIKE '천%';
# 천으로 끝나는 글자만 출력
# 천안이 있다면 안나옴

# '천%'는 "천"으로 시작하는 도시를 찾음. 특정 문자로 시작하는 필드를 찾음. 
# '%천'는 "천"으로 끝나는 도시를 찾음. 특정 문자로 끝나는 필드를 찾음. 
# '%천'의 경우 처리하는 DBMS나 타입별로 차이가 있음.
# ex) '홍천 ' 공백 제거를 위해 아래와 같이 작성하기도 함
# SELECT * FROM tCity WHERE TRIM(name) LIKE '%천'

# 연습문제

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

### 5. BETWEEN  
# BETWEEN 최소값 AND 최대값 형식 => "BETWEEN 최소값 AND 최대값"
# BETWEEN A AND B
# BETWEEN A AND B 문은 "BETWEEN 최소값 AND 최대값" 형식으로 두 값 사이의 범위를 제한.
SELECT * FROM tcity WHERE popu BETWEEN 50 AND 100;

#위와 아래는 동일함
# 인구가 50 ~ 100만 사이의 도시를 구함
SELECT * FROM tcity WHERE popu >=50 AND popu <= 100;
SELECT * FROM tcity WHERE popu BETWEEN 50 AND 100;
# "~ 보다 크고 ~ 보다 작다" 조건의 조합이어서 AND 논리 연산자로 대체 가능.

# 한계
# BETWEEN ~ AND 문은 작은 값, 큰 값 순을 상식적이어 서 실수할 위험이 낮으며 구문 전체가 하나의 조건이 어서 가독성이 높음. 

# 그러나 시작과 끝 범위를 항상 포함하여 이상, 이하의 범위만 가능하며 
# 미만, 초과는 지정할 수 없는 활용성 의 한계가 있음.


# 범위 조건은 주로 수치 값에 사용하지만 문자열이나 날짜에도 사용 가능

SELECT * FROM tstaff WHERE NAME BETWEEN '가' AND '사';

SELECT * FROM tstaff WHERE joindate BETWEEN '20150101' AND '20180101';
# 결론
# BETWEEN 은 대소만 가릴 수만 있다면 어떤 타입이든지 >, < 부등비교가 가능하며 따라서 범위 검색도 가능하다.


# 1. 면적이 500 ~ 1000 사이의 도시목록을 조사하라.
# 2. 월급이 200만원대인 직원의 목록을 구하라.

#1 
SELECT * FROM tcity WHERE area BETWEEN 500 AND 1000;

#2 
SELECT * FROM tstaff WHERE salary BETWEEN 200 AND 299;


###  6. IN 
# BETWEEN 연산자는 연속된 범위만 검색할 수 있으며 불 연속적이고 임의적인 값 여러 개를 조사하기 어려움.
# 이에 비해 IN 연산자는 불연속적인 값 여러 개의 목록을 제공하여 이 목록 과 일치하는 레코드를 검색.

## IN 연산자는 불연속적인 값 여러 개의 목록을 제공하여 이 목록과 이리하는 레코드를 검색
# IN 연산자 뒤의 괄호 안에 콤마로 구분된 값 목록을 나열하여 이 중 하나에 해당하는지 점검.
# 값 개수에는 제한이 없어 얼마든지 많은 값을 넣을 수 있음.


# 경상도 이거나 전라도 인 지역
SELECT * FROM tcity WHERE region IN('경상','전라'); # region 필드가 '경상' 또는 '전라'인 모든 도시를 조 사.

# 위와 같음
SELECT * FROM tcity WHERE region ='경상' OR region = '전라';

# 값 리스트가 많은 경우 일일히 OR 연산자로 조건을 연 결하는 것보다 IN 연산자로 값만 나열하는 것이 짧고 읽기 쉬움. 
# 추후 값 리스트를 편집하기도 편해 관리상의 이점이 있음. 
# IN 연산자의 괄호 안에 목록을 직접 나열하는 것 보다 서브쿼리로 대상 목록을 조사해서 사용하는 경우가 많 음. 
# IN 연산자의 반대 조건은 NOT IN.

# 2개라서 쉬워 보이는데 10개 이상의 값을 찾아야 한다면?

SELECT * FROM tcity WHERE region NOT IN('경상','전라'); # 경상도와 전라도에 있지 않은 도시 목록을 조사

# 부분 문자열 여러 개 중 하나에 해당하는지 찾으려면 LIKE와 IN 연산자를 같이 써야 함.

# 하지만 LIKE 와 IN 결합은 안됨
# 이런 검색을 하고 싶으면 각각의 LIKE 조건을 OR 연산 자로 연결

SELECT * FROM tstaff WHERE NAME LIKE IN ('이%', '안%');

SELECT * FROM tstaff WHERE NAME LIKE '이%' OR NAME LIKE '안%';

SELECT * FROM tstaff WHERE (NAME LIKE '이%') OR (NAME LIKE '안%');

# 연습문제 
# 1. 총무부나 영업부에 근무하는 직원의 목록을 조사하라.
# 2. 총무부나 영업부에 근무하는 대리의 목록을 조사하라.
# 3. 차장급 이상의 여직원 목록을 조사하라.

SELECT * FROM tstaff WHERE depart IN('영업부','총무부') ;

SELECT * FROM tstaff WHERE depart IN('영업부','총무부') AND (grade='대리');

SELECT * FROM tstaff WHERE grade IN('부장') AND (gender ='여');
# 과장 < 차장 < 부장
