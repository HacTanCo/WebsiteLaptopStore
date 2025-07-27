<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Quản lý Sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
	<!-- Header -->
	<div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">
		<a href="${pageContext.request.contextPath}/trangchu" class="btn btn-secondary">⬅ Trang Chủ</a>
		<a href="${pageContext.request.contextPath}/dangxuat" class="btn btn-danger">🚪 Đăng xuất</a>
	</div>

	<c:if test="${not empty sessionScope.message}">
		<div id="flashMessage" class="alert alert-success text-center">
			${sessionScope.message}
		</div>
		<c:remove var="message" scope="session" />
	</c:if>

	<!-- Form lọc sản phẩm -->
	<form method="get" action="sanpham" class="mb-3 justify-content-center ">
		<div class="row g-2 justify-content-center">
			<div class="col-md-4">
				<input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm theo tên..." class="form-control ">
			</div>
			<%-- <div class="col-md-2">
				<select name="cpu" class="form-select">
					<option value="">-- CPU --</option>
					<option value="Intel" ${param.cpu=='Intel' ? 'selected' : ''}>Intel</option>
					<option value="AMD" ${param.cpu=='AMD' ? 'selected' : ''}>AMD</option>
					<option value="Apple" ${param.cpu=='Apple' ? 'selected' : ''}>Apple</option>
				</select>
			</div>
			<div class="col-md-2">
				<select name="ram" class="form-select">
					<option value="">-- RAM --</option>
					<option value="8GB" ${param.ram=='8GB' ? 'selected' : ''}>8GB</option>
					<option value="16GB" ${param.ram=='16GB' ? 'selected' : ''}>16GB</option>
				</select>
			</div> --%>
			<div class="col-md-2">
				<button class="btn btn-primary">Tìm kiếm</button>
			</div>
		</div>
	</form>

	<h2 class="mb-4 text-center">Quản lý Sản phẩm</h2>
	<a href="themsanpham" class="btn btn-success mb-3">+ Thêm sản phẩm</a>

	<table class="table table-bordered">
		<thead>
			<tr>
				<th>ID</th>
				<th>Tên</th>
				<th>Giá</th>
				<th>CPU</th>
				<th>RAM</th>
				<th>Hãng</th>
				<th>Hình ảnh</th>
				<th>Hành động</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="sp" items="${list}">
				<tr>
					<td>${sp.maSanPham}</td>
					<td>${sp.tenSanPham}</td>
					<td><fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" />₫</td>
					<td>${sp.cpu}</td>
					<td>${sp.ram}</td>
					<td>${sp.hang}</td>
					<td><img src="${pageContext.request.contextPath}/images/${sp.hinhAnh}" alt="${sp.tenSanPham}" width="60" /></td>
					<td>
						<a href="${pageContext.request.contextPath}/admin/suasanpham?maSanPham=${sp.maSanPham}" class="btn btn-sm btn-warning">Sửa</a>
						<form action="${pageContext.request.contextPath}/admin/xoasanpham" method="get" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
							<input type="hidden" name="maSanPham" value="${sp.maSanPham}" />
							<button type="submit" class="btn btn-sm btn-danger">Xóa</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- Pagination -->
	<nav>
		<ul class="pagination justify-content-center">
			<li class="page-item ${trangHienTai == 1 ? 'disabled' : ''}">
				<a class="page-link" href="?page=${trangHienTai - 1}&keyword=${param.keyword}">Trước</a>
			</li>
			<c:forEach begin="1" end="${tongTrang}" var="i">
				<li class="page-item ${i == trangHienTai ? 'active' : ''}">
					<a class="page-link" href="?page=${i}&keyword=${param.keyword}">${i}</a>
				</li>
			</c:forEach>
			<li class="page-item ${trangHienTai == tongTrang ? 'disabled' : ''}">
				<a class="page-link" href="?page=${trangHienTai + 1}&keyword=${param.keyword}">Sau</a>
			</li>
		</ul>
	</nav>

	<script>
		setTimeout(function () {
			var flash = document.getElementById("flashMessage");
			if (flash) {
				flash.style.transition = "opacity 0.5s ease-out";
				flash.style.opacity = 0;
				setTimeout(function () {
					flash.remove();
				}, 500);
			}
		}, 5000);
	</script>
</body>
</html>
