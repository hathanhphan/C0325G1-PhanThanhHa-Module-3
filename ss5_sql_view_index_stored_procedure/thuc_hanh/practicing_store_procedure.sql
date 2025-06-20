use classicmodels;

DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END //
DELIMITER ;
call findAllCustomers();

