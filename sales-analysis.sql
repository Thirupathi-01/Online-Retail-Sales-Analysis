create database online_sales;
use online_sales;

# Table creations

create Table If not exists Customers(
    customer_id int PRIMARY KEY,
    customer_name varchar(50),
    city varchar(50)
);
create table If not exists Products(
    product_id int PRIMARY KEY,
    product_name varchar(50),
    category varchar(50),
    price int
);
create table if not exists Orders(
    order_id int PRIMARY KEY,
    customer_id int,
    order_date date,
    Foreign Key (customer_id) references Customers(customer_id)
);
create table if not exists Order_Items(
    order_id int,
    product_id int,
    quantity int,
    Foreign Key (order_id) REFERENCES Orders(order_id),
    Foreign Key (product_id) REFERENCES Products(product_id)
);

# Data insertions

Insert into customers values
(1,'Thirupathi','Dindigul'),
(2,'Rajesh','Madurai'),
(3,'Mathan','Theni'),
(4,'Raj','Coimbatore'),
(5,'Tharun','Cuddalore'),
(6,'Prem','Tirunelveli');
Insert into products values
(1000,'laptop','Electronics',15000),
(1001,'keyboard','Electronics',20000),
(1002,'Mouse','Electronics',5000),
(1003,'Mobile phone','Electronics',1000),
(1004,'shoes','Fashion',25000),
(1005,'Watch','Accessories',10000),
(1006,'T-shirt','Fashion',12500),
(1007,'Bag','Accessories',7500),
(1008,'Bat','Sports',3500),
(1009,'Helmet','Sports',7520);


Insert into Orders values 
(11,1,'2026-01-01'),
(12,2,'2026-04-05'),
(13,3,'2026-07-07'),
(14,4,'2026-03-10'),
(15,3,'2026-11-13'),
(16,5,'2026-08-17'),
(17,2,'2026-12-21'),
(18,1,'2026-06-25');
Insert into order_items values 
(11,1001,2),
(11,1004,1),
(12,1000,2),
(12,1003,1),
(13,1006,3),
(14,1002,7),
(15,1005,3),
(16,1007,6),
(16,1001,4),
(16,1002,2),
(17,1003,2),
(18,1005,1),
(18,1007,8),
(13,1002,2),
(13,1003,2),
(12,1008,1),
(15,1009,3),
(17,1008,5);

#Top selling product
select P.product_id,P.product_name,sum(O.quantity*P.price) as total
from order_items as O 
join products as P on O.product_id=P.product_id
group by P.product_id
order by total desc;

#most valuable customer
select C.customer_id,C.customer_name,sum(OI.quantity*P.price) as total
from Customers as C 
join Orders as O on C.customer_id=O.customer_id 
join Order_Items as OI on O.order_id=OI.order_id
join Products as P on OI.product_id=P.product_id
group by c.customer_id,C.customer_name
order by total desc;

#Monthly Revenue Calculation
select DATE_FORMAT(O.order_date,'%Y-%m') as mon, sum(OI.quantity*P.price) as revenue
from orders as O 
join order_items as OI on OI.order_id=O.order_id
join Products as P on P.product_id=OI.product_id
group by mon
order by mon;

#Category-wise sales analysis
select P.category,P.product_name,sum(P.price*OI.quantity) as sales
from order_items as OI 
join products as P on P.product_id=OI.product_id
group by P.category,P.product_name
order by sales desc;

Insert into customers values
(7,'Dhinesh','Chennai');

#Inactive customers
select  C.customer_id,C.customer_name,C.city
from customers as C
left join Orders as O on C.customer_id=O.customer_id
where O.order_id is null;