<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng</title>
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
        <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Danh sách Đơn hàng</h2>

        <c:if test="${not empty sessionScope.message}">
            <div id="flashMessage" class="bg-green-100 text-green-800 p-4 rounded-lg text-center mb-6">
                ${sessionScope.message}
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="w-full text-center">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="p-4">Mã Đơn</th>
                        <th class="p-4">Mã Người Dùng</th>
                        <th class="p-4">Ngày Đặt</th>
                        <th class="p-4">Tổng Tiền</th>
                        <th class="p-4">Trạng Thái</th>
                        <th class="p-4">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dh" items="${danhSachDonHang}">
                        <tr class="border-t table-hover">
                            <td class="p-4">${dh.maDonHang}</td>
                            <td class="p-4">${dh.maNguoiDung}</td>
                            <td class="p-4">${dh.ngayDat}</td>
                            <td class="p-4 text-red-500"><fmt:formatNumber value="${dh.tongTien}" type="number" groupingUsed="true"/>₫</td>
                            <td class="p-4">
                                <form action="${pageContext.request.contextPath}/admin/capnhattrangthaidonhang" method="post" class="flex flex-col items-center gap-2">
                                    <input type="hidden" name="maDonHang" value="${dh.maDonHang}" />
                                    <select name="trangThai" class="border rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500">
                                        <option ${dh.trangThai == 'Chờ xử lý' ? 'selected' : ''}>Chờ xử lý</option>
                                        <option ${dh.trangThai == 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option ${dh.trangThai == 'Đang giao' ? 'selected' : ''}>Đang giao</option>
                                        <option ${dh.trangThai == 'Đã giao' ? 'selected' : ''}>Đã giao</option>
                                        <option ${dh.trangThai == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                                    </select>
                                    <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded-lg hover:bg-blue-700 btn-hover">Cập nhật</button>
                                </form>
                            </td>
                            <td class="p-4">
                                <a href="chitietdonhang?maDonHang=${dh.maDonHang}" class="bg-blue-500 text-white px-3 py-1 rounded-lg hover:bg-blue-600 btn-hover">Chi tiết</a>
                                <%-- <a href="donhang-delete?maDonHang=${dh.maDonHang}" class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600 btn-hover" onclick="return confirm('Bạn có chắc muốn xóa đơn hàng này?')">Xóa</a> --%>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
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