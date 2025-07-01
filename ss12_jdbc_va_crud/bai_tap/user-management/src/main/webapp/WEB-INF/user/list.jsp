<%--
  Created by IntelliJ IDEA.
  User: YunYing
  Date: 7/1/2025
  Time: 9:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Danh sách người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<c:if test="${not empty sessionScope.successMessage}">
    <div class="position-fixed top-0 end-0 p-3 z-3" data-bs-delay="2000">
        <div id="successToast" class="toast align-items-center text-bg-success border-0"
             role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
            <div class="d-flex">
                <div class="toast-body">${sessionScope.successMessage}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="position-fixed top-0 end-0 p-3 z-3" data-bs-delay="2000">
        <div id="errorToast" class="toast align-items-center text-bg-danger border-0"
             role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="3000">
            <div class="d-flex">
                <div class="toast-body">${sessionScope.errorMessage}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <c:remove var="errorMessage" scope="session"/>
</c:if>
<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3">Quản lý người dùng</h1>
        <a href="/user?action=create" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Thêm mới
        </a>
    </div>

    <!-- Filter & Search -->
    <form class="row gy-2 gx-3 align-items-center mb-4">
        <div class="col-sm-4">
            <input type="text" class="form-control" placeholder="Tìm kiếm theo quốc gia..." name="q"
                   value="${searchKeyword}">
        </div>
        <div class="col-sm-2">
            <button type="submit" class="btn btn-outline-secondary w-100">
                <i class="bi bi-search"></i> Tìm kiếm
            </button>
        </div>
        <c:if test="${not empty searchKeyword}">
            <div class="col-sm-2">
                <a href="/user" class="btn btn-outline-primary w-100">
                    <i class="bi bi-arrow-clockwise"></i> Đặt lại
                </a>
            </div>
        </c:if>
    </form>

    <c:choose>
        <c:when test="${users.size() > 0}">
            <!-- Table -->
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                    <tr>
                        <th scope="col">STT</th>
                        <th scope="col">
                            <span>Tên</span>
                            <span>
                                <a href="?<c:if test='${not empty param.q}'>q=${param.q}&amp;</c:if>sort=name&dir=asc" class="text-decoration-none ${param.sort=='name' && param.dir=='asc' ? 'invisible' : ''}">
                                    <i class="bi bi-sort-alpha-down"></i>
                                </a>
                                <a href="?<c:if test='${not empty param.q}'>q=${param.q}&amp;</c:if>sort=name&dir=desc" class="text-decoration-none ${param.sort=='name' && param.dir=='desc' ? 'invisible' : ''}">
                                    <i class="bi bi-sort-alpha-down-alt"></i>
                                </a>
                            </span>
                        </th>
                        <th scope="col">
                            <span>Email</span>
                            <span>
                                <a href="?<c:if test='${not empty param.q}'>q=${param.q}&amp;</c:if>sort=email&dir=asc" class="text-decoration-none ${param.sort=='email' && param.dir=='asc' ? 'invisible' : ''}">
                                    <i class="bi bi-sort-alpha-down"></i>
                                </a>
                                <a href="?<c:if test='${not empty param.q}'>q=${param.q}&amp;</c:if>sort=email&dir=desc" class="text-decoration-none ${param.sort=='email' && param.dir=='desc' ? 'invisible' : ''}">
                                    <i class="bi bi-sort-alpha-down-alt"></i>
                                </a>
                            </span>
                        </th>
                        <th scope="col">
                            <span>Quốc gia</span>
                            <span>
                                <a href="?<c:if test='${not empty param.q}'>q=${param.q}&amp;</c:if>sort=country&dir=asc" class="text-decoration-none ${param.sort=='country' && param.dir=='asc' ? 'invisible' : ''}">
                                    <i class="bi bi-sort-alpha-down"></i>
                                </a>
                                <a href="?<c:if test='${not empty param.q}'>q=${param.q}&amp;</c:if>sort=country&dir=desc" class="text-decoration-none ${param.sort=='country' && param.dir=='desc' ? 'invisible' : ''}">
                                    <i class="bi bi-sort-alpha-down-alt"></i>
                                </a>
                            </span>
                        </th>
                        <th scope="col" class="text-center">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.country}</td>
                            <td class="text-center">
                                <a href="/user?action=detail&id=${user.id}" class="btn btn-sm btn-info"
                                   title="Xem chi tiết">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="/user?action=update&id=${user.id}" class="btn btn-sm btn-warning"
                                   title="Cập nhật">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <button
                                        class="btn btn-sm btn-danger"
                                        title="Xóa"
                                        data-bs-toggle="modal"
                                        data-bs-target="#deleteModal"
                                        data-id="${user.id}"
                                >
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <p class="text-center text-warning">Chưa có bản ghi nào!</p>
        </c:otherwise>
    </c:choose>

</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc muốn xóa người dùng <strong id="modalUserId"></strong> không?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form id="deleteForm" action="/user?action=delete" method="post">
                    <input type="hidden" name="id">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const showToast = (id) => {
            const toastEl = document.getElementById(id);
            if (!toastEl) return;                    // nếu element không có, thôi
            const toast = bootstrap.Toast.getOrCreateInstance(toastEl);
            toast.show();
        };
        // Chỉ show nếu có trong DOM
        showToast('successToast');
        showToast('errorToast');

        let deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function (event) {
            let button = event.relatedTarget;
            let id = button.getAttribute('data-id');
            deleteModal.querySelector('#modalUserId').textContent = id;
            deleteModal.querySelector('input[name="id"]').value = id;
        });
    });
</script>
</body>
</html>

