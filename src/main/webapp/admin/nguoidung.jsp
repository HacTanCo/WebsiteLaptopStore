<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Người Dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
	<!-- Header -->
	<div class="d-flex justify-content-end align-items-center gap-3 mt-4 mb-4">

		<a href="${pageContext.request.contextPath}/trangchu" class="btn btn-secondary">Trang Chủ</a>

		<!-- Nút Đăng xuất -->
		<a href="${pageContext.request.contextPath}/dangxuat" class="btn btn-danger d-flex align-items-center">
			<span class="ms-1">Đăng xuất</span>
		</a>
	</div>
	<c:if test="${not empty sessionScope.message}">
		<div id="flashMessage" class="alert alert-success text-center">
			${sessionScope.message}
		</div>
	    <c:remove var="message" scope="session" />
	</c:if>
	
	
	
	<!-- find email or role  -->
	<div class="d-flex justify-content-center align-items-center">
		<form method="get" action="nguoidung" class="mb-3">
		    <input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm theo email" class="form-control d-inline w-50">
		    <select name="role" class="form-select d-inline w-25">
		        <option value="">Tất cả</option>
		        <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
		        <option value="user" ${param.role == 'user' ? 'selected' : ''}>User</option>
		    </select>
		    <button class="btn btn-primary">Tìm kiếm</button>
		</form>
	</div>
	
	<!-- Table user management  -->
    <h2 class="mb-4 text-center">Quản lý Người Dùng</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Họ tên</th>
                <th>Quyền</th>
                <th>Hành động</th>
                <!-- <th>Trạng thái</th> -->
                <th>Khóa/Mở khóa</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="nd" items="${list}">
                <tr>
                    <td>${nd.maNguoiDung}</td>
                    <td>${nd.email}</td>
                    <td>${nd.hoTen}</td>
                    <td>
                        <c:choose>
                            <c:when test="${nd.admin}">Admin</c:when>
                            <c:otherwise>User</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                    	<%-- <c:if test="${nd.maNguoiDung != sessionScope.nd.maNguoiDung}">
						    <form action="${pageContext.request.contextPath}/admin/capquyen" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn thay đổi quyền người dùng này?')">
						        <input type="hidden" name="maNguoiDung" value="${nd.maNguoiDung}">
						        <button type="submit" class="btn btn-sm ${nd.admin ? 'btn-danger' : 'btn-success'}">
						            ${nd.admin ? 'Hủy quyền Admin' : 'Cấp quyền Admin'}
						        </button>
						    </form>
						</c:if> 
						<c:if test="${nd.maNguoiDung == sessionScope.nd.maNguoiDung}">
						    <span class="badge bg-secondary">Tài khoản của bạn</span>
						</c:if> --%>
						<c:if test="${nd.maNguoiDung != sessionScope.nd.maNguoiDung}">
	                    	<form action="${pageContext.request.contextPath}/admin/capquyen" method="post"
								class="d-inline"
								onsubmit="return confirm('Bạn có chắc chắn muốn ${nd.admin ? 'hủy quyền Admin' : 'cấp quyền Admin'} cho người dùng này?');">
								<input type="hidden" name="id" value="${nd.maNguoiDung}">
								<input type="hidden" name="isAdmin" value="${!nd.admin}">
								<button type="submit" class="btn btn-sm ${nd.admin ? 'btn-danger' : 'btn-success'}">
									${nd.admin ? 'Hủy quyền Admin' : 'Cấp quyền Admin'}
								</button>
							</form>
						</c:if>
						<c:if test="${nd.maNguoiDung == sessionScope.nd.maNguoiDung}">
						    <span class="badge bg-secondary">Tài khoản của bạn</span>
						</c:if>
                    </td>
					<td>
						<c:if test="${nd.maNguoiDung != sessionScope.nd.maNguoiDung}">
							<form action="${pageContext.request.contextPath}/admin/trangthaitaikhoan" method="post"
								class="d-inline"
								onsubmit="return confirm('${nd.trangThai ? 'Bạn có chắc muốn KHÓA tài khoản này?' : 'Bạn có muốn MỞ KHÓA tài khoản này?'}');">
								<input type="hidden" name="id" value="${nd.maNguoiDung}" />
								<input type="hidden" name="trangThaiMoi" value="${!nd.trangThai}" />
								<button type="submit" class="btn btn-sm ${nd.trangThai ? 'btn-danger' : 'btn-success'}">
									${nd.trangThai ? 'Khóa' : 'Mở khóa'}
								</button>
							</form>
						</c:if>
						<c:if test="${nd.maNguoiDung == sessionScope.nd.maNguoiDung}">
						    <span class="badge bg-secondary"></span>
						</c:if>
					</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- pagination  -->
    <nav>
	  <ul class="pagination justify-content-center">
	
	    <!-- Nút Trước -->
	    <li class="page-item ${trangHienTai == 1 ? 'disabled' : ''}">
	      <a class="page-link" href="?page=${trangHienTai - 1}&keyword=${param.keyword}&role=${param.role}">Trước</a>
	    </li>
	    <!-- Các số trang -->
	    <c:forEach begin="1" end="${tongTrang}" var="i">
	      <li class="page-item ${i == trangHienTai ? 'active' : ''}">
	        <a class="page-link" href="?page=${i}&keyword=${param.keyword}&role=${param.role}">${i}</a>
	      </li>
	    </c:forEach>
	
	    <!-- Nút Sau -->
	    <li class="page-item ${trangHienTai == tongTrang ? 'disabled' : ''}">
	      <a class="page-link" href="?page=${trangHienTai + 1}&keyword=${param.keyword}&role=${param.role}">Sau</a>
	    </li>
	
	  </ul>
	</nav>
	
    
	
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
