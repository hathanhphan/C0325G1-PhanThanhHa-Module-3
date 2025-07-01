<%--
  Created by IntelliJ IDEA.
  User: YunYing
  Date: 6/30/2025
  Time: 8:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Danh sách khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous"></head>
<body>
<div class="container text-center">
    <h1>Danh sách khách hàng</h1>
    <c:choose>
        <c:when test="${customers.size() > 0}">
            <table class="table table-hover table-striped align-middle">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Tên</th>
                    <th scope="col">Ngày sinh</th>
                    <th scope="col">Địa chỉ</th>
                    <th scope="col">Ảnh</th>
                </tr>
                </thead>
                <tbody class="table-group-divider">
                <c:forEach var="customer" items="${customers}" varStatus="status">
                    <tr>
                        <th scope="row">${status.index + 1}</th>
                        <td>${customer.name}</td>
                        <td>${customer.dob.toString()}</td>
                        <td>${customer.address}</td>
                        <td><img src="${customer.avatarUrl}" alt="" class="object-fit-cover" height="100" width="100"></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p>Danh sách khách hàng rỗng!</p>
        </c:otherwise>
    </c:choose>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script></body>
</html>