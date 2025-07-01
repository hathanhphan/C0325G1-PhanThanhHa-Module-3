<%--
  Created by IntelliJ IDEA.
  User: YunYing
  Date: 7/1/2025
  Time: 10:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>
        <c:choose>
            <c:when test="${not empty user.id}">Cập nhật người dùng</c:when>
            <c:otherwise>Thêm mới người dùng</c:otherwise>
        </c:choose>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.0/font/bootstrap-icons.css" rel="stylesheet"/>
</head>
<body>
<div class="container my-5">
    <h1 class="mb-4">
        <c:choose>
            <c:when test="${not empty user.id}">
                <i class="bi bi-pencil-square"></i> Cập nhật người dùng
            </c:when>
            <c:otherwise>
                <i class="bi bi-plus-lg"></i> Thêm mới người dùng
            </c:otherwise>
        </c:choose>
    </h1>

    <c:choose>
        <c:when test="${not empty user.id}">
            <c:set var="actionUrl" value="/user?action=update&id=${user.id}"/>
        </c:when>
        <c:otherwise>
            <c:set var="actionUrl" value="/user?action=create"/>
        </c:otherwise>
    </c:choose>

    <form action="${actionUrl}" method="post" novalidate>
        <!-- ID (hidden khi update) -->
        <c:if test="${not empty user.id}">
            <input type="hidden" name="id" value="${user.id}"/>
            <div class="mb-3">
                <label class="form-label">Mã người dùng</label>
                <input type="text" class="form-control" value="${user.id}" disabled/>
            </div>
        </c:if>

        <!-- Tên người dùng -->
        <div class="mb-3">
            <label for="name" class="form-label">Tên người dùng</label>
            <input
                    type="text"
                    id="name" name="name"
                    class="form-control ${errors.name != null ? 'is-invalid' : ''}"
                    value="${user.name}"
            />
            <div class="invalid-feedback">${errors.name}</div>
        </div>

        <!-- Email người dùng -->
        <div class="mb-3">
            <label for="email" class="form-label">Email người dùng</label>
            <input
                    type="text"
                    id="email" name="email"
                    class="form-control ${errors.email != null ? 'is-invalid' : ''}"
                    value="${user.email}"
            />
            <div class="invalid-feedback">${errors.email}</div>
        </div>

        <!-- Quốc gia -->
        <div class="mb-3">
            <label for="country" class="form-label">Quốc gia</label>
            <input
                    type="text"
                    id="country" name="country"
                    class="form-control ${errors.country != null ? 'is-invalid' : ''}"
                    value="${user.country}"
            />
            <div class="invalid-feedback">${errors.country}</div>
        </div>

        <!-- Buttons -->
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${not empty user.id}">Cập nhật</c:when>
                    <c:otherwise>Thêm mới</c:otherwise>
                </c:choose>
            </button>
            <a href="/user" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
