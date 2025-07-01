<%--
  Created by IntelliJ IDEA.
  User: YunYing
  Date: 7/1/2025
  Time: 10:18 AM
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
    <title>Chi tiết người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.0/font/bootstrap-icons.css" rel="stylesheet"/>
</head>
<body>
<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3"><i class="bi bi-eye"></i> Chi tiết người dùng</h1>
        <a href="/user" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
    </div>

    <div class="card">
        <div class="card-body">
            <dl class="row">
                <dt class="col-sm-3">Mã người dùng</dt>
                <dd class="col-sm-9">${user.id}</dd>

                <dt class="col-sm-3">Tên người dùng</dt>
                <dd class="col-sm-9">${user.name}</dd>

                <dt class="col-sm-3">Email người dùng</dt>
                <dd class="col-sm-9">${user.email}</dd>

                <dt class="col-sm-3">Quốc gia</dt>
                <dd class="col-sm-9">${user.country}</dd>
            </dl>
        </div>
        <div class="card-footer text-end">
            <a href="/user?action=update&id=${user.id}"
               class="btn btn-warning">
                <i class="bi bi-pencil-square"></i> Cập nhật
            </a>
            <button class="btn btn-danger"
                    data-bs-toggle="modal"
                    data-bs-target="#deleteModal"
                    data-id="${user.id}">
                <i class="bi bi-trash"></i> Xóa
            </button>
        </div>
    </div>

    <!-- Modal xác nhận xóa (copy lại từ list.jsp) -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
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

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let deleteModal = document.getElementById('deleteModal');
    deleteModal.addEventListener('show.bs.modal', function (e) {
        let btn = e.relatedTarget;
        let id = btn.getAttribute('data-id');
        deleteModal.querySelector('#modalUserId').textContent = id;
        deleteModal.querySelector('input[name="id"]').value = id;
    });
</script>
</body>
</html>

