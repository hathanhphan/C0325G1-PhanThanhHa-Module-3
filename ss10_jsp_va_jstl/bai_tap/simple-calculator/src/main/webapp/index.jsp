<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.HashMap,java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <title>Simple Calculator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
          crossorigin="anonymous">
</head>
<body>
<div class="container py-4">
    <h1>Simple Calculator</h1>

    <jsp:useBean id="errs" class="java.util.HashMap" scope="page"/>
    <c:if test="${not empty errors}">
        <c:set var="errs" value="${errors}" scope="page"/>
    </c:if>

    <form action="/calculate" method="post" class="row g-3" style="max-width: 400px;">
        <!-- First Operand -->
        <div class="col-12">
            <label for="firstOperand" class="form-label">First operand</label>
            <input type="number"
                   class="form-control ${errs.containsKey('firstOperand') ? 'is-invalid' : ''}"
                   id="firstOperand"
                   name="firstOperand"
                   value="${firstOperand != null ? firstOperand : ''}">
            <c:if test="${errs.containsKey('firstOperand')}">
                <div class="invalid-feedback">
                        ${errs['firstOperand']}
                </div>
            </c:if>
        </div>
        <!-- Operator -->
        <div class="col-12">
            <label for="operator" class="form-label">Operator</label>
            <select class="form-select ${errs.containsKey('operator') ? 'is-invalid' : ''}"
                    id="operator"
                    name="operator"
                    required>
                <option disabled value="">Choose operator...</option>
                <option value="+" ${operator=='+' ? 'selected' : ''}>+</option>
                <option value="-" ${operator=='-' ? 'selected' : ''}>-</option>
                <option value="*" ${operator=='*' ? 'selected' : ''}>*</option>
                <option value="/" ${operator=='/' ? 'selected' : ''}>/</option>
            </select>
            <c:if test="${errs.containsKey('operator')}">
                <div class="invalid-feedback">
                        ${errs['operator']}
                </div>
            </c:if>
        </div>
        <!-- Second Operand -->
        <div class="col-12">
            <label for="secondOperand" class="form-label">Second operand</label>
            <input type="number"
                   class="form-control ${errs.containsKey('secondOperand') ? 'is-invalid' : ''}"
                   id="secondOperand"
                   name="secondOperand"
                   value="${secondOperand != null ? secondOperand : ''}">
            <c:if test="${errs.containsKey('secondOperand')}">
                <div class="invalid-feedback">
                        ${errs['secondOperand']}
                </div>
            </c:if>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">Calculate</button>
        </div>
    </form>
    <c:if test="${not empty result}">
        <h3 class="mt-4">Result: ${result}</h3>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script>
</body>
</html>