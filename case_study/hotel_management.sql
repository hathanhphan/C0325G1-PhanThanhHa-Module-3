CREATE DATABASE IF NOT EXISTS hotel_management;
USE hotel_management;

-- 1. Bảng users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    user_role ENUM('customer','staff','manager') NOT NULL
);

-- 2. Bảng employees
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    employee_name VARCHAR(100) NOT NULL,
    gender ENUM('male','female','other') NOT NULL,
    dob DATE,
    address VARCHAR(255),
    employee_phone VARCHAR(20),
    position VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 3. Bảng customers
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20) NOT NULL,
    customer_type ENUM('new','vip','corporate'),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 4. Bảng room_types
CREATE TABLE room_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    price_per_night DECIMAL(10,2) NOT NULL,
    room_description MEDIUMTEXT,
    capacity INT NOT NULL
);

-- 5. Bảng room_type_images
CREATE TABLE room_type_images (
    room_type_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    PRIMARY KEY (room_type_id, image_url),
    FOREIGN KEY (room_type_id) REFERENCES room_types(id)
);

-- 6. Bảng rooms
CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_status ENUM('available','occupied','maintenance') DEFAULT 'available',
    room_type_id INT NOT NULL,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id)
);

-- 7. Bảng services
CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sercive_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- 8. Bảng bookings
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    actual_checkin DATETIME,
    actual_checkout DATETIME,
    extended_nights INT DEFAULT 0,
    late_checkout_fee DECIMAL(10,2) DEFAULT 0.00,
    total_amount DECIMAL(12,2) DEFAULT 0.00,
    payment_status ENUM('pending','paid','cancelled') DEFAULT 'pending',
    payment_method ENUM('cash','online'),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- 9. Bảng booking_rooms
