<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5" style="max-width: 500px;">
    <h2 class="mb-4">Đăng nhập</h2>
    
    <c:if test="${not empty err}">
        <div class="alert alert-danger">${err}</div>
    </c:if>
    
    <c:if test="${not empty thongBao}">
	    <div class="alert alert-danger">${thongBao}</div>
	</c:if>
    
    <form method="post" action="dangnhap">
        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="text" class="form-control" name="email" value="${param.email }" required>
        </div>
        <div class="mb-3">
            <label for="matKhau" class="form-label">Mật khẩu:</label>
            <input type="password" class="form-control" name="matKhau" value="${param.matKhau }" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
        <a href="dangky" class="d-block text-center mt-2">Chưa có tài khoản? Đăng ký</a>
    </form>
</body>
</html>

