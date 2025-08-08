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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
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
        <!-- Admin Panel -->
        <c:if test="${nd.admin}">
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <h5 class="text-xl font-semibold text-blue-600 mb-4">Chức năng quản trị</h5>
                <div class="flex gap-3">
                    <a href="admin/sanpham" class="bg-blue-100 text-blue-600 px-4 py-2 rounded-lg hover:bg-blue-200 btn-hover">Quản lý sản phẩm</a>
                    <a href="admin/donhang" class="bg-blue-100 text-blue-600 px-4 py-2 rounded-lg hover:bg-blue-200 btn-hover">Quản lý đơn hàng</a>
                    <a href="admin/nguoidung" class="bg-blue-100 text-blue-600 px-4 py-2 rounded-lg hover:bg-blue-200 btn-hover">Quản lý người dùng</a>
                </div>
            </div>
        </c:if>

        <!-- Form filter product and find product -->
        <form action="trangchu" method="get" class="bg-white rounded-lg shadow-md p-6 mb-8">
            <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                <input type="text" name="keyword" value="${param.keyword}" class="border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Tìm theo tên...">
                <select name="cpu" class="border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">-- CPU --</option>
                    <option value="Intel" ${param.cpu=='Intel' ? 'selected' : ''}>Intel</option>
                    <option value="AMD" ${param.cpu=='AMD' ? 'selected' : ''}>AMD</option>
                    <option value="Apple" ${param.cpu=='Apple' ? 'selected' : ''}>Apple</option>
                </select>
                <select name="ram" class="border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">-- RAM --</option>
                    <option value="8GB" ${param.ram=='8GB' ? 'selected' : ''}>8GB</option>
                    <option value="16GB" ${param.ram=='16GB' ? 'selected' : ''}>16GB</option>
                </select>
                <input type="number" name="minPrice" value="${param.minPrice}" class="border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Giá từ">
                <input type="number" name="maxPrice" value="${param.maxPrice}" class="border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Giá đến">
            </div>
            <div class="flex justify-center gap-3 mt-4">
                <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 btn-hover">Lọc</button>
                <button type="button" onclick="resetForm()" class="bg-gray-300 text-gray-800 px-6 py-2 rounded-lg hover:bg-gray-400 btn-hover">Reset</button>
            </div>
        </form>

        <script>
            function resetForm() {
                const form = document.querySelector('form');
                form.querySelectorAll('input[type="text"], input[type="number"]').forEach(input => input.value = '');
                form.querySelectorAll('select').forEach(select => select.selectedIndex = 0);
                form.submit();
            }
        </script>

        <!-- Danh sách sản phẩm -->
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <c:forEach var="sp" items="${danhSachSanPham}">
                <div class="bg-white rounded-lg shadow-md overflow-hidden card-hover">
                    <div class="relative w-full" style="padding-top: 66.67%;"> <!-- Aspect ratio 3:2 -->
                        <img src="images/${sp.hinhAnh}" class="absolute top-0 left-0 w-full h-full object-contain" alt="Laptop">
                    </div>
                    <div class="p-6">
                        <h5 class="text-lg font-semibold text-gray-800">${sp.tenSanPham}</h5>
                        <p class="text-red-500 font-medium mt-2">
                            <fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" />₫
                        </p>
                        <div class="flex gap-2 mt-4">
                            <a href="chitietsanpham?id=${sp.maSanPham}" class="bg-blue-600 text-white px-3 py-1 rounded-lg hover:bg-blue-700 btn-hover">Xem chi tiết</a>
                            <a href="themvaogio?id=${sp.maSanPham}" class="bg-green-500 text-white px-3 py-1 rounded-lg hover:bg-green-600 btn-hover">Thêm vào giỏ</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Phân trang -->
        <nav class="mt-8">
            <ul class="flex justify-center gap-2">
                <c:if test="${trangHienTai > 1}">
                    <li>
                        <a class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 btn-hover" href="trangchu?page=${trangHienTai - 1}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">&laquo; Trước</a>
                    </li>
                </c:if>
                <c:forEach var="i" begin="1" end="${tongTrang}">
                    <li>
                        <a class="px-4 py-2 ${i == trangHienTai ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-800'} rounded-lg hover:bg-blue-500 hover:text-white btn-hover" href="trangchu?page=${i}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${trangHienTai < tongTrang}">
                    <li>
                        <a class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 btn-hover" href="trangchu?page=${trangHienTai + 1}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">Sau &raquo;</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-4 mt-auto">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 Laptop Store. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>