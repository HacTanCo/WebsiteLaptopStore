<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ChiTietDonHang" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #${maDonHang}</title>
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
                <h1 class="text-2xl font-bold text-blue-600">Laptop Store - Admin</h1>
                <div class="flex items-center gap-3">
                    <!-- Quản lý đơn hàng -->
                    <a href="${pageContext.request.contextPath}/admin/donhang" class="flex items-center bg-gray-300 text-gray-800 px-4 py-2 rounded-lg btn-hover">
                        <span>Quản lý đơn hàng</span>
                    </a>
                    <!-- Đăng xuất -->
                    <a href="${pageContext.request.contextPath}/dangxuat" class="flex items-center bg-red-500 text-white px-4 py-2 rounded-lg btn-hover">
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8 flex-grow">
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Chi tiết đơn hàng #${maDonHang}</h2>

        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="w-full text-center">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="p-4">Mã SP</th>
                        <th class="p-4">Tên sản phẩm</th>
                        <th class="p-4">Đơn giá</th>
                        <th class="p-4">Số lượng</th>
                        <th class="p-4">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ct" items="${chiTietList}">
                        <tr class="border-t table-hover">
                            <td class="p-4">${ct.maSanPham}</td>
                            <td class="p-4">${ct.tenSanPham}</td>
                            <td class="p-4 text-red-500"><fmt:formatNumber value="${ct.donGia}" type="number" groupingUsed="true"/>₫</td>
                            <td class="p-4">${ct.soLuong}</td>
                            <td class="p-4 text-red-500"><fmt:formatNumber value="${ct.thanhTien}" type="number" groupingUsed="true"/>₫</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="flex justify-end mt-6">
            <a href="${pageContext.request.contextPath}/admin/donhang" class="bg-gray-300 text-gray-800 px-6 py-2 rounded-lg hover:bg-gray-400 btn-hover">
                ⬅ Quay lại
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