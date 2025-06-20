-- ---------- Bước 1: Tạo cơ sở dữ liệu demo -------------
create database demo;

use demo;

-- ---------- Bước 2: Tạo bảng Products -------------
Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
Tạo store procedure thêm một sản phẩm mới
Tạo store procedure sửa thông tin sản phẩm theo id
Tạo store procedure xoá sản phẩm theo id

-- Du lieu mau
INSERT INTO products (product_code, product_name, product_price, product_amount, product_description, product_status) VALUES
-- Electronics
('ELE001','Apple iPhone 14',799.00,50,'Latest model of Apple iPhone with A15 Bionic chip and 6.1-inch display.', b'1'),
('ELE002','Samsung Galaxy S23',749.99,30,'Flagship smartphone from Samsung with 8 GB RAM and 128 GB storage.', b'1'),
('ELE003','Sony WH-1000XM5 Headphones',349.99,20,'Noise-cancelling wireless over-ear headphones with 30-hour battery life.', b'1'),
('ELE004','Dell XPS 13 Laptop',999.00,15,'Compact ultrabook with Intel Core i5 processor and 512 GB SSD.', b'0'),
('ELE005','Apple Watch Series 8',399.00,25,'Smartwatch with ECG monitoring and blood oxygen sensor.', b'1'),

-- Home Appliances
('HAP001','LG Refrigerator 260L',1200.00,10,'Energy-efficient refrigerator with frost-free technology and LED display.', b'1'),
('HAP002','Sharp Microwave Oven 25L',150.00,40,'25 L microwave with 10 power levels and child safety lock.', b'1'),
('HAP003','Philips Air Fryer 4.1L',200.00,35,'Digital air fryer with rapid air technology and adjustable temperature.', b'1'),
('HAP004','Xiaomi Robot Vacuum S6',350.00,18,'Smart robot vacuum with LiDAR mapping and app control.', b'1'),
('HAP005','Panasonic Washing Machine 8kg',500.00,12,'Front-load washer with inverter motor and multiple wash programs.', b'1'),

-- Furniture
('FUR001','IKEA Dining Table',250.00,8,'Modern solid-wood dining table seats up to 6 people.', b'1'),
('FUR002','HomeTown Sofa Set',450.00,5,'Three-seater fabric sofa with removable cushions.', b'1'),
('FUR003','Office Desk with Drawer',120.00,14,'Ergonomic home office desk with built-in storage drawer.', b'0'),
('FUR004','King Size Bed Frame',300.00,6,'Sturdy metal bed frame with slatted base support.', b'1'),
('FUR005','Bookshelf 5-Tier',100.00,20,'Industrial-style shelving unit with adjustable shelves.', b'1'),

-- Fashion
('FSH001','Nike Air Max 270',120.00,30,'Men’s lifestyle sneaker with visible Air cushioning.', b'1'),
('FSH002','Adidas Ultraboost 22',180.00,25,'Performance running shoe with responsive Boost midsole.', b'1'),
('FSH003','Levi\'s 501 Original Jeans',60.00,40,'Classic straight-leg denim jeans with button fly.', b'1'),
('FSH004','Ray-Ban Wayfarer Sunglasses',150.00,22,'Iconic UV-protective acetate sunglasses.', b'1'),
('FSH005','Gucci Leather Belt',200.00,10,'Black leather belt with double G buckle.', b'0'),

-- Sports
('SPO001','Wilson Tennis Racket Pro Staff',220.00,16,'Graphite racket with head-heavy balance for power.', b'1'),
('SPO002','Adidas Soccer Ball FIFA Approved',30.00,50,'Match-quality ball with thermally bonded panels.', b'1'),
('SPO003','Yonex Arcsaber 11 Badminton Racket',130.00,12,'Lightweight racket with control-oriented design.', b'1'),
('SPO004','Garmin Forerunner 45 GPS Watch',250.00,9,'GPS running watch with heart rate monitoring.', b'1'),
('SPO005','Decathlon Yoga Mat',25.00,60,'Eco-friendly non-slip yoga mat with carry strap.', b'1'),

-- Books
('BOK001','Atomic Habits by James Clear',20.00,100,'Practical guide to building good habits and breaking bad ones.', b'1'),
('BOK002','The Subtle Art of Not Giving a F*ck by Mark Manson',18.00,80,'A counterintuitive approach to living a good life.', b'0'),
('BOK003','Clean Code by Robert C. Martin',45.00,60,'Handbook of agile software craftsmanship best practices.', b'1'),
('BOK004','Deep Work by Cal Newport',30.00,70,'Strategies for focused success in a distracted world.', b'1'),
('BOK005','Sapiens: A Brief History of Humankind by Yuval Noah Harari',35.00,55,'Exploration of humanity’s creation and evolution.', b'1'),

-- Toys
('TOY001','Lego Star Wars Millennium Falcon',160.00,15,'Highly detailed set with over 1,300 pieces.', b'1'),
('TOY002','Hasbro Monopoly Classic Edition',25.00,25,'Family board game for 2–6 players.', b'1'),
('TOY003','Nerf N-Strike Elite Disruptor',20.00,40,'6-dart rotating barrel blaster.', b'1'),
('TOY004','Barbie Dreamhouse Dollhouse',200.00,10,'3-story dollhouse with elevator and furniture.', b'1'),
('TOY005','Hot Wheels 50-Car Pack',100.00,18,'Bundle of 50 die-cast collectible cars.', b'1'),

