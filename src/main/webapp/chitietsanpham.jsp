<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${sp.tenSanPham}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
	 <!-- Header -->
    <div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">

	    <!-- Nút Giỏ hàng -->
	    <a href="xemgiohang.jsp" class="btn btn-warning d-flex align-items-center">
	        <span class="ms-1">Giỏ hàng (<c:out value="${soSanPhamTrongGio}" />)</span>
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
    <div class="row">
        <div class="col-md-5">
            <img src="images/${sp.hinhAnh}" class="img-fluid" alt="Laptop">
        </div>
        <div class="col-md-7">
            <h2>${sp.tenSanPham}</h2>
            <p><strong>Giá:</strong> <fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true"/>₫</p>
            <p><strong>Hãng:</strong> ${sp.hang}</p>
            <p><strong>CPU:</strong> ${sp.cpu}</p>
            <p><strong>RAM:</strong> ${sp.ram}</p>
            <p><strong>Ổ cứng:</strong> ${sp.oCung}</p>
            <p><strong>Màn hình:</strong> ${sp.manHinh}</p>
            <p><strong>Mô tả:</strong><br>${sp.moTa}</p>
            <a href="themvaogio?id=${sp.maSanPham}" class="btn btn-primary">Thêm vào giỏ hàng</a>
        	<a href="trangchu" class="btn btn-secondary">⬅ Trang Chủ</a>
        </div>
    </div>
</body>
</html>

