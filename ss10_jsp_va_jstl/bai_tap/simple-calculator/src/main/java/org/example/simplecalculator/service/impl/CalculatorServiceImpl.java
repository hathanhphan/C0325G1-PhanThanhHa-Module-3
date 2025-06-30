package org.example.simplecalculator.service.impl;

import org.example.simplecalculator.service.CalculatorService;

import java.util.HashMap;
import java.util.Map;

public class CalculatorServiceImpl implements CalculatorService {
    @Override
    public float calculate(float firstOperand, float secondOperand, char operator) throws ArithmeticException, IllegalArgumentException {
        switch (operator){
            case '+':
                return firstOperand + secondOperand;
            case '-':
                return firstOperand - secondOperand;
            case '*':
                return firstOperand * secondOperand;
            case '/':
                if(secondOperand != 0)
                    return firstOperand / secondOperand;
                else
                    throw new ArithmeticException("Can't divide by zero");
            default:
                throw new IllegalArgumentException("Invalid operation");
        }
    }

    @Override
    public Map<String, String> validate(String firstOperand, String secondOperand, String operator) {
        Map<String, String> errors = new HashMap<>();

        if (firstOperand.isEmpty()) {
            errors.put("firstOperand", "First operand is required");
        } else if (!isFloatNumber(firstOperand)) {
            errors.put("firstOperand", "First operand must be a number");
        }

        if (secondOperand.isEmpty()) {
            errors.put("secondOperand", "Second operand is required");
        } else if (!isFloatNumber(secondOperand)) {
            errors.put("secondOperand", "Second operand must be a number");
        }

        if (operator.isEmpty()) {
            errors.put("operator", "Operator is required");
        } else if (!isOperator(operator)) {
            errors.put("operator", "Operator must be +, -, * or /");
        }
        return errors;
    }

    private boolean isFloatNumber(String value) {
        try {
            Float.parseFloat(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private boolean isOperator(String value) {
        if (value.length() != 1) {
            return false;
        }
        switch (value.charAt(0)) {
            case '+':
            case '-':
            case '*':
            case '/':
                return true;
            default:
                return false;
        }
    }
}
