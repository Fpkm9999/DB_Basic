# 2024-02-06 데이터 추가/ 삭제 / 

# INSERT
# INSERT INTO 테이블 (필드목록) VALUES (값목록)
# INSERT INTO 가 함께 사용됨

# 새로운 레코드를 추가하는 명령. 
# INSERT 문을 스크립트로 작성해 놓으면 많은 데이터를 순차적으로 입력할 수 있어서 편리
# 마리아DB는 INTO 생략을 허용하지만 SQL 표준에는 INTO가 필수임. 생략하는 습관 ㄴㄴ
SHOW DATABASES;
SELECT * FROM tcity;
INSERT INTO tcity (NAME,AREA,popu,metro,region) VALUES ('서울',605,974,'y','경기');
# PRIMIARY KEY로 설정된 NAME 필드는 NULL 허용 X, 중복 허용 X

# 특징
# 필드명을 일일히 순서에 맞춰야함
# 생략하는 방법 => 2가지 있다 , 필드를 지우고 5개의 VALUE 개수와 순서를 맞추면됨

# 모든 필드를 선언 순서대로 삽입할 때는 필드 목록을 생략 할 수 있음.
INSERT INTO tcity VALUES ('평택',453,51,'n','경기');
INSERT INTO tcity VALUES ('서울',605,974,'y','경기');

# INSERT INTO 등 추가 삭제를 하면 아래에 영향 받은 행 로그를 잘봐야함(영향 받은 행이  있어야됨)
/* 영향 받은 행: 1  찾은 행: 0  경고: 0  지속 시간 1 쿼리: 0.016 초 */

# 간단하게 하는 방법은 필드 목록이 없는 대신 값 목록이 완전해야 하며 순서도 반드시 지 켜야 함

# ERROR CASE 

# 1개를 빼먹음
INSERT INTO tcity VALUES ('평택2',453,'n','경기');
/* SQL 오류 (1136): Column count doesn't match value count at row 1 */

# 순서가 틀림(타입이 틀려짐)
INSERT INTO tcity VALUES ('평택2',453,'n',51,'경기');
/* SQL 오류 (1366): Incorrect integer value: 'n' for column `db_test`.`tcity`.`popu` at row 1 */


# 되긴하는데 값이 들어가야 할 위치가 달라서 틀린 값이 들어감
# 오류가 안떠서 이런건 주의가 필요함
INSERT INTO tcity VALUES ('평택2',51,453,'n','경기');
# area와 popu 순서가 바뀜

# INSERT INTO 시 필드목록은 생략가능하다.
## 필드목록을 밝히면 순서를 바꿀 수 있다. ##

SELECT * FROM tcity;
INSERT INTO tcity (AREA,popu,metro,region,NAME) VALUES (605,974,'y','경기','서울');
# 이렇게도 가능함 프라이머리 키는 맨 뒤에 있는게 국룩옵션

# 요약
# 1. 필드 목록을 생략하지 말든가, 생략했다면 값 목록을 완벽하게 적는지 2개 중 하나를 선택.

# 연습
# 1. 도시 목록에 용인을 삽입하라. 면적 293에 인구 97만이되 데이터는 임의 값을 써도 상관없다
INSERT INTO tcity (NAME, AREA, popu, metro, region) VALUES ('용인',293,97,'y','경기');

# 2. 직원 목록에 자신의 신상을 삽입해 보라.
SELECT * FROM tstaff;
INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score) VALUES ('오세빈','인사과','남','2024-02-06','대리',350,65);

# 현재 날짜는 now() 함수로도 할 수있다. 시간까지 구해주는데 날짜까지만 쓰니까 경고 뜨는거라 상관없다.
INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score) VALUES ('정약전','인사과','남',NOW(),'과장',420,74.6);
INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score) VALUES ('정약전','인사과','남',CURRENT_DATE(),'과장',420,74.6);

# 확장 INSERT 문
# tcity 테이블로 실습을 하다가 원래대로 초기화 하고 싶다면 다음 명령으로 테이블을 싹 비움.
TRUNCATE TABLE tcity;

