CREATE DATABASE company;

USE company;

CREATE TABLE employees (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      department VARCHAR(50) NOT NULL,
      salary DECIMAL(10,2) NOT NULL
);

delimiter //
create trigger update_department
before insert on employees
for each row
begin
	if new.salary >= 5000 then
		set new.department = 'Management';
	elseif new.salary >= 3000 then
		set new.department = 'Sales';
	else
		set new.department = 'Support';
	end if;
end //
delimiter ;

INSERT INTO employees (name, department, salary) VALUES 
('John Doe', 'A', 3500),
('Jane Smith', 'A', 2000),
('David Johnson', 'A', 6000);

select * from employees;