-- restaurant database
-- 5 tables
-- write 3-5 queries
-- 1 x WITH
-- 1 x SUBQUERY
-- 1 x Aggregate function+JOIN

.open restaurant.db
.mode column
.header on

DROP TABLE menus;
DROP TABLE customers;
DROP TABLE paymentMethods;
DROP TABLE staffs;
DROP TABLE orders;
DROP TABLE orderItems;

-- table1
CREATE TABLE menus (
menu_id int,
menu_name text,
menu_price int
);
INSERT INTO menus values
(1, 'beef burger', 150),
(2, 'fish burger', 130),
(3, 'pork burger', 120),
(4, 'chicken burger', 120),
(5, 'mushroom burger', 100);

-- table2
CREATE TABLE customers (
customer_id int,
customer_name text,
country text
);
INSERT INTO customers values
(1, 'Tim', 'UK'),
(2, 'Paul', 'USA'),
(3, 'Julia', 'France'),
(4, 'Maggie', 'UK'),
(5, 'Natalie', 'USA');

-- table3
CREATE TABLE paymentMethods (
payment_method_id int,
payment_method_des text
);
INSERT INTO paymentMethods values
(1, 'Cash'),
(2, 'QRCode'),
(3, 'CreditCard');

-- table4
CREATE TABLE staffs (
staff_id int,
staff_name text,
position text
);
INSERT INTO staffs values
(1, 'Ellen', 'Manager'),
(2, 'Robert', 'Junior'),
(3, 'Jack', 'Junior');

-- table5
CREATE TABLE orders (
order_id int,
customer_id int,
payment_method_id int,
staff_id int,
order_date text
);
INSERT INTO orders values
(1, 1, 1, 1, '2023-01-09'),
(2, 2, 1, 2, '2023-01-12'),
(3, 3, 2, 3, '2023-01-15'),
(4, 4, 3, 1, '2023-01-20'),
(5, 1, 1, 3, '2023-01-20'),
(6, 3, 2, 3, '2023-01-20'),
(7, 5, 1, 2, '2023-01-25'),
(8, 3, 2, 1, '2023-01-26'),
(9, 4, 3, 3, '2023-01-26');

-- table6
CREATE TABLE orderItems (
orderItem_id int,
menu_id int,
n_item int,
total_price int,
order_id int
);
INSERT INTO orderItems values
(1, 1, 1, 150, 1),
(2, 2, 1, 130, 2),
(3, 3, 1, 120, 2),
(4, 5, 1, 100, 3),
(5, 1, 1, 150, 4),
(6, 1, 2, 300, 5),
(7, 2, 1, 130, 6),
(8, 4, 1, 120, 7),
(9, 2, 2, 260, 8),
(10, 1, 1, 150, 9);

SELECT * FROM menus;
SELECT * FROM customers;
SELECT * FROM paymentMethods;
SELECT * FROM staffs;
SELECT * FROM orders;
SELECT * FROM orderItems;

--1st query: How much total revenue by menu?
-- (JOIN+AggregateFunction+GROUPBY+ORDERBY)
SELECT
menus.menu_id,
menus.menu_name,
SUM(orderItems.total_price) total_rev
FROM orderItems
JOIN menus ON orderItems.menu_id = menus.menu_id
GROUP BY 2
ORDER BY 1;

--2nd query: How much total revenue by each day?
-- (JOIN+AggregateFunction+GROUPBY)
SELECT
orders.order_date,
SUM(orderItems.total_price) AS totalRev
FROM orderItems
JOIN orders ON orderItems.order_id = orders.order_id
GROUP BY orders.order_date;

-- recheck total revenue
SELECT SUM(totalRev)
FROM (SELECT
orders.order_date,
SUM(orderItems.total_price) AS totalRev
FROM orderItems
JOIN orders ON orderItems.order_id = orders.order_id
GROUP BY orders.order_date);

SELECT SUM(total_price) FROM orderItems;

--3rd query: On 20th Jan, which menu is the most popular selling?
-- Ans: beef burger
-- Create table for only 20th Jan orders / use WITH
WITH order20thJan AS (SELECT
order_id,
order_date
FROM orders
WHERE order_date = '2023-01-20')

SELECT
menus.menu_id,
menus.menu_name,
SUM(orderItems.n_item) sum_n_selling
FROM order20thJan
JOIN orderItems ON order20thJan.order_id = orderItems.order_id
JOIN menus ON menus.menu_id = orderItems.menu_id
GROUP BY menus.menu_name
ORDER BY 3 DESC;

--4th query: Who is top spending client in Jan?
--Ans: Julia
--Subquery+JOIN+AggregateFunction
SELECT
name,
MAX(total_spend)
FROM (SELECT
customers.customer_name AS name,
SUM(orderItems.total_price) AS total_spend
FROM orders
JOIN customers ON customers.customer_id = orders.customer_id
JOIN orderItems ON orders.order_id = orderItems.order_id
GROUP BY 1);

--5th query: Which payment method is the most popular (consider by no. of transaction)?
-- Ans: Cash
SELECT
payment_method_id,
COUNT(payment_method_id)
FROM orders
GROUP BY payment_method_id;

SELECT paymentMethods.payment_method_des
FROM paymentMethods
WHERE payment_method_id = 1;
