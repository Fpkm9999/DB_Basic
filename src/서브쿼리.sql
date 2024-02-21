### 1. 무결성 관리

# 세상에 완벽한 것이 없듯이 데이터베이스나 그 안에 저장된 데이터도 항상 완벽할 수 없음.
# 모든 데이터가 결합없이 완벽한 상태를 무결성 Intergrity 이라고 함.
# 데이터베이스 관리 시스템은 무결성을 지키기 위해 최선의 노력을 하며
# 그래서 이전의 단순한 정보 저장 방식과 차원이 다름.

# 데이터 무결성을 지켜내는 것을 참조 무결성이라고 함.

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
# 생략시employees 자동 적용되는 기본값이 있으면 항상 NULL 은 아닐거라고 오해할 수 잇음.
# 그러나 기본값이 지정되어 있더라도 NULL을 직접 입력할 수 잇고
# UPDATE 명령으로 NULL로 바꿀 수도 있음.
# 기본값은 생략시 적용할 값일 뿐이지 NULL 허용 여부까지 통제하는 것은 아님.


# 2024 - 02 - 08
# 1. 직원 테이블의 각 필드에 기본값을 적용하여 tStaffDefault 테이블을 생성하라.
# 부서는 영업부, 직급은 수습, 초봉은 280, 성취도는 1.0 의 기본값을 적용하라.
CREATE TABLE tStaffDefault(
depart CHAR(10) DEFAULT '영업부' NOT null,
grade  CHAR(10) DEFAULT 280 NOT null,
score DECIMAL(5,2) DEFAULT 1.0 NOT null
);

CREATE TABLE  `tStaffDefault` (
  `NAME` char(15) NOT NULL,
  `depart` char(10) DEFAULT('영업부') NULL,
  `gender` char(3) NOT NULL,
  `joindate` date NOT NULL,
  `grade` char(10) NOT  NULL,
  `salary` int(11) DEFAULT(280) NULL,
  `score` decimal(5,2) DEFAULT(1.0) NULL,
  PRIMARY KEY (`NAME`)
) ;

### 4. 체크
# 체크 제약은 필드의 값 종류를 제한
# 모든 속성은 유의미한 범위가 있고 상식적으로 가능한 값과 그렇지 않은 값이 있음.
# 예를 들어 도시가 아무리 거대해도 인구 100억을 넘길 수는 없고 면적이 음수가 될 수 없음.
# 체크 제약은 이런 무의미한 값을 걸러냄.

# 타입은 물리적인 형식을 점검하는데 비해 체크는 논리적인 값의 형식을 점검.
# 필드 선언문에 CHECK 키워드와 함께 필드값으로 가능한 값을 조건문으로 지정.
# WHERE 절의 조건을 지정하는 모든 문법을 쓸 수 있음.
# 테스트를 위해 간단한 테이블을 생성.

CREATE TABLE tCheckTest (
	gender CHAR(3) NULL CHECK(gender = '남' OR gender ='여'),
	grade INT NULL CHECK (grade >=1 AND grade <= 3),
	origin CHAR(3) NULL CHECK(origin IN ('동','서','남','북')),
	NAME CHAR(10) NULL CHECK(NAME LIKE '김%')
);

INSERT INTO tchecktest (gender) VALUES ('여'

);
INSERT INTO tchecktest (grade) VALUES (1);
INSERT INTO tchecktest (origin) VALUES ('동');
INSERT INTO tchecktest (NAME) VALUES ('김좌진');tcity2

# 2024-02-08
show databases;
show tables;
select * from book;
SELECT 제품명, 제조업체 FROM 제품 WHERE 제품번호
                                   NOT IN (SELECT 주문제품 FROM 주문 WHERE 주문고객 = 'banana');
# 주문한 도서 중에서 가격이 10000원을 초과하는 도서의 주문번호(orderId), 고객 이름(name), 도서 이름(bookName), 판매 가격(salePrice)를 출력하시오.
show tables ;
select * from tchecktest;

insert into tchecktest (gender) values ('노');   # 남과 여만 입력 가능
insert into tchecktest (grade) values (0);  # 1에서 3사이만 입력 가능
insert into tchecktest (origin) values ('중'); # 동, 서, 남, 북 만 입력 가능
insert into tchecktest (name) values  ('정산리'); # 김씨만 입력가능

