package org.example.simplecalculator.service;

import java.util.Map;

public interface CalculatorService {
    float calculate(float firstOperand, float secondOperand, char operator) throws ArithmeticException, IllegalArgumentException;
    Map<String, String> validate(String firstOperand, String secondOperand, String operator);
}
