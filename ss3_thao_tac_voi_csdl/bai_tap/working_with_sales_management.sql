USE sales_management;

INSERT INTO customers (customer_name, customer_age) VALUES
('Minh Quan', 10),
('Ngoc Oanh', 20),
('Hong Ha', 50);

INSERT INTO orders (order_date, customer_id) VALUES
('2006-03-21', 1),
('2006-03-23', 2),
('2006-03-16', 1);

INSERT INTO products (product_name, product_price) VALUES
('May Giat', 3000000),
('Tu Lanh', 5000000),
('Dieu Hoa', 7000000),
('Quat', 1000000),
('Bep Dien', 2000000);

INSERT INTO order_details (order_id, product_id, order_quantity) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select order_id, order_date, order_total_price from orders;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào