<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
    if (session.getAttribute("nd") == null) {
        response.sendRedirect("dangnhap");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>
	<title>Trang chủ</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body class="container mt-4">

	<!-- Header -->
	<div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">

		<!-- Nút Giỏ hàng -->
		<a href="xemgiohang.jsp" class="btn btn-warning d-flex align-items-center">
			<span class="ms-1">Giỏ hàng (
				<c:out value="${soSanPhamTrongGio}" /> )
			</span>
		</a>

		<!-- Nút Lịch sử đơn hàng -->
		<a href="lichsudonhang" class="btn btn-outline-primary d-flex align-items-center">
			<span class="ms-1">Lịch sử đơn hàng</span>
		</a>

		<!-- Nút Đăng xuất -->
		<a href="dangxuat" class="btn btn-danger d-flex align-items-center">
			<span class="ms-1">Đăng xuất</span>
		</a>
	</div>



	<!-- Admin Panel -->
	<c:if test="${nd.admin}">
		<div class="admin-panel">
			<h5 class="text-primary">Chức năng quản trị:</h5>
			<div class="d-flex gap-2 mt-2 mb-2">
				<a href="admin/sanpham" class="btn btn-outline-primary btn-sm">Quản lý sản phẩm</a>
				<a href="admin/donhang" class="btn btn-outline-primary btn-sm">Quản lý đơn hàng</a>
				<a href="admin/nguoidung" class="btn btn-outline-primary btn-sm">Quản lý người dùng</a>
			</div>
		</div>
	</c:if>
	<!-- Form filter product and find product  -->
	<form  action="trangchu" method="get" class="mb-4">
		<div class="row g-2">
			<div class="col-md-3">
				<input type="text" name="keyword" value="${param.keyword }" class="form-control"
					placeholder="Tìm theo tên...">
			</div>
			<div class="col-md-2">
				<select name="cpu" class="form-select">
					<option value="">-- CPU --</option>
					<option value="Intel" ${param.cpu=='Intel' ? 'selected' : '' }>Intel</option>
					<option value="AMD" ${param.cpu=='AMD' ? 'selected' : '' }>AMD</option>
					<option value="Apple" ${param.cpu=='Apple' ? 'selected' : '' }>Apple</option>
				</select>
			</div>
			<div class="col-md-2">
				<select name="ram" class="form-select">
					<option value="">-- RAM --</option>
					<option value="8GB" ${param.ram=='8GB' ? 'selected' : '' }>8GB</option>
					<option value="16GB" ${param.ram=='16GB' ? 'selected' : '' }>16GB</option>
				</select>
			</div>
			<div class="col-md-2">
				<input type="number" name="minPrice" value="${param.minPrice}" class="form-control"
					placeholder="Giá từ">
			</div>
			<div class="col-md-2">
				<input type="number" name="maxPrice" value="${param.maxPrice}" class="form-control"
					placeholder="Giá đến">
			</div>
			<div class="row mt-3">
				<div class="col text-center">
					<button type="submit" class="btn btn-primary me-2">Lọc</button>
					<button type="button" class="btn btn-secondary" onclick="resetForm()">Reset</button>
					<!-- <a href="trangchu" class="btn btn-secondary">⬅ Trang Chủ</a> -->
				</div>
			</div>
		</div>
	</form>
	<script>
		function resetForm() {
			const form = document.querySelector('form');

			// Xóa tất cả input type text, number
			form.querySelectorAll('input[type="text"], input[type="number"]').forEach(input => input.value = '');

			// Reset các select
			form.querySelectorAll('select').forEach(select => select.selectedIndex = 0);

			// Submit về trang chủ
			form.submit(); 
		}
	</script>


	<!-- Danh sách sản phẩm -->
	<div class="row">
		<c:forEach var="sp" items="${danhSachSanPham}">
			<div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
				<div class="card h-100">
					<img src="images/${sp.hinhAnh}" class="card-img-top" alt="Laptop">
					<div class="card-body">
						<h5 class="card-title">${sp.tenSanPham}</h5>
						<p class="card-text">
							<fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" />₫
						</p>
						<div class="d-flex gap-2">
							<a href="chitietsanpham?id=${sp.maSanPham}" class="btn btn-primary btn-sm">Xem chi tiết</a>
							<a href="themvaogio?id=${sp.maSanPham}" class="btn btn-success btn-sm">Thêm vào giỏ hàng</a>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<!-- PHÂN TRANG -->
	<nav class="mt-4">
		<ul class="pagination justify-content-center">
			<!-- Nút "Trang trước" -->
			<c:if test="${trangHienTai > 1}">
				<li class="page-item">
					<%-- <a class="page-link" href="trangchu?page=${trangHienTai - 1}">&laquo;Trước</a> --%>
						<a class="page-link"
							href="trangchu?page=${trangHienTai - 1}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">&laquo;Trước</a>
				</li>
			</c:if>
			<!-- Các số trang -->
			<c:forEach var="i" begin="1" end="${tongTrang}">
				<li class="page-item ${i == trangHienTai ? 'active' : ''}">
					<a class="page-link"
						href="trangchu?page=${i}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">${i}</a>

				</li>
			</c:forEach>
			<!-- Nút "Trang sau" -->
			<c:if test="${trangHienTai < tongTrang}">
				<li class="page-item">
					<%-- <a class="page-link" href="trangchu?page=${trangHienTai + 1}">Sau &raquo;</a> --%>
						<a class="page-link"
							href="trangchu?page=${trangHienTai + 1}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">Sau
							&raquo;</a>
				</li>
			</c:if>
		</ul>
	</nav>



</body>

</html>
