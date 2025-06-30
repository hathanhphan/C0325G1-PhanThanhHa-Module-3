package org.example.simplecalculator.controller;

import org.example.simplecalculator.service.CalculatorService;
import org.example.simplecalculator.service.impl.CalculatorServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "calculatorController", urlPatterns = {"/calculate", "/"})
public class CalculatorController extends HttpServlet {
    private static final CalculatorService calculatorService = new CalculatorServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstOperand = req.getParameter("firstOperand");
        String secondOperand = req.getParameter("secondOperand");
        String operator = req.getParameter("operator");
        Map<String, String> errors = calculatorService.validate(firstOperand, secondOperand, operator);
        req.setAttribute("errors", errors);
        if (errors.isEmpty()) {
            req.setAttribute("firstOperand", firstOperand);
            req.setAttribute("secondOperand", secondOperand);
            req.setAttribute("operator", operator);
            try {
                float result = calculatorService.calculate(
                        Float.parseFloat(firstOperand),
                        Float.parseFloat(secondOperand),
                        operator.charAt(0)
                );
                req.setAttribute("result", result);
            } catch (ArithmeticException | IllegalArgumentException e) {
                req.setAttribute("result", e.getMessage());
            }
        }
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
