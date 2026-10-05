-- ============================================================
-- SALES PERFORMANCE ANALYSIS
-- Q1 2026
-- PostgreSQL
-- ============================================================


-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    customer_type VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    discount NUMERIC(5,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- ============================================================
-- 2. INSERT CUSTOMER DATA
-- ============================================================

INSERT INTO customers
    (customer_id, customer_name, city, customer_type)
VALUES
    (1, 'Omar Hassan', 'Nablus', 'Regular'),
    (2, 'Nour Ali', 'Ramallah', 'Premium'),
    (3, 'Adam Clark', 'Jerusalem', 'Regular'),
    (4, 'Lina Adams', 'Hebron', 'Premium'),
    (5, 'Noah Wilson', 'Nablus', 'Regular'),
    (6, 'Sara Brown', 'Ramallah', 'Premium'),
    (7, 'Maya Khalil', 'Hebron', 'Regular'),
    (8, 'Daniel Smith', 'Jerusalem', 'Regular'),
    (9, 'Leen Saleh', 'Nablus', 'Premium'),
    (10, 'Yousef Ahmad', 'Ramallah', 'Regular');


-- ============================================================
-- 3. INSERT PRODUCT DATA
-- ============================================================

INSERT INTO products
    (product_id, product_name, category, unit_price)
VALUES
    (1, 'Laptop', 'Technology', 750.00),
    (2, 'Monitor', 'Technology', 300.00),
    (3, 'Tablet', 'Technology', 400.00),
    (4, 'Wireless Mouse', 'Technology', 35.00),
    (5, 'Office Chair', 'Furniture', 150.00),
    (6, 'Office Desk', 'Furniture', 250.00),
    (7, 'Bookshelf', 'Furniture', 200.00),
    (8, 'Coffee Table', 'Furniture', 170.00),
    (9, 'Printer Paper', 'Office Supplies', 15.00),
    (10, 'Desk Lamp', 'Office Supplies', 45.00),
    (11, 'Headset', 'Technology', 75.00),
    (12, 'Keyboard', 'Technology', 60.00);


-- ============================================================
-- 4. INSERT ORDER DATA
-- ============================================================

INSERT INTO orders
    (order_id, customer_id, product_id, order_date, quantity, discount)
VALUES
    (1, 1, 1, '2026-01-05', 1, 0.00),
    (2, 2, 2, '2026-01-07', 2, 0.10),
    (3, 3, 5, '2026-01-10', 1, 0.05),
    (4, 4, 6, '2026-01-12', 1, 0.00),
    (5, 5, 9, '2026-01-15', 5, 0.00),
    (6, 1, 7, '2026-01-18', 2, 0.10),
    (7, 6, 3, '2026-01-22', 1, 0.05),
    (8, 7, 10, '2026-01-25', 3, 0.00),
    (9, 8, 4, '2026-01-28', 2, 0.15),

    (10, 9, 11, '2026-02-02', 2, 0.10),
    (11, 10, 8, '2026-02-05', 1, 0.00),
    (12, 2, 1, '2026-02-08', 1, 0.05),
    (13, 3, 2, '2026-02-10', 1, 0.00),
    (14, 4, 5, '2026-02-13', 2, 0.10),
    (15, 5, 6, '2026-02-16', 1, 0.00),
    (16, 6, 7, '2026-02-18', 1, 0.05),
    (17, 7, 9, '2026-02-20', 10, 0.00),
    (18, 8, 12, '2026-02-22', 2, 0.10),
    (19, 9, 3, '2026-02-25', 1, 0.00),
    (20, 10, 10, '2026-02-28', 2, 0.05),

    (21, 1, 2, '2026-03-02', 1, 0.10),
    (22, 2, 5, '2026-03-05', 1, 0.00),
    (23, 3, 7, '2026-03-08', 1, 0.05),
    (24, 4, 1, '2026-03-10', 1, 0.15),
    (25, 5, 11, '2026-03-12', 3, 0.10),
    (26, 6, 4, '2026-03-15', 2, 0.00),
    (27, 7, 6, '2026-03-18', 1, 0.05),
    (28, 8, 8, '2026-03-20', 2, 0.00),
    (29, 9, 12, '2026-03-22', 1, 0.10),
    (30, 10, 3, '2026-03-25', 2, 0.05);


-- ============================================================
-- 5. BASIC DATA CHECKS
-- ============================================================

-- Number of customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- Number of products
SELECT COUNT(*) AS total_products
FROM products;


-- Number of orders
SELECT COUNT(*) AS total_orders
FROM orders;


-- ============================================================
-- 6. ORDER DETAILS WITH CALCULATED SALES
-- ============================================================

SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    p.product_name,
    p.category,
    o.quantity,
    p.unit_price,
    o.discount,

    o.quantity * p.unit_price AS gross_sales,

    o.quantity * p.unit_price * (1 - o.discount)
        AS final_sales

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

ORDER BY o.order_date;


-- ============================================================
-- 7. TOTAL SALES
-- ============================================================

SELECT
    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN products p
    ON o.product_id = p.product_id;


-- ============================================================
-- 8. TOTAL SALES BY CATEGORY
-- ============================================================

SELECT
    p.category,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.category

ORDER BY total_sales DESC;


-- ============================================================
-- 9. TOTAL SALES BY CUSTOMER
-- ============================================================

SELECT
    c.customer_name,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY c.customer_name

ORDER BY total_sales DESC;


-- ============================================================
-- 10. TECHNOLOGY SALES BY CUSTOMER
-- ============================================================

SELECT
    c.customer_name,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_technology_sales

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

WHERE p.category = 'Technology'

GROUP BY c.customer_name

ORDER BY total_technology_sales DESC;


-- ============================================================
-- 11. SALES BY CUSTOMER TYPE
-- ============================================================

SELECT
    c.customer_type,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY c.customer_type

ORDER BY total_sales DESC;


-- ============================================================
-- 12. NUMBER OF ORDERS BY CUSTOMER TYPE
-- ============================================================

SELECT
    c.customer_type,

    COUNT(o.order_id) AS number_of_orders

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

GROUP BY c.customer_type;


-- ============================================================
-- 13. PREMIUM CUSTOMER SALES
-- ============================================================

SELECT
    c.customer_name,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

WHERE c.customer_type = 'Premium'

GROUP BY c.customer_name

ORDER BY total_sales DESC;


-- ============================================================
-- 14. PRODUCTS WITH PRICE ABOVE $300
-- ============================================================

SELECT
    product_name,
    category,
    unit_price

FROM products

WHERE unit_price > 300

ORDER BY unit_price DESC;


-- ============================================================
-- 15. TOTAL SALES BY PRODUCT
-- ============================================================

SELECT
    p.product_name,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY total_sales DESC;


-- ============================================================
-- 16. PRODUCTS WITH TOTAL SALES ABOVE $500
-- ============================================================

SELECT
    p.product_name,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.product_name

HAVING SUM(
    o.quantity * p.unit_price * (1 - o.discount)
) > 500

ORDER BY total_sales DESC;


-- ============================================================
-- 17. AVERAGE ORDER VALUE
-- ============================================================

SELECT
    AVG(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS average_order_value

FROM orders o

JOIN products p
    ON o.product_id = p.product_id;


-- ============================================================
-- 18. SALES BY MONTH
-- ============================================================

SELECT
    DATE_TRUNC('month', o.order_date) AS month,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY DATE_TRUNC('month', o.order_date)

ORDER BY month;


-- ============================================================
-- 19. TECHNOLOGY SALES BY MONTH
-- ============================================================

SELECT
    DATE_TRUNC('month', o.order_date) AS month,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS technology_sales

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

WHERE p.category = 'Technology'

GROUP BY DATE_TRUNC('month', o.order_date)

ORDER BY month;


-- ============================================================
-- 20. ORDER SIZE CLASSIFICATION USING CASE
-- ============================================================

SELECT
    o.order_id,
    c.customer_name,

    o.quantity * p.unit_price * (1 - o.discount)
        AS final_price,

    CASE
        WHEN o.quantity * p.unit_price * (1 - o.discount) >= 500
            THEN 'High'

        WHEN o.quantity * p.unit_price * (1 - o.discount) >= 250
            THEN 'Medium'

        ELSE 'Low'
    END AS order_size

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

ORDER BY final_price DESC;


-- ============================================================
-- 21. HIGH-VALUE TECHNOLOGY ORDERS
-- ============================================================

SELECT
    o.order_id,
    c.customer_name,
    p.product_name,

    o.quantity * p.unit_price * (1 - o.discount)
        AS final_price

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

WHERE p.category = 'Technology'

AND o.quantity * p.unit_price * (1 - o.discount) > 300

ORDER BY final_price DESC;


-- ============================================================
-- 22. TOTAL QUANTITY SOLD BY CATEGORY
-- ============================================================

SELECT
    p.category,

    SUM(o.quantity) AS total_quantity

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.category

ORDER BY total_quantity DESC;


-- ============================================================
-- 23. TOP 5 PRODUCTS BY SALES
-- ============================================================

SELECT
    p.product_name,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN products p
    ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY total_sales DESC

LIMIT 5;


-- ============================================================
-- 24. TOP 5 CUSTOMERS BY SALES
-- ============================================================

SELECT
    c.customer_name,

    SUM(
        o.quantity * p.unit_price * (1 - o.discount)
    ) AS total_sales

FROM orders o

JOIN customers c
    ON o.customer_id = c.customer_id

JOIN products p
    ON o.product_id = p.product_id

GROUP BY c.customer_name

ORDER BY total_sales DESC

LIMIT 5;


-- ============================================================
-- END OF SALES PERFORMANCE ANALYSIS
-- ============================================================