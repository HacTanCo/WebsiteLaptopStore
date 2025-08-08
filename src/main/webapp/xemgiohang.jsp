<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .card-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .btn-hover:hover {
            transform: scale(1.05);
            transition: transform 0.2s ease;
        }
        .quantity-btn {
            width: 32px;
            height: 32px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
    <!-- Header -->
    <header class="bg-white shadow-md py-4">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center">
                <h1 class="text-2xl font-bold text-blue-600">Laptop Store</h1>
                <div class="flex items-center gap-3">
                    <!-- Lịch sử đơn hàng -->
                    <a href="lichsudonhang" class="flex items-center bg-white text-blue-600 border border-blue-600 px-4 py-2 rounded-lg btn-hover">
                        <span>Lịch sử đơn hàng</span>
                    </a>
                    <!-- Đăng xuất -->
                    <a href="dangxuat" class="flex items-center bg-red-500 text-white px-4 py-2 rounded-lg btn-hover">
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8 flex-grow">
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Giỏ hàng của bạn</h2>

        <%
            String thongBao = (String) session.getAttribute("thongBao");
            if (thongBao != null) {
        %>
            <div class="bg-yellow-100 text-yellow-800 p-4 rounded-lg mb-6">
                <%= thongBao %>
            </div>
        <%
                session.removeAttribute("thongBao"); // Xóa sau khi hiển thị
            }
        %>

        <c:choose>
            <c:when test="${empty gioHang}">
                <div class="bg-blue-100 text-blue-800 p-4 rounded-lg text-center">Giỏ hàng của bạn đang trống.</div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <table class="w-full text-center">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="p-4">Hình ảnh</th>
                                <th class="p-4">Tên sản phẩm</th>
                                <th class="p-4">Giá</th>
                                <th class="p-4">Số lượng</th>
                                <th class="p-4">Thành tiền</th>
                                <th class="p-4">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="tongTien" value="0" />
                            <c:forEach var="item" items="${gioHang}">
                                <c:set var="sp" value="${item.sanPham}" />
                                <c:set var="thanhTien" value="${sp.gia * item.soLuong}" />
                                <c:set var="tongTien" value="${tongTien + thanhTien}" />
                                <tr class="border-t card-hover">
                                    <td class="p-4">
                                        <div class="relative w-24 h-24 mx-auto">
                                            <img src="images/${sp.hinhAnh}" class="absolute top-0 left-0 w-full h-full object-contain" alt="Laptop">
                                        </div>
                                    </td>
                                    <td class="p-4 text-gray-800">${sp.tenSanPham}</td>
                                    <td class="p-4 text-red-500"><fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true"/>₫</td>
                                    <td class="p-4">
                                        <div class="flex justify-center items-center gap-2">
                                            <form action="suagiohang" method="post" class="m-0">
                                                <input type="hidden" name="maSanPham" value="${sp.maSanPham}" />
                                                <input type="hidden" name="thaoTac" value="giam" />
                                                <button type="submit" class="bg-gray-200 text-gray-800 quantity-btn hover:bg-gray-300 btn-hover">➖</button>
                                            </form>
                                            <span class="px-2 font-medium">${item.soLuong}</span>
                                            <form action="suagiohang" method="post" class="m-0">
                                                <input type="hidden" name="maSanPham" value="${sp.maSanPham}" />
                                                <input type="hidden" name="thaoTac" value="tang" />
                                                <button type="submit" class="bg-gray-200 text-gray-800 quantity-btn hover:bg-gray-300 btn-hover">➕</button>
                                            </form>
                                        </div>
                                    </td>
                                    <td class="p-4 text-red-500"><fmt:formatNumber value="${thanhTien}" type="number" groupingUsed="true"/>₫</td>
                                    <td class="p-4">
                                        <a href="xoagiohang?maSanPham=${sp.maSanPham}" class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600 btn-hover">🗑️</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="bg-gray-50">
                                <th colspan="4" class="text-right p-4">Tổng cộng:</th>
                                <th class="p-4 text-red-500"><fmt:formatNumber value="${tongTien}" type="number" groupingUsed="true"/>₫</th>
                                <th class="p-4"></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="flex justify-end items-center mt-6 gap-3 flex-wrap">
            <a href="trangchu" class="bg-gray-300 text-gray-800 px-6 py-2 rounded-lg hover:bg-gray-400 btn-hover">
                ⬅ Trang Chủ
            </a>
            <form action="dathang" method="post" class="m-0">
                <button type="submit" class="bg-green-500 text-white px-6 py-2 rounded-lg hover:bg-green-600 btn-hover">
                    🛍️ Mua Hàng
                </button>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-4 mt-auto">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 Laptop Store. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>