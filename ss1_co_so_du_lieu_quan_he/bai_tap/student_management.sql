CREATE DATABASE student_management;

USE student_management;

CREATE TABLE classes (
    id INT AUTO_INCREMENT,
    class_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE students (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age TINYINT UNSIGNED NOT NULL,
    country VARCHAR(100),
    CHECK (age >= 0 AND age <= 120),
    PRIMARY KEY (id)
);

CREATE TABLE teachers (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age TINYINT UNSIGNED NOT NULL,
    country VARCHAR(100),
    CHECK (age >= 18 AND age <= 120),
    PRIMARY KEY (id)
);

INSERT INTO classes (class_name) VALUES
('60.CNTT-1'),
('60.CNTT-2'),
('60.CNTT-3'),
('61.CNTT-1'),
('61.CNTT-2'),
('61.CNTT-3');

INSERT INTO students (first_name, last_name, age, country) VALUES
('Minh', 'Nguyen Van', 18, 'Vietnam'),
('Linh', 'Tran Thi', 20, 'Vietnam'),
('An', 'Pham Duc', 21, 'Vietnam'),
('Hoa', 'Le Thi', 18, 'Vietnam'),
('Quang', 'Do Van', 19, 'Vietnam');

INSERT INTO teachers (first_name, last_name, age, country) VALUES
('Tuan', 'Nguyen Van', 35, 'Vietnam'),
('Mai', 'Pham Thi', 28, 'Vietnam'),
('John', 'Smith', 45, 'USA'),
('Akira', 'Yamamoto', 39, 'Japan'),
('Maria', 'Garcia', 30, 'Spain');

SELECT id, class_name
FROM classes;

SELECT id, CONCAT_WS(' ', last_name, first_name) AS full_name , age, country
FROM students;

SELECT id, CONCAT_WS(' ', last_name, first_name) AS full_name, age, country
FROM teachers;
