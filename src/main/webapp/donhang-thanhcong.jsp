<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
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
    <main class="container mx-auto px-4 py-8 flex-grow flex items-center justify-center">
        <div class="bg-white rounded-lg shadow-md p-8 max-w-lg w-full text-center card-hover">
            <svg class="w-16 h-16 mx-auto text-green-500 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
            </svg>
            <h2 class="text-3xl font-bold text-green-600 mb-4">Cảm ơn bạn đã đặt hàng!</h2>

            <c:if test="${not empty sessionScope.thongBao}">
                <div class="bg-green-100 text-green-800 p-4 rounded-lg mb-6">
                    ${sessionScope.thongBao}
                </div>
            </c:if>

            <p class="text-gray-600 mb-6">Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>
            <a href="trangchu" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 btn-hover">
                Quay về trang chủ
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