package org.example.displaycustomerlist.controller;

import org.example.displaycustomerlist.entity.Customer;
import org.example.displaycustomerlist.service.CustomerService;
import org.example.displaycustomerlist.service.impl.CustomerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "customerController", urlPatterns = "/customer")
public class CustomerController extends HttpServlet {
    private static final CustomerService customerService = new CustomerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Customer> customers = customerService.getAll();
        req.setAttribute("customers", customers);
        req.getRequestDispatcher("WEB-INF/customer/index.jsp").forward(req, resp);
    }
}
