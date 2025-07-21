<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.DonHang" %>

<%
    List<DonHang> danhSach = (List<DonHang>) request.getAttribute("danhSachDonHang");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
	<!-- Header -->
    <div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">

	    <!-- Nút Giỏ hàng -->
	    <a href="xemgiohang.jsp" class="btn btn-warning d-flex align-items-center">
	        🛒 <span class="ms-1">Giỏ hàng (<c:out value="${soSanPhamTrongGio}" />)</span>
	    </a>
	
	    <!-- Nút Lịch sử đơn hàng -->
	    <a href="lichsudonhang" class="btn btn-outline-primary d-flex align-items-center">
	        📦 <span class="ms-1">Lịch sử đơn hàng</span>
	    </a>
	
	    <!-- Nút Đăng xuất -->
	    <a href="dangxuat" class="btn btn-danger d-flex align-items-center">
	        🚪 <span class="ms-1">Đăng xuất</span>
	    </a>
	</div>
	<div class="container mt-5">
	    <h3>Lịch sử đơn hàng</h3>
	    <c:if test="${empty danhSachDonHang}">
	        <p>Bạn chưa đặt đơn hàng nào.</p>
	    </c:if>
	
	    <c:if test="${not empty danhSachDonHang}">
	        <table class="table table-bordered">
	            <thead>
	                <tr>
	                    <th>Mã đơn hàng</th>
	                    <th>Ngày đặt</th>
	                    <th>Tổng tiền</th>
	                    <th>Trạng thái</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:forEach var="dh" items="${danhSachDonHang}">
	                    <tr>
	                        <td>${dh.maDonHang}</td>
	                        <td>${dh.ngayDat}</td>
	                        <td><fmt:formatNumber value="${dh.tongTien}" type="number" groupingUsed="true"/>₫</td>
	                        <td>${dh.trangThai}</td>
	                    </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	    </c:if>
	    <div class="text-end mt-3">
		    <a href="trangchu" class="btn btn-secondary d-inline-flex align-items-center gap-2 px-3 py-2 shadow-sm">
		        ⬅ <span>Trang Chủ</span>
		    </a>
		</div>
	</div>
</body>
</html>