# 삽입할 때 뿐만 아니라 UPDATE 할 때도 체크 제약 조건을 점검.
# 직원 테이블의 각 필드에 제약 조건을 설정하여 부서는 '영업부', ' 총무부', '인사과' 중 하나만, 성별은 남 아니면 여로 제한하고
# 월급은 0보다 크다는 조건만 설정하라.
CREATE TABLE  testStaff02 (
                                  `NAME` char(15) NOT NULL,
                                  `depart` char(10) null check (depart in ('영업부','총무부','인사과') ),
                                  `gender` char(3) NULL check ( gender in ('남','여') ),
                                  `joindate` date NOT NULL,
                                  `grade` char(10) NOT NULL,
                                  `salary` int(11) NULL check ( salary> 0 ),
                                  `score` decimal(5,2) NULL,
                                  PRIMARY KEY (`NAME`)
) ;
select * from teststaff02;

SELECT * FROM tcitydefault;
insert into teststaff02 (name, depart, gender, joindate, grade, salary, score) VALUES ('박지성','영업부','남',current_date(),'과장',
                                                                                       100,0.9);
select * from teststaff02;
select * from book;

# PrimaryKey

# titem 테이블 사용.  상점에서 상품명이 사과를 제일 많이 구매한 회원 정보 전부를 가져오시오.

select member, age, email, addr, money, grade, remark from tmember where member =
(select member from torder where item =
(select item from titem where item='사과'));

### 1. 식별자
# 테이블의 특정 레코드를 읽거나 변경하려면 레코드끼리 구분할 수 있는 고유의 키 (=식별자)가 필요.
# 키는 1) 값이 꼭 있어야 하며, 2) 구분을 위해 고유값을 가져야 함
# 적합 여부는 고유값을 가질 수 있는 지 여부임

# 조건을 만족하는 필드를 후보키 Candidate Key 라고 하며 한 테이블에 여러 개의 후보키가 있음.
# 이 중 '레코드를 가장 잘 대표하는 키 하나를 골라 기본키 Primary key' 로 선정.
# 짧게 줄여 PK 라고 부름
# 기본키는 물리적인 조건 외에도 다음 조건을 만족해야 함.

# 1) 대표성 : 레코드를 상징하는 값이어야 한다.
# 2) 자주 참조하는 속성 : 기본키에는 기본적으로 인덱스가 생성되어 검색 효율이 좋다. << 생각보다 차이크다. # where 뒤에 자주 사용되는 컬럼들은 인덱스 걸어줘야함
#       >>자주 사용되는 것들 : 외래키, 조인에서 사용되는 것들 등
# 3) 가급적 짧은 속성 : 테이블 간의 연결고리가 되므로 비교 속도가 빨라야 한다.

# 이메일의 경우 소유를 강제하면 기본키로 사용가능 하고, 회원 목록 테이블이라면 회원 ID가 가장 적합한 기본키.
# 회원은 반드시 ID가 있어야 하고 같은 ID를 가지는 회원은 둘 이상 존재하지 않음.

# tCity는 도시명인 name 이 기본키 이며 다음 쿼리문은 에러가 뜸.

select * from tcity;
insert into tcity values ('춘천',116,27,'n','강원');
# [23000][1062] (conn=15) Duplicate entry '춘천' for key 'PRIMARY'
# 이미 있는 기본 키값을 넣어서 안된다.

# 춘천이 테이블에 이미 있는데 또 삽입하면 어떤 레코드가 진짜 춘천에 대한 정보인지 구분할 수 있음.
# 모호함이 생기면 무결성이 깨지므로 기본키에 대해서는 중복을 허락하지 않음.

# DBMS는 기본키를 특별하게 관리한다.
# NULL 금자와 중복 방지는 물론이고 인덱스를 생성하여 검색 속도를 높임.
# 기본키는 검색시 조건문에 활용하며 테이블간의 관계를 구성하는 연결고리로 사용.
            # e.g) where 뒤에                   #  e.g ) join
### 2. 기본키 설정
# 제약을 선언하는 위치에 따라 컬럼 제약과 테이블 제약이 있음.
# 컬럼 제약은 컬럼 선언 뒤에 위치하며 테이블 제약은 모든 컬럼 선언이 끝난 후 마지막 위치에 옴.

# create table 테이블
# (
#     필드 선언, # < - 이 위치에 오면 컬럼 제약
#     필드 선언,
#     필드 선언,
#     <- 이 위치에 오면 테이ㅡㅂㄹ 제약
# );

# NULL 허용 여부나, 기본값 등 컬럼에 대한 속성은 컬럼 제약으로 지정.
# 기본키는 컬럼 제약으로 선언할 수 도 있고 테이블 제약으로 선언할 수도 있음.
# 각 제약의 형식은 다음과 같음

# 컬럼 기본키 제약 : [CONSTRAINT 이름] PRIMARY KEY
# 테이블 기본키 제약 : [CONSTRAINT 이름] PRIMARY KEY (대상 필드)