# 각 행마다 개별적으로 INSERT INTO 명령을 일일히 작성하면 쿼리문이 길어 번잡스러움.
INSERT INTO tcity (NAME, AREA, popu, metro, region) VALUES
('서울',605,974,'y','경기'),
('부산',765,342,'y','경상'),
('오산',42,21,'n','경기'),
('청주',940,83,'n','충청'),
('전주',205,65,'n','전라'),
('순천',910,27,'n','전라'),
('춘천',1116,27,'n','강원'),
('홍천',1819,7,'n','강원');

# 대량의 데이터를 삽입할 때는 더 편함.
# 백업을 복구하는 경우  속도는 개별보다 느림  (각 데이터마다 insrt into ~~r가 더 빠름)
 
# 원래는 각 필드마다 INSERT INTO ~ 로 시작했음.
# MySql에서 최초 도입했고 왠만한 DBMS에서는 지원하지만, 표준 SQL 문법은 아니고 오라클에서도 지원하지는 않음.

# 데이터의 갯수가 대략 10만개가 넘어서면 확장 INSERT 문 속도가 느려서 그때부터는 추천안함

# 1. 도시 목록에 이천(461 킬로미터, 21만)과 대구 (883 킬로미터, 248만), 영월 (1127킬로미터, 4만)을 삽입하라
SELECT * FROM tcity;

INSERT INTO tcity (NAME, AREA, popu, metro, region) VALUES
('이천',461,21,'n','경기'),
('대구',883,248,'y','경상'),
('영월',1127,4,'n','강원');


# 문제09.

# 1. 
SELECT * FROM 고객;
INSERT INTO 고객 (고객아이디,고객이름,나이,등급,직업,적립금) VALUES 
('strawberry','최유경',30,'vip','공무원',100);

# 2.
#
SELECT * FROM 고객;
INSERT INTO 고객 (고객아이디,고객이름,나이,등급,적립금) VALUES 
('tomaro','정은심',36,'gold',4000);

### 4. INSERT SELECT

# INSERT 명령은 한번에 하나의 레코드만 삽입하지만, 다른 테이블 또는 자기 자신에게 
# 이미 저장되어 있는 대량의 정보를 복사할 때는
# 조사한 결과셋을 한꺼번에 삽입할 수 있음.

# 기본형 : INSERT INTO 대상테이블 (필드목록) SELECT 필드목록 FROM 원본테이블

# 다른점
# INSERT INTO 와 기본 형식은 비슷하지만 필드의 값을  VALUE 절로 지정하지 않고 SELECT 명령으로
# 다른 테이블에서 읽어온다는 점이 다름.
# 별도의 문법이라기 보다는 INSERT INTO 에 SELECT 명령이 포함된 형식.
INSERT INTO tstaff (NAME, depart, gender, joindate, grade, salary, score)
SELECT NAME, region, metro, '20210629', '신입', AREA, popu FROM tcity WHERE region = '경기';

# 필드 명의 숫자, 데이터 타입이 맞아야됨

### 5.CREATE SELECT

CREATE TABLE tSudo AS SELECT name, AREA, popu FROM tcity WHERE region ='경기';
# 경기도 지역의 도시만으로 tSudo 테이블을 생성.
SELECT * FROM tsudo;
# 테이블을 새로 만들면서 기존 테이블의 일부 필드와 레코드를 가져와 삽입하는 명령이어서
# 대상 테이블이 존재하면 안됨

# tstaff 테이블에 대량의 변경을 가해야 하는데 불안할 경우 다음 명렁으로 복사를 뜸.
CREATE TABLE tstaff_backup_20240206 AS SELECT * FROM tstaff;
# 대게 백업을 해서 그 백업본으로 테스트 하는 경우가 있음
# 백업은 여러번 뜰 수 있어서 관행상 날짜를 명시.
# 혹시 잘못 조작해서 데이터가 의도와 다르게 손상이 되었으면 백업에서 데이터를 가져오고,
# 이상이 없으면 적당한 때에 백업을 삭제하면 됨.
# 백업본 특징이 기본키 속성은 가지고 오지 못함.


# 연습 문제
# 1. 성취도가 80점 이상인 직원만 골라 이름과 월급에 대한 보고서를 별도의 테이블로 작성하라.
SELECT * FROM tstaff;

CREATE TABLE tstaff_backup_20240206_2 AS SELECT NAME,salary FROM tstaff WHERE score>=80;

CREATE TABLE tstaff_backup_20240211_1 AS SELECT NAME,salary FROM tstaff WHERE score >=80;