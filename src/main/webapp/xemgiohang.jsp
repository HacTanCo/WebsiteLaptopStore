<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="model.NguoiDung" %>
<%@ page import="dao.GioHangDAO" %>
<%@ page import="model.GioHangItem" %>
<%@ page import="java.util.List" %>

<%
    NguoiDung nd = (NguoiDung) session.getAttribute("nd");
    if (nd == null) {
        response.sendRedirect("dangnhap");
        return;
    }

    List<GioHangItem> gioHang = new GioHangDAO().layGioHangTheoNguoiDung(nd.getMaNguoiDung());
    request.setAttribute("gioHang", gioHang);
%>

<html>
<head>
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
	 <!-- Header -->
    <div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">

	    <!-- Nút Giỏ hàng -->
	  <%--   <a href="xemgiohang.jsp" class="btn btn-warning d-flex align-items-center">
	        🛒 <span class="ms-1">Giỏ hàng (<c:out value="${soSanPhamTrongGio}" />)</span>
	    </a> --%>
	
	    <!-- Nút Lịch sử đơn hàng -->
	    <a href="lichsudonhang" class="btn btn-outline-primary d-flex align-items-center">
	        📦 <span class="ms-1">Lịch sử đơn hàng</span>
	    </a>
	
	    <!-- Nút Đăng xuất -->
	    <a href="dangxuat" class="btn btn-danger d-flex align-items-center">
	        🚪 <span class="ms-1">Đăng xuất</span>
	    </a>
	</div>
	<%
	    String thongBao = (String) session.getAttribute("thongBao");
	    if (thongBao != null) {
	%>
	    <div class="alert alert-warning" role="alert">
	        <%= thongBao %>
	    </div>
	<%
	        session.removeAttribute("thongBao"); // Xóa sau khi hiển thị
	    }
	%>
	
    <h2 class="mb-4">🛒 Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${empty gioHang}">
            <div class="alert alert-info">Giỏ hàng của bạn đang trống.</div>
        </c:when>
        <c:otherwise>
            <table class="table table-bordered text-center align-middle">
                <thead class="table-light">
				    <tr>
				        <th>Hình ảnh</th>
				        <th>Tên sản phẩm</th>
				        <th>Giá</th>
				        <th>Số lượng</th>
				        <th>Thành tiền</th>
				        <th>Xóa</th>
				    </tr>
				</thead>
				<tbody>
				    <c:set var="tongTien" value="0" />
				    <c:forEach var="item" items="${gioHang}">
				        <c:set var="sp" value="${item.sanPham}" />
				        <c:set var="thanhTien" value="${sp.gia * item.soLuong}" />
				        <c:set var="tongTien" value="${tongTien + thanhTien}" />
				        <tr>
				            <td><img src="images/${sp.hinhAnh}" width="80"/></td>
				            <td>${sp.tenSanPham}</td>
				            <td><fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true"/>₫</td>
				
				            <!-- Form sửa số lượng -->
				            <td>
				                <form action="suagiohang" method="post" class="d-flex justify-content-center">
				                    <input type="hidden" name="maSanPham" value="${sp.maSanPham}" />
				                    <input type="number" name="soLuong" value="${item.soLuong}" min="1" class="form-control w-50" />
				                    <button type="submit" class="btn btn-primary btn-sm ms-2">✔</button>
				                </form>
				            </td>
				
				            <td><fmt:formatNumber value="${thanhTien}" type="number" groupingUsed="true"/>₫</td>
				
				            <td>
				                <a href="xoagiohang?maSanPham=${sp.maSanPham}" class="btn btn-danger btn-sm">🗑️</a>
				            </td>
				        </tr>
				    </c:forEach>
				</tbody>

                <tfoot>
                    <tr>
                        <th colspan="4" class="text-end">Tổng cộng:</th>
                        <th><fmt:formatNumber value="${tongTien}" type="number" groupingUsed="true"/>₫</th>
                    </tr>
                </tfoot>
            </table>
        </c:otherwise>
    </c:choose>

    <div class="d-flex justify-content-end align-items-center mt-4 mb-4 flex-wrap gap-2">
	    <!-- Nút quay lại mua sắm -->
	    <a href="trangchu" class="btn btn-secondary">
	        ⬅ Trang Chủ
	    </a>
	
	    <!-- Nút tiến hành đặt hàng -->
	    <form action="dathang" method="post" class="m-0">
	        <button type="submit" class="btn btn-success">
	            🛍️ Mua Hàng
	        </button>
	    </form>
	</div>

</body>
</html>

    