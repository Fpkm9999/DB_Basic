
# 1) 모든 도서의 이름과 가격을 검색하시오.
SELECT bookName,price from book;
# 2) 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
select bookId, bookName, publisher, price from book;
#3) 도서 테이블에 있는 모든 출판사를 검색하시오.
select distinct publisher from book;
# 4) 가격이 20,000원 미만인 도서를 검색하시오.
select * from book where price <20000;
# 5) 가격이 10,000원 이상 20,000원 이하인 도서를 검색하시오.
select * from book where price between 10000 and 20000;

# 6) 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.
select * from book where publisher in('굿스포츠','대한미디어');
# 7) 도서이름에 '축구'가 포함된 출판사를 검색하시오.
select bookName,publisher from book where bookName like '%축구%';
# 8) 도서이름에 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
select * from book where bookName like '_구%';
# 9) 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
select * from book where price >=20000 and bookName like '%축구%';
# 10) 도서를 이름순으로 검색하시오.
select * from book order by bookName;

# 11) 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
select * from book order by price, bookName;
# 12) 도서를 가격의 내림차순으로 검색하시오. 가격이 같다면 출판사를 오름차순으로 출력하시오.
select * from book order by price desc , publisher asc;
# 13) 고객이 주문한 도서의 총판매액을 구하시오.
select sum(salePrice) from orders;

# 14) 2번 김연아 고객이 주문한 도서의 총판매액을 구하시오.
select sum(salePrice) from orders where customerId=2;

# 15) 고객이 주문한 도서의 총판매액, 평균값, 최고가, 최저가를 구하시오.
select sum(salePrice) as `총판매액`, avg(salePrice) as`평균값`, max(salePrice) as `최고가`, min(salePrice) as `최저가` from orders ;

# 16) 서점의 도서판매 건수를 구하시오.
select count(*) from book;

# 17) 고객별로 주문한 도서의 총수량과 총 판매액을 구하시오.
select customerId,count(orderId) as `도서수량`, sum(salePrice) as `총액` from orders group by customerId;

# 18) 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량을 구하시오.
select customerId,count(orderId) as `도서수량` from orders where salePrice>=8000 group by customerId having `도서수량` >=2;

-- 단, 2권 이상 구매한 고객에 대해서만 구하시오.

# 19) 가장 비싼 가격으로 판매된 도서의 이름을 나타내시오.
select bookName from book where bookId = (
select bookId from orders where salePrice = (
select max(salePrice) from orders));

# 20) 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
select name from customer where customerId in (
select distinct customerId from orders);

# 21) 대한미디어에서 출판한 도서를 구매한 고객의 이름을 나타내시오.
select name from customer where customerId = (
select distinct customerId from orders where bookId in (
select bookId from book where publisher ='대한미디어' ));

# 22) 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.

select bookName from book where price in(
select max(price) from book group by publisher having publisher in (
                              select publisher from book group by publisher having max(price)
                               > avg(price) )) ;



#23) Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 한솔의학서적에서 출간했으며 가격은 90,000원임.
insert into book (bookId,bookName,publisher,price) values (11,'스포츠 의학','한솔의학서적',90000);

# 24) Book 테이블에 새로운 도서 '스포츠 의학 2판'을 삽입하시오. 한솔의학서적에서 출간했으며 가격은 미정임.
insert into book (bookId,bookName,publisher) values (12,'스포츠 의학2','한솔의학서적');

# 25) Customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오.

UPDATE customer SET address='대한민국 부산' WHERE customerId=5;

#26) Book 테이블에서 도서번호가 11인 도서를 삭제하시오.

DELETE FROM book WHERE bookId = 11;