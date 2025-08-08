<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .btn-hover:hover {
            transform: scale(1.05);
            transition: transform 0.2s ease;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
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
                    <!-- Quản lý sản phẩm -->
                    <a href="${pageContext.request.contextPath}/admin/sanpham" class="flex items-center bg-gray-300 text-gray-800 px-4 py-2 rounded-lg btn-hover">
                        <span>Quản lý sản phẩm</span>
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
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Sửa sản phẩm</h2>

        <!-- Notifications -->
        <c:if test="${not empty err}">
            <div class="bg-red-100 text-red-800 p-4 rounded-lg text-center mb-6">
                ${err}
            </div>
        </c:if>
        <c:if test="${not empty thongBao}">
            <div class="bg-green-100 text-green-800 p-4 rounded-lg text-center mb-6">
                ${thongBao}
            </div>
        </c:if>

        <!-- Edit Product Form -->
        <div class="bg-white rounded-lg shadow-md p-6 max-w-2xl mx-auto card-hover">
            <form action="suasanpham" method="post">
                <input type="hidden" name="maSanPham" value="${sp.maSanPham}">

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Tên sản phẩm:</label>
                    <input type="text" name="tenSanPham" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${sp.tenSanPham}" required>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Giá:</label>
                    <input type="number" step="0.01" name="gia" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${giaFormatted}" required>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Hãng:</label>
                    <input type="text" name="hang" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${sp.hang}" required>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">CPU:</label>
                    <input type="text" name="cpu" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${sp.cpu}" required>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">RAM:</label>
                    <input type="text" name="ram" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${sp.ram}" required>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Ổ cứng:</label>
                    <input type="text" name="oCung" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${sp.oCung}" required>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Màn hình:</label>
                    <input type="text" name="manHinh" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${sp.manHinh}" required>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Mô tả:</label>
                    <textarea name="moTa" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" rows="4">${sp.moTa}</textarea>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Hình ảnh hiện tại:</label>
                    <div class="relative w-32 h-32 mx-auto mb-2">
                        <img src="${pageContext.request.contextPath}/images/${sp.hinhAnh}" class="absolute top-0 left-0 w-full h-full object-contain" alt="${sp.tenSanPham}">
                    </div>
                    <input type="text" name="hinhAnh" class="w-full border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" value="${sp.hinhAnh}">
                </div>

                <div class="flex justify-center gap-3">
                    <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 btn-hover">Cập nhật sản phẩm</button>
                    <a href="sanpham" class="bg-gray-300 text-gray-800 px-4 py-2 rounded-lg hover:bg-gray-400 btn-hover">Hủy</a>
                </div>
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