<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ChiTietDonHang" %>

<html>
<head>
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
	<!-- Header -->
	<div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">
		<a href="${pageContext.request.contextPath}/admin/donhang" class="btn btn-secondary">Quay Lại</a>
		<a href="${pageContext.request.contextPath}/dangxuat" class="btn btn-danger">Đăng xuất</a>
	</div>
	
    <h2 class="text-center">Chi tiết đơn hàng #${maDonHang}</h2>
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>Mã SP</th>
                <th>Tên sản phẩm</th>
                <th>Đơn giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ct" items="${chiTietList}">
                <tr>
                    <td>${ct.maSanPham}</td>
                    <td>${ct.tenSanPham}</td>
                    <td><fmt:formatNumber value="${ct.donGia}" type="currency" currencySymbol="₫"/></td>
                    <td>${ct.soLuong}</td>
                    <td><fmt:formatNumber value="${ct.thanhTien}" type="currency" currencySymbol="₫"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
</div>
</body>
</html>

