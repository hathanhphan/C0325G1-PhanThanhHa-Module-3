USE sales_management;

-- Xoá các bản ghi cũ
SET FOREIGN_KEY_CHECKS = 0;
truncate table order_details;
truncate table orders;
truncate table products;
truncate table customers;
SET FOREIGN_KEY_CHECKS = 1;

-- Thêm dữ liệu vào trong 4 bảng
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
select c.customer_id, c.customer_name, o.order_id, o.order_date, p.product_name, p.product_price, od.order_quantity, (p.product_price * od.order_quantity) as total_price
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select customer_name from customers
where customer_id not in (select customer_id from orders group by customer_id);

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select o.order_id, o.order_date, sum(od.order_quantity * p.product_price) as total_price
from orders o
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
group by o.order_id;