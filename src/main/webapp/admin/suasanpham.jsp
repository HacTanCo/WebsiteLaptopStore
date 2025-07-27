<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
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
    <h2 class="mb-4" style="text-align: center;">Sửa sản phẩm</h2>

    <form action="suasanpham" method="post">
        <input type="hidden" name="maSanPham" value="${sp.maSanPham}">

        <div class="mb-3">
            <label>Tên sản phẩm:</label>
            <input type="text" name="tenSanPham" class="form-control" value="${sp.tenSanPham}" required>
        </div>

        <div class="mb-3">
            <label>Giá:</label>
            <%-- <input type="number" step="0.01" name="gia" class="form-control" value="${sp.gia}" required> --%>
            <input type="number" step="0.01" name="gia" class="form-control" value="${giaFormatted}" required>
            
        </div>

        <div class="mb-3">
            <label>Hãng:</label>
            <input type="text" name="hang" class="form-control" value="${sp.hang}" required>
        </div>

        <div class="mb-3">
            <label>CPU:</label>
            <input type="text" name="cpu" class="form-control" value="${sp.cpu}" required>
        </div>

        <div class="mb-3">
            <label>RAM:</label>
            <input type="text" name="ram" class="form-control" value="${sp.ram}" required>
        </div>

        <div class="mb-3">
            <label>Ổ cứng:</label>
            <input type="text" name="oCung" class="form-control" value="${sp.oCung}" required>
        </div>

        <div class="mb-3">
            <label>Màn hình:</label>
            <input type="text" name="manHinh" class="form-control" value="${sp.manHinh}" required>
        </div>

        <div class="mb-3">
            <label>Mô tả:</label>
            <textarea name="moTa" class="form-control" rows="4">${sp.moTa}</textarea>
        </div>

        <div class="mb-3">
            <label>Hình ảnh hiện tại:</label><br>
            <input type="text" name="hinhAnh" value="${sp.hinhAnh }">
        </div>

        <div class="d-flex justify-content-center align-items-center mb-3 gap-2">
        	<button type="submit" class="btn btn-primary">Cập nhật sản phẩm</button>
        	<a href="sanpham" class="btn btn-secondary">Hủy</a>
        </div>
    </form>

</body>
</html>

