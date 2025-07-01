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
            <c:when test="${not empty product.id}">Cập nhật sản phẩm</c:when>
            <c:otherwise>Thêm mới sản phẩm</c:otherwise>
        </c:choose>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.0/font/bootstrap-icons.css" rel="stylesheet"/>
</head>
<body>
<div class="container my-5">
    <h1 class="mb-4">
        <c:choose>
            <c:when test="${not empty product.id}">
                <i class="bi bi-pencil-square"></i> Cập nhật sản phẩm
            </c:when>
            <c:otherwise>
                <i class="bi bi-plus-lg"></i> Thêm mới sản phẩm
            </c:otherwise>
        </c:choose>
    </h1>

    <c:choose>
        <c:when test="${not empty product.id}">
            <c:set var="actionUrl" value="/product?action=update&id=${product.id}"/>
        </c:when>
        <c:otherwise>
            <c:set var="actionUrl" value="/product?action=create"/>
        </c:otherwise>
    </c:choose>

    <form action="${actionUrl}" method="post" novalidate>
        <!-- ID (hidden khi update) -->
        <c:if test="${not empty product.id}">
            <input type="hidden" name="id" value="${product.id}"/>
            <div class="mb-3">
                <label class="form-label">Mã sản phẩm</label>
                <input type="text" class="form-control" value="${product.id}" disabled/>
            </div>
        </c:if>

        <!-- Tên sản phẩm -->
        <div class="mb-3">
            <label for="name" class="form-label">Tên sản phẩm</label>
            <input
                    type="text"
                    id="name" name="name"
                    class="form-control ${errors.name != null ? 'is-invalid' : ''}"
                    value="${product.name}"
            />
            <div class="invalid-feedback">${errors.name}</div>
        </div>

        <!-- Giá (VNĐ) -->
        <div class="mb-3">
            <label for="price" class="form-label">Giá (VNĐ)</label>
            <input
                    type="number"
                    step="0.01"
                    id="price" name="price"
                    class="form-control ${errors.price != null ? 'is-invalid' : ''}"
                    value="<fmt:formatNumber value='${product.price}' pattern='0' />"
            />
            <div class="invalid-feedback">${errors.price}</div>
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea
                    id="description" name="description"
                    rows="4"
                    class="form-control ${errors.description != null ? 'is-invalid' : ''}"
            >${product.description}</textarea>
            <div class="invalid-feedback">${errors.description}</div>
        </div>

        <!-- Nhà sản xuất -->
        <div class="mb-3">
            <label for="manufacturerName" class="form-label">Nhà sản xuất</label>
            <input
                    type="text"
                    id="manufacturerName" name="manufacturerName"
                    class="form-control ${errors.manufacturerName != null ? 'is-invalid' : ''}"
                    value="${product.manufacturerName}"
            />
            <div class="invalid-feedback">${errors.manufacturerName}</div>
        </div>

        <!-- Buttons -->
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${not empty product.id}">Cập nhật</c:when>
                    <c:otherwise>Thêm mới</c:otherwise>
                </c:choose>
            </button>
            <a href="/product" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
