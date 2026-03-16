CREATE VIEW ecommerce_master AS
SELECT
o.order_id,
o.order_purchase_timestamp,
c.customer_city,
c.customer_state,
pay.payment_type,
pay.payment_value,
oi.price,
oi.freight_value,
p.product_category_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments pay ON o.order_id = pay.order_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT
DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS month,
SUM(payment_value) AS revenue
FROM ecommerce_master
GROUP BY month;

SELECT
product_category_name,
SUM(price) AS revenue
FROM ecommerce_master
GROUP BY product_category_name
ORDER BY revenue DESC;

SELECT
customer_city,
SUM(payment_value) AS revenue
FROM ecommerce_master
GROUP BY customer_city
ORDER BY revenue DESC;

SELECT
payment_type,
COUNT(*) AS transactions
FROM ecommerce_master
GROUP BY payment_type;