# PRIMARY EKY 제약은 NOT NULL 속성을 겸함.
# 제약의 이름을 생략하면 서버가 자동으로 이름을 붙임.

create table tCity2
(
    name CHAR(10),      # 컬럼 기본키 제약
    area int null ,
    popu int null,
    metro char(1) not null,
    region char(6) not null,
    constraint pk_tCity_name primary key (name) # 테이블 기본키 제약 위치
);
# 필드 선언문에 PRIMARY KEY 속성을 지정하는 컬럼 제약이 간단하지만,
# 여러 필드를 묶어 복합키로 지정하거나 외래키를 지정할 때는 테이블 제약을 사용.

### 3. 복합키
# 기본키가 꼭 하나여야 할 것은 없다.
# 기본키가 꼭 하나여야 한다는 법은 없으며 하나의 필드만으로 레코드를 특정하기 어려운 경우가 있음.
# iCity 테이블의 경우, 도시명이 중복되지 않는다는 가정을 하고 있지만 현실은 다름.

# 경기도 광주, 전라도 광주 처럼 도시 이름이 중복되는경우가 있는데 iCity  테이블의 구조로는 두 도시를 모두 입력할 수 없음

# 이름만으로 도시를 특정할 수 없으니 지역과 함께 묶어서 기본키로 정의해야 함.
# 이처럼 두 개 이상의 필드를 묶어 기본키로 지정하느 ㄴ것을 복합키(Composite Key)라고 함.
# name, region 두 개의 필드에 PRIMARY KEY를 지정하면 에러가 남.

create table tCity3
(
    name CHAR(10) primary key ,    # 컬럼 기본키 제약
    region char(6) primary key ,
    area int null ,
    popu int null,
    metro char(1) not null
);
 # [42000][1068] (conn=15) Multiple primary key defined # 한 테이블에 기본키는 1개만 된다. 복합키는 2개의 조합을 하나의

create table tCityCompoKey
(
    name CHAR(10) not null ,   # 컬럼 기본키 제약
    region char(6) not null ,
    area int null ,
    popu int null,
    metro char(1) not null,
    constraint PK_tCity_name_region primary key (name, region)  # 테이블 기본키를 통해 복합키 설정
);
select  * from tcitycompokey;

insert into tcitycompokey values ('광주','전라',123,456,'y');
insert into tcitycompokey values ('광주','경기',123,456,'n');
# 복합키로 설정된 필드가 다 겹치면 안된다.
insert into tcitycompokey values ('광주','경기',123,456,'n');
insert into tcitycompokey values ('광주1','경기',123,456,'n');

insert into tcitycompokey values ('광주','전라',123,456,'y');
insert into tcitycompokey values ('광주','전라',123,456,'n');
# 키 중복으로 판단하는 기준 : 복합키로 설정된 조합이 같으면, primary key가 중복되면 안된다.

# 복합키도 중복을 허용하지 않지만 복합키를 구성하는 개별키는 중복해도 무방.
# 두 필드가 동시에 같지만 않으면 됨.

### 4. 유니크
# 유니크 UNIQUE 제약은 필드의 중복값을 방지하여 모든 필드가 고유한 값을 가지도록 강제.
# 기본키 제약과 유사하지만 몇 가지 차이점은 있음.
# 1) 기본키는 NULL을 허용하지 않지만 '유니크는 NULL을 허용'. 단 NULL 끼리도 중복 할 수 없어 딱 하나의 NULL 만 존재할 수 있음.
# PRIMARY KEY와 유사하지만 차이점은 있다
# 2) UNIQUE와 NOT NULL을 동시에 지정하면 기본키와 유사해짐.
# 그러나 기본키는 테이블당 하나만 지정할 수 있지만 '유니크는 개수에 상관없이 얼마든지 지정 가능'.
# 3) 기본키는 자동으로 인덱스를 생성하여 레코드의 정렬 순서를 결정하지만 유니크는 그렇지 않음.
# 인덱스를 생성하더라도 기본키의 인덱스와는 종류와 효율이 다름.
# 유니크는 기본키를 보조하는 중복 방지 제약.
# 만일 tCity 테이블들이 도시끼리 인구수가 같아서는 안된다는 규칙이 있다면 popu 필드에 대해 UNIQUE 제약을 설정.

# e.g)
create table tCityUnique(
    name char(10) primary key ,
    area int null,
    popu int null,
    metro char(1) not null,
    region char(6) not null,
    constraint Unique_tCity_area_popu UNIQUE (area,popu)
);
# 이 테이블의 도시는 이름이 고유해야 하며 area 와 popu 가 모두 같아서는 안됨. 둘 중 하나라도 달라야 함.
show schemas ;
use world;
use testdb;

