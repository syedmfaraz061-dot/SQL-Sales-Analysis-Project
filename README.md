# SQL-Sales-Analysis-Project
This project demonstrates SQL skills for analyzing sales, customer, and product data.   It includes real-world business questions, joins, aggregations, window functions, and CTEs to uncover sales insights and customer behavior patterns.
# 🧩 SQL Sales Analysis Project

This project demonstrates SQL skills for analyzing sales, customer, and product data.  
It includes real-world business questions, joins, aggregations, window functions, and CTEs to uncover sales insights and customer behavior patterns.

---

## 📊 Project Overview
The project focuses on exploring customer purchase behavior and product performance using SQL queries.  
It simulates a retail database containing the following tables:

- **customers** — customer details and city information  
- **orders** — order IDs, order dates, and total amounts  
- **orderdetails** — product quantity and order information  
- **products** — product name, category, and price  
- **categories** — category details for products  

---

## 🎯 Objectives
- Retrieve and analyze customer and product information  
- Find high-performing products and categories  
- Measure customer spending and order frequency  
- Identify seasonal or monthly order trends  
- Rank products, cities, and customers by performance  

---

## 🧠 Key Insights from Queries
- **Top Customers:** Identified customers who spend above the average order value.  
- **Top Products:** Found most popular and high-revenue products in each category.  
- **Regional Performance:** Ranked cities by total sales revenue.  
- **Sales Trends:** Analyzed monthly orders to identify seasonal peaks.  
- **Profitability:** Highlighted the most profitable categories and sales methods.

---

## 🧱 SQL Concepts Used
This project demonstrates a wide range of SQL functions and techniques:

| Concept | Description |
|----------|--------------|
| **SELECT, WHERE, JOIN** | Retrieve and merge data across multiple tables |
| **GROUP BY / HAVING** | Summarize and filter aggregated data |
| **Aggregate Functions** | SUM, COUNT, AVG for total and mean calculations |
| **Window Functions** | Used `RANK()` to rank products and customers |
| **CTEs (WITH statements)** | Simplify complex subqueries |
| **ORDER BY & LIMIT** | Display top-performing results |

---

## 📂 Files in Repository
| File | Description |
|------|--------------|
| `sales_analysis_queries.sql` | All SQL queries with comments explaining each step |

---

## 🧾 Example Queries
### 🔹 Find Top 5 Customers by Spending
```sql
SELECT c.customer_name, o.total_amount
FROM customers c  
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.total_amount DESC
LIMIT 5;


👨‍💻 Author

Syed Mutallib Faraz
Master’s in Economics | Aspiring Data Analyst
Passionate about SQL-based data analytics, visualization, and business insights.

📫 LinkedIn Profile (www.linkedin.com/in/syed-mutallib-faraz-0063a0385)
