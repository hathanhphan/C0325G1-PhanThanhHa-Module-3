package org.example.displaycustomerlist.service.impl;

import org.example.displaycustomerlist.entity.Customer;
import org.example.displaycustomerlist.repository.CustomerRepository;
import org.example.displaycustomerlist.repository.impl.CustomerRepositoryImpl;
import org.example.displaycustomerlist.service.CustomerService;

import java.util.List;

public class CustomerServiceImpl implements CustomerService {
    private static final CustomerRepository customerRepository = new CustomerRepositoryImpl();

    @Override
    public List<Customer> getAll() {
        return customerRepository.findAll();
    }
}