### 1. 일변번호 필드
# 기본키는 레코드의 유일성을 보장할 뿐만 아니라 관계를 형성하는 중요한 역할.
# 그래서 웬만한 테이블에는 기본키를 지정하는 것이 보통.
# 그러나 기본키가 강제 규정은 아니어서 의무적으로 만들어야 하는 것은 아님.
# 또한 기본키로 쓸만한 마땅한 필드가 없는 경우도 있음.

# 다음은 슈퍼마켓의 매출 데이터이며 누가 어떤 상품을 구매했는지 기록.

# 기본키로 지정하기 힘든 상황도 나올 수 있다.

# 해결방법
# 일련번호를 붙인다.
# 정없다면 억지로라도 기본키를 만드는 것이 좋은데 이떄 유용한 값이 일련반호.
# 계속 증가하는 일련번호를 붙이면 NULL도 아니고 고유성도 부여할 수 있음.

# 일련번호를 라벨링을 하는 경우가 많음(기본키로 지정할게 없으면)

# 5. AUTO_INCREMENT <- 자동 일련번호 생성과 같음.
# MariaDB는 시퀀스를 지원하지 않음.
# 대신 IDENTITY 와 거의 유사한 AUTO_INCREMENT 구문을 지원.
# 필드 선언문에 AUTO_INCREMENT 라고 선언하면 자동 증가하는 일련번호가 매겨짐.
create table tSale
(
    saleno INT AUTO_INCREMENT primary key ,
    customer NCHAR(10),
    product NCHAR(30)
); # 백엔드 개발에서 많이 사용한다.

insert into tsale (customer, product) VALUES ('단군','지팡이'); # AUTO_INCREMENT는 기본키 넣은것과 같아서 필수값인데도 필수로 입력을 안해도 문제없음
insert into tsale (customer, product) VALUES ('고주몽','고등어');
select * from tsale;

# 특정한데이터를 기본키로 지정해야 수정 삭제할때 문제가 없다
# 기본키로 지정할만한게 없다면 AUTOINCREMENT + 기본키로 일련번호를 기본키로 설정하는게 국룰

# 만약 2번 값을 지우고 데이터를 입력한다면? 고주몽
delete from tsale where saleno = 2;
insert into tsale (customer, product) VALUES ('박혁거세','계란');

# 시퀀스나 IDENTITY와 마찬가지로 삭제한 일련번호는 재사용하지 않음.
# 2번을 지운 후 사용하면 3번으로 들어감.

# 지웠던 일련번호에 다시 값을 넣는 행위는 가능은 하다 # 이때는 AUTOINCREMENT 값 증가는 안함
INSERT INTO tsale (saleno,customer, product) VALUES (2,'고주몽','고등어');

# 일련번호를 특정값으로 리셋할 때는 ALTER 명령을 사용.
# 일련번호를 리셋하면 이후
ALTER TABLE tsale auto_increment = 100;

# 최후 값을 알아낼 떄는 LAST_INSERT_ID() 함수를 사용.
# 다음 명령은 왕건이 구입한 너구리의 구매 기록을 찾아 짜파게티로 변경.
insert into tsale (customer, product) values ('왕건','너구리');
update tsale set product = '짜파게티' where saleno = last_insert_id();

### 1. 조인의 정의
# 서브쿼리보다 조인을 더 많이 사용함
create table tCar
(
    car varchar(30) not null,   # 이름
    capacity int not null , # 배기량
    price int not null ,     # 가격
    maker varchar(30) not null # 제조사
);
insert into tcar (car, capacity, price, maker) VALUES ('소나타',2000,2500,'현대');
insert into tcar (car, capacity, price, maker) VALUES ('티볼리',1600,2300,'쌍용');
insert into tcar (car, capacity, price, maker) VALUES ('A8',3000,4800,'Audi');
insert into tcar (car, capacity, price, maker) VALUES ('SM5',2000,2600,'삼성');

create table tMaker
(
    maker varchar(30) not null , # 회사
    factory char(10) not null , # 공장
    domestic char(1) not null # 국산 여부. Y/N
);

insert into tmaker (maker, factory, domestic) VALUES ('현대','부산','y');
insert into tmaker (maker, factory, domestic) VALUES ('쌍용','청주','y');
insert into tmaker (maker, factory, domestic) VALUES ('Audi','독일','n');
insert into tmaker (maker, factory, domestic) VALUES ('기아','서울','y');

select * from tcar;
select * from tmaker;

### 2. 단순 조인

    select * from tCar, tmaker;

## 3개의 데이터 가 같다

select * from tcar, tmaker where tCar.maker = tMaker.maker;


select bookName from book where publisher in (
                              select publisher from book group by publisher having max(price)
                               > avg(price) ) having max(price);


