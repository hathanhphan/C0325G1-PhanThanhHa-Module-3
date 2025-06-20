CREATE DATABASE hotel_management;

USE hotel_management;

-- Script tạo cơ sở dữ liệu MySQL cho hệ thống quản lý khách sạn (đầy đủ, có dữ liệu mẫu thực tế)

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('customer', 'staff', 'manager') NOT NULL
);

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    position VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    phone VARCHAR(20),
    type ENUM('new', 'vip', 'corporate'),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    type ENUM('standard', 'deluxe', 'family') NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    capacity INT DEFAULT 2,
    status ENUM('available', 'occupied', 'maintenance') DEFAULT 'available'
);

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
    payment_status ENUM('pending', 'paid', 'cancelled') DEFAULT 'pending',
    payment_method ENUM('cash', 'online'),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE booking_rooms (
    booking_id INT,
    room_id INT,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (booking_id, room_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE booking_services (
    booking_id INT,
    service_id INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (booking_id, service_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

CREATE TABLE booking_guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    full_name VARCHAR(100) NOT NULL,
    cccd VARCHAR(20) NOT NULL,
    birth_date DATE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- Procedure tính tổng tiền sau khi checkout
DELIMITER //
CREATE PROCEDURE calculate_total(IN in_booking_id INT)
BEGIN
    DECLARE room_total DECIMAL(10,2);
    DECLARE service_total DECIMAL(10,2);
    DECLARE total DECIMAL(12,2);

    SELECT SUM(price) * DATEDIFF(COALESCE(actual_checkout, checkout_date), checkin_date)
    INTO room_total
    FROM booking_rooms
    WHERE booking_id = in_booking_id;

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

-- Procedure kiểm tra phòng trống và đủ sức chứa
CREATE PROCEDURE check_available_rooms_with_capacity(
    IN in_checkin DATE,
    IN in_checkout DATE,
    IN in_room_type ENUM('standard','deluxe','family'),
    IN in_quantity INT,
    IN in_total_guests INT
)
BEGIN
    SELECT r.id, r.room_number, r.capacity
    FROM rooms r
    WHERE r.type = in_room_type
      AND r.status = 'available'
      AND r.id NOT IN (
        SELECT br.room_id
        FROM booking_rooms br
        JOIN bookings b ON br.booking_id = b.id
        WHERE NOT (
          b.checkout_date <= in_checkin OR
          b.checkin_date >= in_checkout
        )
      )
    HAVING SUM(r.capacity) >= in_total_guests
    LIMIT in_quantity;
END;
//
DELIMITER ;

-- Dữ liệu mẫu cho users
INSERT INTO users (name, email, password_hash, role) VALUES
('Nguyễn Văn A', 'a@gmail.com', 'hash123', 'customer'),
('Trần Thị B', 'b@gmail.com', 'hash456', 'customer'),
('Lê Văn C', 'c@gmail.com', 'hash789', 'customer'),
('Phạm Thị D', 'd@gmail.com', 'hashabc', 'staff'),
('Ngô Văn E', 'e@gmail.com', 'hashdef', 'staff'),
('Hoàng Văn F', 'f@gmail.com', 'hashghi', 'manager');

-- Dữ liệu mẫu cho employees
INSERT INTO employees (user_id, position) VALUES
(4, 'Lễ tân'),
(5, 'Lễ tân'),
(6, 'Quản lý');

-- Dữ liệu mẫu cho customers
INSERT INTO customers (user_id, phone, type) VALUES
(1, '0911111111', 'vip'),
(2, '0922222222', 'new'),
(3, '0933333333', 'corporate');

-- Dữ liệu mẫu cho rooms
INSERT INTO rooms (room_number, type, price_per_night, capacity, status) VALUES
('101', 'standard', 500000, 2, 'available'),
('102', 'standard', 500000, 2, 'available'),
('103', 'deluxe', 800000, 3, 'available'),
('104', 'deluxe', 800000, 3, 'occupied'),
('105', 'family', 1200000, 5, 'available'),
('106', 'family', 1200000, 5, 'maintenance');

-- Dữ liệu mẫu cho services
INSERT INTO services (name, price) VALUES
('Minibar', 100000),
('Giặt ủi', 50000),
('Đưa đón sân bay', 200000);

-- Dữ liệu mẫu cho bookings
INSERT INTO bookings (customer_id, employee_id, checkin_date, checkout_date, actual_checkin, actual_checkout, extended_nights, late_checkout_fee, total_amount, payment_status, payment_method) VALUES
(1, 1, '2025-07-01', '2025-07-03', '2025-07-01 14:00:00', '2025-07-03 11:00:00', 0, 0, 0, 'paid', 'online'),
(2, 2, '2025-07-05', '2025-07-08', '2025-07-05 15:00:00', '2025-07-08 12:30:00', 0, 0, 0, 'paid', 'cash'),
(3, 1, '2025-07-10', '2025-07-12', NULL, NULL, 0, 0, 0, 'pending', 'online');

-- Dữ liệu mẫu cho booking_rooms
INSERT INTO booking_rooms (booking_id, room_id, price) VALUES
(1, 1, 500000),
(1, 3, 800000),
(2, 2, 500000),
(2, 5, 1200000),
(3, 3, 800000);

-- Dữ liệu mẫu cho booking_services
INSERT INTO booking_services (booking_id, service_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);

-- Dữ liệu mẫu cho booking_guests
INSERT INTO booking_guests (booking_id, full_name, cccd, birth_date) VALUES
(1, 'Lê Thị H', '001122334455', '1990-05-01'),
(1, 'Nguyễn Văn I', '009988776655', '1988-07-20'),
(2, 'Trần Thị K', '003344556677', '1995-09-15'),
(2, 'Phạm Văn L', '007755331122', '1992-11-03');
