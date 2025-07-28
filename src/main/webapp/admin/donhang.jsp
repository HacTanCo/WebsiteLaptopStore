<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Quản lý Đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
	<!-- Header -->
	<div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">
		<a href="${pageContext.request.contextPath}/trangchu" class="btn btn-secondary">Trang Chủ</a>
		<a href="${pageContext.request.contextPath}/dangxuat" class="btn btn-danger">Đăng xuất</a>
	</div>
	
	
	<c:if test="${not empty sessionScope.message}">
		<div id="flashMessage" class="alert alert-success text-center">
			${sessionScope.message}
		</div>
	    <c:remove var="message" scope="session" />
	</c:if>
	
	
    <h2 class="mb-4 text-center">Danh sách Đơn hàng</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>Mã Đơn</th>
                <th>Mã Người Dùng</th>
                <th>Ngày Đặt</th>
                <th>Tổng Tiền</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="dh" items="${danhSachDonHang}">
                <tr>
                    <td>${dh.maDonHang}</td>
                    <td>${dh.maNguoiDung}</td>
                    <td>${dh.ngayDat}</td>
                    <td><fmt:formatNumber value="${dh.tongTien}" type="currency" currencySymbol="đ" /></td>
                    <td>
                    	<form action="${pageContext.request.contextPath}/admin/capnhattrangthaidonhang" method="post">
						    <input type="hidden" name="maDonHang" value="${dh.maDonHang}" />
						    <select name="trangThai" class="form-select">
						        <option ${dh.trangThai == 'Chờ xử lý' ? 'selected' : ''}>Chờ xử lý</option>
						        <option ${dh.trangThai == 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
						        <option ${dh.trangThai == 'Đang giao' ? 'selected' : ''}>Đang giao</option>
						        <option ${dh.trangThai == 'Đã giao' ? 'selected' : ''}>Đã giao</option>
						        <option ${dh.trangThai == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
						    </select>
						    <button type="submit" class="btn btn-sm btn-primary mt-1">Cập nhật</button>
						</form>
                    </td>
                    <td>
                        <a href="chitietdonhang?maDonHang=${dh.maDonHang}" class="btn btn-info btn-sm">Chi tiết</a>
                        <%-- <a href="donhang-delete?maDonHang=${dh.maDonHang}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có chắc muốn xóa đơn hàng này?')">Xóa</a> --%>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
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
