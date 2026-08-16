--TABLE 1. Book_ID	Title	Author	Genre	Published_Year	Price	Stock
CREATE TABLE book (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Genre VARCHAR(100),
    Published_Year INT,
    Price DECIMAL(10,2),
    Stock INT DEFAULT 0
);


--TABLE 2. Customer_ID	Name	Email	Phone	City	Country
	CREATE TABLE customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(100),
    Country VARCHAR(100)
);


--Table 3. Order_ID	Customer_ID	Book_ID	Order_Date	Quantity	Total_Amount
create table orders(
	order_id int primary key,
	customer_id int not null,
	book_id int not null,
	order_date date not null,
	quantity int,
	total_amount decimaL(10,2),
	foreign key (book_id) references book(book_id),
	foreign key (customer_id) references customers(customer_id)
);


select * from book;

select  * from customers;

select * from orders;


--BASIC QUery--
--1.Retrieve all books in the "Fiction" genre
select * from book 
where genre


--2.Find books published after the year 1950
select * from book 
where published_year > 1950; 
--3.List all customers from Canada
select * from customers
where country = 'Canada';

--4.Show orders placed in November 2023
select * from orders
where order_date between '01-11-2023' and '30-11-2023';

--5.Retrieve the total stock of books available
select sum(stock) from book;

--6.Find the details of the most expensive book
select * from book order by price desc limit 1;

--7.Show all customers who ordered more than 1 quantity of a book
select * from orders where quantity > 1;

--8.Retrieve all orders where the total amount exceeds $20
select * from orders
where total_amount > 20;


--9.List all genres available in the Books table
select distinct(genre) from book;

--10.Find the book with the lowest stock
select * from book 
order by stock asc limit 1;

--11.Calculate the total revenue generated from all orders
SELECT
	SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM
	ORDERS;


--ADVANCE queries
select * from book;

select * from orders;

select * from customers;

--1. Retrieve the total number of books sold for each genre
select  b.genre, sum(o.quantity) as total_book_sold
from orders o
join book b on o.book_id = b.book_id
group by b.genre;


--2. Find the average price of books in the "Fantasy" genre
select avg(price) as average_price
from book where genre = 'Fantasy';


--3. List customers who have placed at least 2 order
select o.customer_id, c.name, count(o.order_id) as order_count
from orders o 
join customers c 
on o.customer_id = c.customer_id
group by o.customer_id, c.name
having count(order_id) >= 2;

--4. Find the most frequently ordered book
select b.book_id, b.title, count(o.order_id) as frequent_ordered
from orders o join book b
on o.book_id = b.book_id
group by b.book_id, b.title
order by frequent_ordered desc limit 1;

--5. Show the top 3 most expensive books of Fantasy Genre
select title,genre,price
from book
where genre = 'Fantasy'
order by price desc limit 3;

--6. Retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity)
from book b
join orders o
on b.book_id = o.book_id
group by author;

--7. List the cities where customers who spent over $30 are located
select distinct c.city, o.total_amount
from customers c join orders o
on c.customer_id = o.customer_id
where o.total_amount > 30;


--8. Find the customer who spent the most on orders
select c.customer_id, c.name, sum(o.total_amount) as total_spent
from customers c join orders o 
on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by total_spent desc;

--9. Calculate the stock remaining after fulfilling all orders
select b.book_id, b.title, b.stock, coalesce(sum(quantity),0) as order_quantity
from book b
left join orders o on b.book_id = o.book_id
group by b.book_id;