-- Beauty
('BTY001','Maybelline Fit Me Foundation',10.00,120,'Matte + poreless liquid foundation, 30 ml.', b'1'),
('BTY002','L\'Oreal Paris Revitalift Day Cream',25.00,80,'Anti-wrinkle day cream with SPF 23.', b'1'),
('BTY003','The Ordinary Niacinamide 10% + Zinc 1%',12.00,90,'High-strength vitamin and mineral blemish formula.', b'1'),
('BTY004','Neutrogena Hydro Boost Water Gel',15.00,70,'Oil-free moisturizer with hyaluronic acid.', b'1'),
('BTY005','MAC Ruby Woo Lipstick',20.00,50,'Iconic matte red lipstick.', b'1'),

-- Food
('FOD001','Lindt Excellence Dark Chocolate 70%',5.00,200,'Premium Swiss dark chocolate bar, 100 g.', b'1'),
('FOD002','Jack Link\'s Original Beef Jerky',7.00,150,'Savory protein snack, 85 g pouch.', b'1'),
('FOD003','Nature\'s Path Organic Granola',8.00,100,'Gluten-free maple syrup granola, 350 g.', b'1'),
('FOD004','Pringles Original Potato Crisps',3.00,180,'Stackable potato crisps in a can, 165 g.', b'1'),
('FOD005','Starbucks Pike Place Roast Coffee Beans',12.00,130,'Medium-roast coffee beans, 454 g.', b'1'),

-- Automotive
('AUT001','Castrol EDGE 5W-30 Oil 1L',8.00,60,'Fully synthetic motor oil for high performance.', b'1'),
('AUT002','Michelin Pilot Sport 4 Tire',150.00,14,'Ultra-high performance summer tire.', b'1'),
('AUT003','Bosch Spark Plug FR7SII33',2.50,100,'Standard platinum spark plug for reliable starts.', b'1'),
('AUT004','Mobil 1 High Mileage 5W-30 Oil 1L',9.00,50,'Synthetic motor oil for vehicles over 75,000 km.', b'0'),
('AUT005','3M Headlight Restoration Kit',30.00,40,'Complete kit for restoring headlight clarity.', b'1');

-- ---------- Bước 3: Tạo index và so sánh -------------
explain select * from products where product_code = 'AUT005';

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table products add index idx_name_price (product_name, product_price);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where product_name = 'Maybelline Fit Me Foundation' and product_price = 10;

-- So sánh câu truy vấn trước và sau khi tạo index
-- Kết quả: Trước index: type: ALL, key: NULL | Sau index: type: ref, key: idx_name_price
-- Như vậy sau khi tạo index, MySQL sẽ chỉ đọc các bản ghi phù hợp qua index, tránh quét toàn bộ bảng => cải thiện tốc độ truy vấn.

-- ---------- Bước 4: Tạo và thao tác với view -------------
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view products_view as
select product_code, product_name, product_price, product_status
from products;

select * from products_view;

-- Tiến hành sửa đổi view (Ví dụ: chỉ lấy những products có status = 1)
create or replace view products_view as
select product_code, product_name, product_price, product_status
from products
where product_status = 1;

select * from products_view;

-- Tiến hành xoá view
drop view if exists products_view;

-- ---------- Bước 5: Tạo procedure -------------
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure get_all_products()
	begin
		select 
			id,
			product_code,
			product_name,
			product_price,
			product_amount,
			product_description,
			product_status
        from products;
	end //
delimiter ;

call get_all_products();

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure add_new_product(
	in p_product_code varchar(20),
    in p_product_name varchar(100),
    in p_product_price decimal(15, 2),
    in p_product_amount int unsigned,
    in p_product_description text,
    in p_product_status bit(1)
)
	begin
		insert into products (product_code, product_name, product_price, product_amount, product_description, product_status) values
        (p_product_code, p_product_name, p_product_price, p_product_amount, p_product_description, p_product_status);
	end //
delimiter ;

call add_new_product('ELE006','Apple iPhone 14',799.00,50,'Latest model of Apple iPhone with A15 Bionic chip and 6.1-inch display.', b'1');

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure update_product_by_id(
	in p_product_id int,
    in p_product_code varchar(20),
    in p_product_name varchar(100),
    in p_product_price decimal(15, 2),
    in p_product_amount int unsigned,
    in p_product_description text,
    in p_product_status bit(1)
)
	begin
		update products
		set
			product_code = p_product_code,
			product_name = p_product_name,
			product_price = p_product_price,
			product_amount = p_product_amount,
			product_description = p_product_description,
			product_status = p_product_status
		where id = p_product_id;
	end //
delimiter ;

call update_product_by_id(1, 'ELE001','Apple iPhone 14 (new)',799.00,50,'Latest model of Apple iPhone with A15 Bionic chip and 6.1-inch display.', b'0');

-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure delete_product_by_id(in p_product_id int)
	begin
		delete from products
        where id = p_product_id;
	end //
delimiter ;

call delete_product_by_id(51);


