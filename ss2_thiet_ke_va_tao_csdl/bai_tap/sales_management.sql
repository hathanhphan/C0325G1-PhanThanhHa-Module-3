CREATE DATABASE sales_management;

USE sales_management;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    customer_age TINYINT UNSIGNED,
    CHECK (customer_age >= 0
        AND customer_age <= 120),
    PRIMARY KEY (customer_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT,
    order_date DATE NOT NULL,
    order_total_price DECIMAL(15, 2),
    customer_id INT NOT NULL,
    CHECK (order_total_price >= 0),
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    product_price DECIMAL(15, 2) NOT NULL,
    CHECK (product_price >= 0),
    PRIMARY KEY (product_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    order_quantity INT UNSIGNED NOT NULL,
    CHECK (order_quantity > 0),
    PRIMARY KEY (order_id , product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO customers (customer_name, customer_age) VALUES
('Nguyen Van An', 25),
('Tran Thi Binh', 32),
('Le Quoc Cuong', 40),
('Pham Thanh Duy', 29),
('Hoang Minh Chau', 35);

INSERT INTO products (product_name, product_price) VALUES
('Laptop Dell Inspiron', 15000000),
('Chuột Logitech', 350000),
('Bàn phím cơ Razer', 1800000),
('Màn hình Samsung 24 inch', 3200000),
('Tai nghe Sony', 1200000);

INSERT INTO orders (order_date, customer_id) VALUES
('2024-06-01', 1),
('2024-06-02', 2),
('2024-06-03', 3),
('2024-06-04', 4),
('2024-06-05', 5);

INSERT INTO order_details (order_id, product_id, order_quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 2, 4),
(3, 3, 1),
(3, 5, 3),
(4, 4, 5),
(4, 2, 9),
(5, 5, 11);

SELECT customer_id, customer_name, customer_age FROM customers;

SELECT product_id, product_name, product_price FROM products;

SELECT order_id, order_date, order_total_price FROM orders;

SELECT
	o.order_id,
    c.customer_name,
    o.order_date,
    p.product_name,
    od.order_quantity,
    p.product_price,
    (od.order_quantity * p.product_price) as total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;