CREATE TABLE booking_rooms (
    booking_id INT,
    room_id INT,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (booking_id, room_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

-- 10. Bảng booking_services
CREATE TABLE booking_services (
    booking_id INT,
    service_id INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (booking_id, service_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

-- 11. Bảng booking_guests
CREATE TABLE booking_guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    full_name VARCHAR(100) NOT NULL,
    identity_card_number VARCHAR(20) NOT NULL,
    birth_date DATE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- 12. Procedures
DELIMITER //
CREATE PROCEDURE calculate_total(IN in_booking_id INT)
BEGIN
    DECLARE room_total DECIMAL(10,2);
    DECLARE service_total DECIMAL(10,2);
    DECLARE total DECIMAL(12,2);

    SELECT SUM(br.price) * DATEDIFF(
             COALESCE(b.actual_checkout, b.checkout_date),
             b.checkin_date
           )
    INTO room_total
    FROM booking_rooms br
    JOIN bookings b ON br.booking_id = b.id
    WHERE br.booking_id = in_booking_id;

    SELECT SUM(s.price * bs.quantity)
    INTO service_total
    FROM booking_services bs
    JOIN services s ON bs.service_id = s.id
    WHERE bs.booking_id = in_booking_id;

    SET total = COALESCE(room_total,0) + COALESCE(service_total,0);

    UPDATE bookings
    SET total_amount = total
    WHERE id = in_booking_id;
END;
//

CREATE PROCEDURE check_available_rooms_with_capacity(
    IN in_checkin DATE,
    IN in_checkout DATE,
    IN in_room_type_id INT,
    IN in_quantity INT,
    IN in_total_guests INT
)
BEGIN
    SELECT r.id, r.room_number, rt.capacity
    FROM rooms r
    JOIN room_types rt ON r.room_type_id = rt.id
    WHERE r.room_type_id = in_room_type_id
      AND r.room_status = 'available'
      AND r.id NOT IN (
        SELECT br.room_id
        FROM booking_rooms br
        JOIN bookings b ON br.booking_id = b.id
        WHERE NOT (
          b.checkout_date <= in_checkin
          OR b.checkin_date >= in_checkout
        )
      )
    HAVING SUM(rt.capacity) >= in_total_guests
    LIMIT in_quantity;
END;
//
DELIMITER ;

-- 13. Dữ liệu mẫu

-- users
INSERT INTO users (email, password_hash, user_role) VALUES
('a@gmail.com','hash123','customer'),
('b@gmail.com','hash456','customer'),
('c@gmail.com','hash789','customer'),
('d@gmail.com','hashabc','staff'),
('e@gmail.com','hashdef','staff'),
('f@gmail.com','hashghi','manager');

-- employees
INSERT INTO employees (user_id, employee_name, gender, dob, address, employee_phone, position) VALUES
(4, 'Phạm Thị D', 'female', '1990-03-15', '123 Phố Hòa Bình, Quận 1, TP.HCM', '0901234567', 'Lễ tân'),
(5, 'Ngô Văn E', 'male', '1988-07-22', '456 Đường Lê Lợi, Quận 3, TP.HCM', '0912345678', 'Lễ tân'),
(6, 'Hoàng Văn F','male', '1985-11-05', '789 Phố Nguyễn Huệ, Quận 1, TP.HCM', '0923456789', 'Quản lý');

-- customers
INSERT INTO customers (user_id, customer_name, customer_phone, customer_type) VALUES
(1, 'Lê Thị H', '0911111111','vip'),
(2, 'Nguyễn Văn I', '0922222222','new'),
(3, 'Trần Thị K', '0933333333','corporate');

-- room_types
INSERT INTO room_types (price_per_night, room_description, capacity) VALUES
(500000,'Standard: giường đôi, tiện nghi cơ bản',2),
(800000,'Deluxe: view đẹp, minibar miễn phí',3),
(1200000,'Family: không gian rộng, 2 giường lớn',5);

-- room_type_images
INSERT INTO room_type_images (room_type_id, image_url) VALUES
(1,'https://example.com/images/standard1.jpg'),
(1,'https://example.com/images/standard2.jpg'),
(2,'https://example.com/images/deluxe1.jpg'),
(2,'https://example.com/images/deluxe2.jpg'),
(3,'https://example.com/images/family1.jpg'),
(3,'https://example.com/images/family2.jpg');

-- rooms
INSERT INTO rooms (room_number, room_status, room_type_id) VALUES
('101','available',1),
('102','available',1),
('103','available',2),
('104','occupied',2),
('105','available',3),
('106','maintenance',3);

-- services
INSERT INTO services (sercive_name, price) VALUES
('Minibar',100000),
('Giặt ủi',50000),
('Đưa đón sân bay',200000);

-- bookings
INSERT INTO bookings (
    customer_id, employee_id, checkin_date, checkout_date,
    actual_checkin, actual_checkout,
    extended_nights, late_checkout_fee,
    total_amount, payment_status, payment_method
) VALUES
(1,1,'2025-07-01','2025-07-03','2025-07-01 14:00:00','2025-07-03 11:00:00',0,0,0,'paid','online'),
(2,2,'2025-07-05','2025-07-08','2025-07-05 15:00:00','2025-07-08 12:30:00',0,0,0,'paid','cash'),
(3,1,'2025-07-10','2025-07-12',NULL,NULL,0,0,0,'pending','online');

-- booking_rooms
INSERT INTO booking_rooms (booking_id, room_id, price) VALUES
(1,1,500000),
(1,3,800000),
(2,2,500000),
(2,5,1200000),
(3,3,800000);

-- booking_services
INSERT INTO booking_services (booking_id, service_id, quantity) VALUES
(1,1,1),
(1,2,2),
(2,3,1);

-- booking_guests
INSERT INTO booking_guests (booking_id, full_name, identity_card_number, birth_date) VALUES
(1,'Lê Thị H','001122334455','1990-05-01'),
(1,'Nguyễn Văn I','009988776655','1988-07-20'),
(2,'Trần Thị K','003344556677','1995-09-15'),
(2,'Phạm Văn L','007755331122','1992-11-03');