SELECT VERSION();
CREATE DATABASE sales_analyst;
USE sales_analysis;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled'),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method ENUM('Credit Card', 'PayPal', 'Cash', 'Bank Transfer'),
    amount DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
SHOW TABLES;
INSERT INTO customers (first_name, last_name, email, phone, address, city, state) VALUES
('John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Main St', 'New York', 'NY'),
('Alice', 'Smith', 'alice.smith@email.com', '987-654-3210', '456 Elm St', 'Los Angeles', 'CA'),
('Bob', 'Johnson', 'bob.johnson@email.com', '555-123-4567', '789 Oak St', 'Chicago', 'IL'),
('Emily', 'Davis', 'emily.davis@email.com', '444-555-6666', '321 Pine St', 'Houston', 'TX'),
('Michael', 'Brown', 'michael.brown@email.com', '333-444-5555', '654 Maple St', 'Phoenix', 'AZ');
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop', 'Electronics', 1200.00, 50),
('Smartphone', 'Electronics', 800.00, 100),
('Headphones', 'Accessories', 150.00, 200),
('Office Chair', 'Furniture', 250.00, 30),
('Coffee Maker', 'Appliances', 100.00, 80);
INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2024-03-01', 'Shipped', 1200.00),
(2, '2024-03-02', 'Delivered', 950.00),
(3, '2024-03-03', 'Pending', 800.00),
(4, '2024-03-04', 'Cancelled', 250.00),
(5, '2024-03-05', 'Shipped', 150.00);
INSERT INTO sales (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 1200.00),
(2, 2, 1, 800.00),
(2, 3, 1, 150.00),
(3, 2, 1, 800.00),
(5, 3, 1, 150.00);
INSERT INTO payments (order_id, payment_method, amount, payment_date) VALUES
(1, 'Credit Card', 1200.00, '2024-03-01 10:00:00'),
(2, 'PayPal', 950.00, '2024-03-02 12:30:00'),
(3, 'Bank Transfer', 800.00, '2024-03-03 15:00:00'),
(5, 'Cash', 150.00, '2024-03-05 18:45:00');
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM sales;
SELECT * FROM payments;
SELECT SUM(total_amount) AS total_revenue, COUNT(order_id) AS total_orders 
FROM orders;
SELECT p.product_name, SUM(s.quantity) AS total_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;
SELECT MONTH(order_date) AS month, SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_orders > 1
ORDER BY total_orders DESC;
SELECT payment_method, COUNT(payment_id) AS total_payments, SUM(amount) AS total_amount
FROM payments
GROUP BY payment_method
ORDER BY total_amount DESC;
SELECT order_date, COUNT(order_id) AS orders_placed
FROM orders
GROUP BY order_date
ORDER BY orders_placed DESC
LIMIT 5;





