<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
	<!-- Header -->
	<div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">
		<a href="${pageContext.request.contextPath}/admin/sanpham" class="btn btn-secondary">⬅ Quay lại</a>
		<a href="${pageContext.request.contextPath}/dangxuat" class="btn btn-danger">🚪 Đăng xuất</a>
	</div>
	
	<c:if test="${not empty err}">
        <div class="alert alert-danger">${err}</div>
    </c:if>
    <c:if test="${not empty thongBao}">
        <div class="alert alert-success">${thongBao}</div>
    </c:if>
	
    <h2 style="text-align: center;">Thêm Sản Phẩm Mới</h2>
    <form action="${pageContext.request.contextPath}/admin/themsanpham" method="post" >
        <div class="mb-3"><label class="form-label">Tên sản phẩm</label><input type="text" name="tenSanPham" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Giá</label><input type="number" step="0.01" name="gia" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Hãng</label><input type="text" name="hang" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">CPU</label><input type="text" name="cpu" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">RAM</label><input type="text" name="ram" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Ổ cứng</label><input type="text" name="oCung" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Màn hình</label><input type="text" name="manHinh" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Mô tả</label><input type="text" name="moTa" class="form-control" required></div>
        <div class="mb-3"><label class="form-label">Hình ảnh</label><input type="text" name="hinhAnh" class="form-control" required placeholder="URL hình ảnh hoặc tên file nếu upload sau"></div>
        <div class="d-flex justify-content-center"><button type="submit" class="btn btn-primary mb-3">Thêm sản phẩm</button></div>
    </form>
</body>
</html>
    