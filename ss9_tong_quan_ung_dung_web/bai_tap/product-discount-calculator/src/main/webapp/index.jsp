<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Product Discount Calculator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <form action="display-discount" method="post">
        <fieldset>
            <legend>Product Discount Calculator</legend>
            <div class="mb-3">
                <label for="product-description" class="form-label">Mô tả của sản phẩm</label>
                <input type="text" id="product-description" name="product-description" class="form-control" required autofocus>
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Giá niêm yết của sản phẩm</label>
                <input type="number" id="price" name="price" class="form-control" min="0" max="9999999999" required>
            </div>
            <div class="mb-3">
                <label for="discount-percent" class="form-label">Tỷ lệ chiết khấu (%)</label>
                <input type="number" id="discount-percent" name="discount-percent" class="form-control" min="0" max="100" required>
            </div>
            <button type="submit" class="btn btn-primary">Tính chiết khấu</button>
        </fieldset>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script>
</body>
</html>