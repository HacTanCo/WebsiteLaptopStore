<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5" style="max-width: 500px;">
    <h3 class="text-center mb-4">Đăng ký tài khoản</h3>
    
    <c:if test="${not empty err}">
        <div class="alert alert-danger">${err}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

    <form action="dangky" method="post">
        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" value="${param.email}" required>
        </div>
        <div class="mb-3">
            <label>Họ tên</label>
            <input type="text" name="hoTen" class="form-control" value="${param.hoTen }" required>
        </div>
        <div class="mb-3">
            <label>Mật khẩu</label>
            <input type="password" name="matKhau" class="form-control" value="${param.matKhau}" required>
        </div>
        <div class="mb-3">
            <label>Nhập lại mật khẩu</label>
            <input type="password" name="nhapLaiMatKhau" class="form-control" value="${param.email}"value="${param.nhapLaiMatKhau}" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
        <a href="dangnhap" class="d-block text-center mt-2">Đã có tài khoản? Đăng nhập</a>
    </form>
</div>
</body>
</html>
