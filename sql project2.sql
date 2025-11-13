# Write a query to select the customer names and their corresponding cities
select customer_name , customer_city
from customers;

# Write a query to display the order ID, order date, and total amount for all orders.
select order_id , order_date , total_amount
from orders;

# Write a query to list all products that belong to the category "Electronics."
select p. product_name
from products p 
join categories c on p.category_id = c.category_id where category_name ='electronics';

# Write a query to find the total amount spent by each customer.
select c.customer_name,o.total_amount
from customers c
join orders o on c.customer_id = o.customer_id;

# Write a query to count the number of orders placed by customers in each city.
SELECT c.customer_city, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY order_count DESC;

# Write a query to find the average quantity ordered for each product.
SELECT p.product_id, p.product_name, AVG(o.quantity) AS avg_quantity
FROM products p
JOIN orderdetails o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY avg_quantity DESC;

# Write a query to rank the products by price and list the top 5 most expensive ones.
select product_name, price 
from products
order by price desc
limit 5;

# Write a query to rank customers based on their total spending.
select c.customer_name, o.total_amount
from customers c  
join orders o on c.customer_id = o.customer_id
order by o.total_amount desc 
limit 5;

# Write a query to find customers who have placed orders above the average order amount.
WITH avg_order AS (
    SELECT AVG(total_amount) AS avg_amount
    FROM orders
)
SELECT c.customer_id, c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > (SELECT avg_amount FROM avg_order);

# Write a query to find the product with the highest sales in each category.
WITH product_sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category_id,
        c.category_name,
        SUM(od.quantity) AS total_quantity
    FROM products p
    JOIN orderdetails od ON p.product_id = od.product_id
    JOIN categories c ON p.category_id = c.category_id
    GROUP BY p.product_id, p.product_name, p.category_id, c.category_name
),ranked_products AS (
    SELECT *,
        RANK() OVER (PARTITION BY category_id ORDER BY total_quantity DESC) AS rank_in_category
    FROM product_sales
)SELECT 
    category_id,
    category_name,
    product_id,
    product_name,
    total_quantity
FROM ranked_products
WHERE rank_in_category = 1;

# Write a query to list all customers who have placed more than one order, including their customer names and the number of orders they have placed
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;

# Write a query to display each customer and the products they have ordered, including the customer name, product name, and quantity ordered.
SELECT 
    c.customer_name,
    p.product_name,
    od.quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN orderdetails od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY c.customer_name, p.product_name;

# Write a query to calculate the total revenue generated for each product category, displaying the category name and total revenue.
SELECT 
    c.category_name,
    SUM(p.price * od.quantity) AS total_revenue
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN orderdetails od ON p.product_id = od.product_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;

# Write a query to count how many orders were placed in each month of the current year, displaying the month and the number of orders.
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year DESC, order_month;

# Write a query to list products that have been ordered fewer than 10 times, displaying the product name and the total quantity ordered
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_quantity
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id
GROUP BY p.product_name
HAVING SUM(od.quantity) < 10
ORDER BY total_quantity ASC;

# Write a query to list customers who have placed more than 10 orders, displaying the customer name and the total number of orders they’ve placed.
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 10;

# Write a query to rank cities based on the total revenue generated from orders placed by customers residing in each city, displaying the city name and total revenue
SELECT 
    c.customer_city,
    SUM(p.price * od.quantity) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN orderdetails od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_city;

#Write a query to find all orders where more than 3 different products were ordered, displaying the order ID, order date, and customer name.
SELECT 
    o.order_id,
    o.order_date,
    c.customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN orderdetails od ON o.order_id = od.order_id
GROUP BY o.order_id, o.order_date, c.customer_name
HAVING COUNT(DISTINCT od.product_id) > 3
ORDER BY o.order_date;

# Write a query to display the most popular product (based on quantity ordered) in each region, including the region name and product name.
WITH product_sales_by_city AS (
    SELECT 
        c.customer_city,
        p.product_id,
        p.product_name,
        SUM(od.quantity) AS total_quantity
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN orderdetails od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY c.customer_city, p.product_id, p.product_name
),
ranked_products AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY customer_city ORDER BY total_quantity DESC) AS rank_in_city
    FROM product_sales_by_city
)
SELECT 
    customer_city,
    product_name,
    total_quantity
FROM ranked_products
WHERE rank_in_city = 1;

