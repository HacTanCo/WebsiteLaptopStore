<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="model.DonHang" %>

<%
    List<DonHang> danhSach = (List<DonHang>) request.getAttribute("danhSachDonHang");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .table-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        .btn-hover:hover {
            transform: scale(1.05);
            transition: transform 0.2s ease;
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
                    <!-- Giỏ hàng -->
                    <a href="xemgiohang.jsp" class="flex items-center bg-yellow-400 text-white px-4 py-2 rounded-lg btn-hover">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                        <span>Giỏ hàng (<c:out value="${soSanPhamTrongGio}" />)</span>
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
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Lịch sử đơn hàng</h2>

        <c:if test="${empty danhSachDonHang}">
            <div class="bg-blue-100 text-blue-800 p-4 rounded-lg text-center">Bạn chưa đặt đơn hàng nào.</div>
        </c:if>

        <c:if test="${not empty danhSachDonHang}">
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <table class="w-full text-center">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="p-4">Mã đơn hàng</th>
                            <th class="p-4">Ngày đặt</th>
                            <th class="p-4">Tổng tiền</th>
                            <th class="p-4">Trạng thái</th>
                            <th class="p-4">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dh" items="${danhSachDonHang}">
                            <tr class="border-t table-hover">
                                <td class="p-4">${dh.maDonHang}</td>
                                <td class="p-4">${dh.ngayDat}</td>
                                <td class="p-4 text-red-500"><fmt:formatNumber value="${dh.tongTien}" type="number" groupingUsed="true"/>₫</td>
                                <td class="p-4">${dh.trangThai}</td>
                                <td class="p-4">
                                    <c:if test="${fn:toLowerCase(dh.trangThai) == 'chờ xử lý'}">
                                        <form action="huydonhang" method="post" onsubmit="return confirm('Bạn có chắc muốn hủy đơn hàng này?');" class="m-0">
                                            <input type="hidden" name="maDonHang" value="${dh.maDonHang}">
                                            <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600 btn-hover">
                                                <svg class="w-4 h-4 inline-block mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                                </svg>
                                                Hủy
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${fn:toLowerCase(dh.trangThai) != 'chờ xử lý'}">
                                        <span class="text-gray-500">--</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div class="flex justify-end mt-6">
            <a href="trangchu" class="bg-gray-300 text-gray-800 px-6 py-2 rounded-lg hover:bg-gray-400 btn-hover">
                ⬅ Trang Chủ
            </a>
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