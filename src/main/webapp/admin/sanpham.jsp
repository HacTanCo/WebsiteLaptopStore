<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
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
                    <!-- Trang Chủ -->
                    <a href="${pageContext.request.contextPath}/trangchu" class="flex items-center bg-gray-300 text-gray-800 px-4 py-2 rounded-lg btn-hover">
                        <span>Trang Chủ</span>
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
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Quản lý Sản phẩm</h2>

        <!-- Flash Message -->
        <c:if test="${not empty sessionScope.message}">
            <div id="flashMessage" class="bg-green-100 text-green-800 p-4 rounded-lg text-center mb-6">
                ${sessionScope.message}
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <!-- Search/Filter Form -->
        <form method="get" action="sanpham" class="bg-white rounded-lg shadow-md p-6 mb-8">
            <div class="grid grid-cols-1 sm:grid-cols-4 gap-4">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm theo tên..." class="border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
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
                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 btn-hover">Tìm kiếm</button>
            </div>
        </form>

        <!-- Add Product Button -->
        <div class="flex justify-end mb-6">
            <a href="themsanpham" class="bg-green-500 text-white px-4 py-2 rounded-lg hover:bg-green-600 btn-hover">+ Thêm sản phẩm</a>
        </div>

        <!-- Product Management Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="w-full text-center">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="p-4">ID</th>
                        <th class="p-4">Tên</th>
                        <th class="p-4">Giá</th>
                        <th class="p-4">CPU</th>
                        <th class="p-4">RAM</th>
                        <th class="p-4">Hãng</th>
                        <th class="p-4">Hình ảnh</th>
                        <th class="p-4">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="sp" items="${list}">
                        <tr class="border-t table-hover">
                            <td class="p-4">${sp.maSanPham}</td>
                            <td class="p-4">${sp.tenSanPham}</td>
                            <td class="p-4 text-red-500"><fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true"/>₫</td>
                            <td class="p-4">${sp.cpu}</td>
                            <td class="p-4">${sp.ram}</td>
                            <td class="p-4">${sp.hang}</td>
                            <td class="p-4">
                                <div class="relative w-16 h-16 mx-auto">
                                    <img src="${pageContext.request.contextPath}/images/${sp.hinhAnh}" class="absolute top-0 left-0 w-full h-full object-contain" alt="${sp.tenSanPham}">
                                </div>
                            </td>
                            <td class="p-4">
                                <div class="flex justify-center gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/suasanpham?maSanPham=${sp.maSanPham}" class="bg-yellow-500 text-white px-3 py-1 rounded-lg hover:bg-yellow-600 btn-hover">Sửa</a>
                                    <form action="${pageContext.request.contextPath}/admin/xoasanpham" method="get" class="m-0" onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                        <input type="hidden" name="maSanPham" value="${sp.maSanPham}" />
                                        <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600 btn-hover">Xóa</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <nav class="mt-8">
            <ul class="flex justify-center gap-2">
                <li class="${trangHienTai == 1 ? 'opacity-50 cursor-not-allowed' : ''}">
                    <a class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 btn-hover" href="?page=${trangHienTai - 1}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}">Trước</a>
                </li>
                <c:forEach begin="1" end="${tongTrang}" var="i">
                    <li>
                        <a class="px-4 py-2 ${i == trangHienTai ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-800'} rounded-lg hover:bg-blue-500 hover:text-white btn-hover" href="?page=${i}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}">${i}</a>
                    </li>
                </c:forEach>
                <li class="${trangHienTai == tongTrang ? 'opacity-50 cursor-not-allowed' : ''}">
                    <a class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 btn-hover" href="?page=${trangHienTai + 1}&keyword=${param.keyword}&cpu=${param.cpu}&ram=${param.ram}">Sau</a>
                </li>
            </ul>
        </nav>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-4 mt-auto">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2025 Laptop Store. All rights reserved.</p>
        </div>
    </footer>

    <script>
        setTimeout(function () {
            var flash = document.getElementById("flashMessage");
            if (flash) {
                flash.style.transition = "opacity 0.5s ease-out";
                flash.style.opacity = 0;
                setTimeout(function () {
                    flash.remove();
                }, 500);
            }
        }, 5000);
    </script>
</body>
</html>