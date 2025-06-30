package org.example.displaycustomerlist.repository.impl;

import org.example.displaycustomerlist.entity.Customer;
import org.example.displaycustomerlist.repository.CustomerRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepositoryImpl implements CustomerRepository {
    public static List<Customer> customers = new ArrayList<>();

    public CustomerRepositoryImpl() {
        customers.add(new Customer(1, "Mai Văn Hoàn", LocalDate.parse("1983-08-20"), "Hà Nội", "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"));
        customers.add(new Customer(2, "Nguyễn Văn Nam", LocalDate.parse("1983-08-21"), "Bắc Giang", "https://plus.unsplash.com/premium_photo-1671656349218-5218444643d8?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"));
        customers.add(new Customer(3, "Nguyễn Thái Hoà", LocalDate.parse("1983-08-22"), "Nam Định", "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"));
        customers.add(new Customer(4, "Trần Đăng Khoa", LocalDate.parse("1983-08-17"), "Hà Tây", "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"));
        customers.add(new Customer(5, "Nguyễn Đình Thi", LocalDate.parse("1983-08-19"), "Hà Nội", "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"));
    }

    @Override
    public List<Customer> findAll() {
        return customers;
    }
}
