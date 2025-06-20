use classicmodels;

create view customers_view as
select customerNumber, customerName, phone
from customers;

select * from customers_view;