create database hotel_management;

use hotel_management;

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'available' -- available, booked, maintenance
);

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    checkin_date DATE,
    checkout_date DATE,
    total_price DECIMAL(10,2),
    payment_status VARCHAR(20) DEFAULT 'unpaid', -- unpaid, paid
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE BookingRoom (
    booking_room_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    room_id INT,
    room_price DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50), -- credit_card, momo, etc
    status VARCHAR(20) DEFAULT 'completed',
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Service (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE RoomServiceUsage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_room_id INT,
    service_id INT,
    quantity INT DEFAULT 1,
    usage_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_room_id) REFERENCES BookingRoom(booking_room_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE Checkin (
    checkin_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_room_id INT,
    checkin_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_room_id) REFERENCES BookingRoom(booking_room_id)
);

CREATE TABLE Checkout (
    checkout_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_room_id INT,
    checkout_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    additional_fee DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (booking_room_id) REFERENCES BookingRoom(booking_room_id)
);