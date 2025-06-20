use classicmodels;

-- Tham so IN
delimiter //
create procedure get_customer_by_id(in p_customer_number int)
begin
	select * from customers where customerNumber = p_customer_number;
end //
delimiter ;

call get_customer_by_id(175);

-- Tham so OUT
delimiter //
create procedure get_customers_count_by_country(in p_city varchar(50), out total int)
begin
	select count(customerNumber)
    into total
    from customers
    where city = p_city;
end //
delimiter ;

call get_customers_count_by_country('Lyon', @total);
select @total;

-- Tham so INOUT
delimiter //
create procedure set_counter(inout counter int, in inc int)
begin
	set counter = counter + inc;
end //
delimiter ;

set @counter = 1;
call set_counter(@counter, 1);
call set_counter(@counter, 2);
call set_counter(@counter, 5);
select @counter;