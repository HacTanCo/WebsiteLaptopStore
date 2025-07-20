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
                            <td>${item.soLuong}</td>
                            <td><fmt:formatNumber value="${thanhTien}" type="number" groupingUsed="true"/>₫</td>
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

    <div class="mt-3">
        <a href="trangchu" class="btn btn-secondary">⬅ Tiếp tục mua sắm</a>
        <a href="#" class="btn btn-success">🛍️ Tiến hành đặt hàng</a>
    </div>
</body>
</html>

    