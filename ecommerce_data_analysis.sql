SELECT * FROM customers WHERE country='USA' ORDER BY last_name;
SELECT customer_id, COUNT(*) AS total_orders FROM orders GROUP BY customer_id;

SELECT o.order_id, c.first_name, c.last_name, o.order_date FROM orders o INNER JOIN customers c ON o.customer_id=c.customer_id;
SELECT p.product_name, c.category_name FROM products p LEFT JOIN categories c ON p.category_id=c.category_id;

SELECT customer_id FROM orders WHERE order_id IN (SELECT order_id FROM order_items WHERE quantity > 1);

SELECT order_id, SUM(quantity*unit_price) AS total_revenue FROM order_items GROUP BY order_id;
SELECT o.customer_id, AVG(order_total) AS avg_order_value FROM (SELECT order_id, customer_id, SUM(quantity*unit_price) AS order_total FROM orders JOIN order_items USING(order_id) GROUP BY order_id) o GROUP BY o.customer_id;

CREATE OR REPLACE VIEW customer_order_summary AS SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders, SUM(oi.quantity*oi.unit_price) AS total_spent FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id LEFT JOIN order_items oi ON o.order_id=oi.order_id GROUP BY c.customer_id;
SELECT * FROM customer_order_summary;

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
