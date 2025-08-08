<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người Dùng</title>
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
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Quản lý Người Dùng</h2>

        <!-- Flash Message -->
        <c:if test="${not empty sessionScope.message}">
            <div id="flashMessage" class="bg-green-100 text-green-800 p-4 rounded-lg text-center mb-6">
                ${sessionScope.message}
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <!-- Search/Filter Form -->
        <form method="get" action="nguoidung" class="bg-white rounded-lg shadow-md p-6 mb-8">
            <div class="flex flex-col sm:flex-row justify-center items-center gap-4">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm theo email" class="border rounded-lg p-2 w-full sm:w-1/2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                <select name="role" class="border rounded-lg p-2 w-full sm:w-1/4 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">Tất cả</option>
                    <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                    <option value="user" ${param.role == 'user' ? 'selected' : ''}>User</option>
                </select>
                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 btn-hover">Tìm kiếm</button>
            </div>
        </form>

        <!-- User Management Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="w-full text-center">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="p-4">ID</th>
                        <th class="p-4">Email</th>
                        <th class="p-4">Họ tên</th>
                        <th class="p-4">Quyền</th>
                        <th class="p-4">Hành động</th>
                        <th class="p-4">Khóa/Mở khóa</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="nd" items="${list}">
                        <tr class="border-t table-hover">
                            <td class="p-4">${nd.maNguoiDung}</td>
                            <td class="p-4">${nd.email}</td>
                            <td class="p-4">${nd.hoTen}</td>
                            <td class="p-4">
                                <c:choose>
                                    <c:when test="${nd.admin}">Admin</c:when>
                                    <c:otherwise>User</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-4">
                                <c:if test="${nd.maNguoiDung != sessionScope.nd.maNguoiDung}">
                                    <form action="${pageContext.request.contextPath}/admin/capquyen" method="post" class="flex justify-center"
                                        onsubmit="return confirm('Bạn có chắc chắn muốn ${nd.admin ? 'hủy quyền Admin' : 'cấp quyền Admin'} cho người dùng này?');">
                                        <input type="hidden" name="id" value="${nd.maNguoiDung}">
                                        <input type="hidden" name="isAdmin" value="${!nd.admin}">
                                        <button type="submit" class="bg-${nd.admin ? 'red' : 'green'}-500 text-white px-3 py-1 rounded-lg hover:bg-${nd.admin ? 'red' : 'green'}-600 btn-hover">
                                            ${nd.admin ? 'Hủy quyền Admin' : 'Cấp quyền Admin'}
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${nd.maNguoiDung == sessionScope.nd.maNguoiDung}">
                                    <span class="bg-gray-200 text-gray-800 px-2 py-1 rounded-lg">Tài khoản của bạn</span>
                                </c:if>
                            </td>
                            <td class="p-4">
                                <c:if test="${nd.maNguoiDung != sessionScope.nd.maNguoiDung}">
                                    <form action="${pageContext.request.contextPath}/admin/trangthaitaikhoan" method="post" class="flex justify-center"
                                        onsubmit="return confirm('${nd.trangThai ? 'Bạn có chắc muốn KHÓA tài khoản này?' : 'Bạn có muốn MỞ KHÓA tài khoản này?'}');">
                                        <input type="hidden" name="id" value="${nd.maNguoiDung}" />
                                        <input type="hidden" name="trangThaiMoi" value="${!nd.trangThai}" />
                                        <button type="submit" class="bg-${nd.trangThai ? 'red' : 'green'}-500 text-white px-3 py-1 rounded-lg hover:bg-${nd.trangThai ? 'red' : 'green'}-600 btn-hover">
                                            ${nd.trangThai ? 'Khóa' : 'Mở khóa'}
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${nd.maNguoiDung == sessionScope.nd.maNguoiDung}">
                                    <span class="bg-gray-200 text-gray-800 px-2 py-1 rounded-lg"></span>
                                </c:if>
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
                    <a class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 btn-hover" href="?page=${trangHienTai - 1}&keyword=${param.keyword}&role=${param.role}">Trước</a>
                </li>
                <c:forEach begin="1" end="${tongTrang}" var="i">
                    <li>
                        <a class="px-4 py-2 ${i == trangHienTai ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-800'} rounded-lg hover:bg-blue-500 hover:text-white btn-hover" href="?page=${i}&keyword=${param.keyword}&role=${param.role}">${i}</a>
                    </li>
                </c:forEach>
                <li class="${trangHienTai == tongTrang ? 'opacity-50 cursor-not-allowed' : ''}">
                    <a class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 btn-hover" href="?page=${trangHienTai + 1}&keyword=${param.keyword}&role=${param.role}">Sau</a>
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
                    flash.remove(); // Xóa hẳn khỏi DOM sau khi ẩn
                }, 500);
            }
        }, 5000); // 5 giây
    </script>
</body>
</html>