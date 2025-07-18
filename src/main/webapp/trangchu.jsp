<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    if (session.getAttribute("nd") == null) {
        response.sendRedirect("dangnhap.jsp");
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-0">Chào mừng, <c:out value="${nd.hoTen}" /></h2>
            <p class="text-muted mb-0">Chúc bạn một ngày tốt lành!</p>
        </div>
        <div>
            <a href="dangxuat" class="btn btn-danger">Đăng xuất</a>
        </div>
    </div>

    <!-- Admin Panel -->
    <c:if test="${nd.admin}">
        <div class="admin-panel">
            <h5 class="text-primary">🔧 Chức năng quản trị:</h5>
            <div class="d-flex gap-2 mt-2">
                <a href="quanly-sanpham.jsp" class="btn btn-outline-primary btn-sm">Quản lý sản phẩm</a>
                <a href="quanly-donhang.jsp" class="btn btn-outline-primary btn-sm">Quản lý đơn hàng</a>
                <a href="quanly-nguoidung.jsp" class="btn btn-outline-primary btn-sm">Quản lý người dùng</a>
            </div>
        </div>
    </c:if>

    <!-- Danh sách sản phẩm -->
    <div class="row">
        <c:forEach var="sp" items="${danhSachSanPham}">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4" >
                <div class="card h-100">
                    <img src="images/${sp.hinhAnh}" class="card-img-top" alt="Laptop">
                    <div class="card-body">
                        <h5 class="card-title">${sp.tenSanPham}</h5>
                        <p class="card-text"><fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true"/>₫</p>
                        <a href="chitietsanpham?id=${sp.maSanPham}" class="btn btn-primary">Xem chi tiết</a>
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
                <a class="page-link" href="trangchu?page=${trangHienTai - 1}">&laquo;Trước</a>
            </li>
        </c:if>

        <!-- Các số trang -->
        <c:forEach var="i" begin="1" end="${tongTrang}">
            <li class="page-item ${i == trangHienTai ? 'active' : ''}">
                <a class="page-link" href="trangchu?page=${i}">${i}</a>
            </li>
        </c:forEach>

        <!-- Nút "Trang sau" -->
        <c:if test="${trangHienTai < tongTrang}">
            <li class="page-item">
                <a class="page-link" href="trangchu?page=${trangHienTai + 1}">Sau &raquo;</a>
            </li>
        </c:if>

    </ul>
</nav>

    
</body>
</html>
