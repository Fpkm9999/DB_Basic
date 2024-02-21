
# 2024-02-15
use testdb;
create database sample_java;
use sample_java;
show tables ;

use testdb;
show tables ;
insert into tproject values (7,'홍길동','원자재 매입', 900);
select * from tproject;
select * from temployee;
drop table tproject;
create table tproject (
    projectID int primary key ,
    employee char(10) not null,
    project varchar(30) not null,
    cost int,
    constraint FK_emp FOREIGN KEY(`employee`) REFERENCES `temployee`(`name`)
);
INSERT INTO `tProject` VALUES (1, '김상형', '홍콩 수출건', 800);
INSERT INTO `tProject` VALUES (2, '김상형', 'TV 광고건', 3400);
INSERT INTO `tProject` VALUES (3, '김상형', '매출분석건', 200);
INSERT INTO `tProject` VALUES (4, '문종민', '경영 혁신안 작성', 120);
INSERT INTO `tProject` VALUES (5, '문종민', '대리점 계획', 85);
INSERT INTO `tProject` VALUES (6, '권성직', '노조 협상건', 24);

insert into tproject values (7,'홍길동','원자재 매입',900);  # 삽입 안됨

delete from temployee where name = '김상형'; # 삭제 안됨
# 제약조건을 걸어서 상속 관계처럼 작용함. temployee(부모)는 아무것도 안했고 tproject에서 제약조건을 검(자식)
                                          # 그렇다면 외래키 제약조건이 있는 상태에서 값을 삽입하거나 삭제하고 싶다면?

# insert into
insert into temployee values ('홍길동',330,'장성');
insert into  tproject values (7,'홍길동','원자재 매입',900);

# 직원을 먼저 등록해야 이 직원에게 프로젝트를 맡길 수 있음. 순서가 바뀌면 안됨
select * from tproject;
select * from temployee;
delete from tproject where employee = '김상형';
delete from temployee where name = '김상형';

# 3. 연계 참조 무결성 제약
# 외래키 제약이 너무 강력해서 가끔 불편할 때가 있음.
# 제약 조건이 걸린거를 삭제 삽입시 관련된 테이블도 자동으로 삽입 삭제 되도록 하는 것

# 문법
# ON DELETE ~
# ON UPDATE ~~

create table tproject (
                          projectID int primary key ,
                          employee char(10) not null,
                          project varchar(30) not null,
                          cost int,
                          constraint FK_emp FOREIGN KEY(`employee`) REFERENCES `temployee`(`name`)
                          on delete cascade on update cascade
);


INSERT INTO `tProject` VALUES (1, '김상형', '홍콩 수출건', 800);
INSERT INTO `tProject` VALUES (2, '김상형', 'TV 광고건', 3400);
INSERT INTO `tProject` VALUES (3, '김상형', '매출분석건', 200);
INSERT INTO `tProject` VALUES (4, '문종민', '경영 혁신안 작성', 120);
INSERT INTO `tProject` VALUES (5, '문종민', '대리점 계획', 85);
INSERT INTO `tProject` VALUES (6, '권성직', '노조 협상건', 24);

delete from temployee where name = '김상형';


INSERT INTO `tProject` VALUES (1, '김상형', '홍콩 수출건', 800);
INSERT INTO `tProject` VALUES (2, '김상형', 'TV 광고건', 3400);
INSERT INTO `tProject` VALUES (3, '김상형', '매출분석건', 200);

select * from temployee;


select * from tproject;

USE sample_java;
SELECT * FROM tuser;
SELECT * FROM tuser WHERE userID ='fpkm3033';
SELECT COUNT(*) FROM tUser WHERE userID ='fpkm3033';
SHOW TABLES;

SHOW DATABASES;
USE sample_java;
SHOW TABLES;
SELECT * FROM tuser;
 int rows = preparedStatement.executeUpdate(); // executeUpdate() 을 호출하면 sql 문이 실행.  // 수행결과로 int 타입의 값을 반환 (처리된 레코드(row)의 개수)

INSERT INTO tUser (userID, name, age, job) VALUES ('fpkm123456','김문수',26,'job1')

DELETE FROM tUser WHERE userID='fff';