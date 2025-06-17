CREATE DATABASE student_management;

USE student_management;

CREATE TABLE students (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE teachers (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age TINYINT UNSIGNED NOT NULL,
    country VARCHAR(100),
    CHECK (age >= 18),
    PRIMARY KEY (id)
);

INSERT INTO students (first_name, last_name) VALUES
('Minh', 'Nguyen Van'),
('Linh', 'Tran Thi'),
('An', 'Pham Duc'),
('Hoa', 'Le Thi'),
('Quang', 'Do Van');

INSERT INTO teachers (first_name, last_name, age, country) VALUES
('Tuan', 'Nguyen Van', 35, 'Vietnam'),
('Mai', 'Pham Thi', 28, 'Vietnam'),
('John', 'Smith', 45, 'USA'),
('Akira', 'Yamamoto', 39, 'Japan'),
('Maria', 'Garcia', 30, 'Spain');

SELECT id, CONCAT_WS(' ', last_name, first_name) AS full_name
FROM students;

SELECT id, CONCAT_WS(' ', last_name, first_name) AS full_name, country
FROM teachers;

EXPLAIN SELECT * FROM students;
