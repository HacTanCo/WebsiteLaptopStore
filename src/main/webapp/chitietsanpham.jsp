<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${sp.tenSanPham}</title>
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
        <div class="bg-white rounded-lg shadow-md p-6 card-hover">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Product Image -->
                <div class="relative w-full" style="padding-top: 75%;">
                    <img src="images/${sp.hinhAnh}" class="absolute top-0 left-0 w-full h-full object-contain" alt="Laptop">
                </div>
                <!-- Product Details -->
                <div>
                    <h2 class="text-2xl font-bold text-gray-800 mb-4">${sp.tenSanPham}</h2>
                    <p class="text-red-500 text-lg font-medium mb-3">
                        <strong>Giá:</strong> <fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true"/>₫
                    </p>
                    <p class="text-gray-600 mb-2"><strong>Hãng:</strong> ${sp.hang}</p>
                    <p class="text-gray-600 mb-2"><strong>CPU:</strong> ${sp.cpu}</p>
                    <p class="text-gray-600 mb-2"><strong>RAM:</strong> ${sp.ram}</p>
                    <p class="text-gray-600 mb-2"><strong>Ổ cứng:</strong> ${sp.oCung}</p>
                    <p class="text-gray-600 mb-2"><strong>Màn hình:</strong> ${sp.manHinh}</p>
                    <p class="text-gray-600 mb-4"><strong>Mô tả:</strong><br>${sp.moTa}</p>
                    <div class="flex gap-3">
                        <a href="themvaogio?id=${sp.maSanPham}" class="bg-green-500 text-white px-4 py-2 rounded-lg hover:bg-green-600 btn-hover">
                            Thêm vào giỏ hàng
                        </a>
                        <a href="trangchu" class="bg-gray-300 text-gray-800 px-4 py-2 rounded-lg hover:bg-gray-400 btn-hover">
                            ⬅ Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
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