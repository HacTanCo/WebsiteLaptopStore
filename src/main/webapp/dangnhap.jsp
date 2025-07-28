<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
        	background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-box {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0px 4px 20px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
        }
        .login-box .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        }
        .login-icon {
            font-size: 50px;
            color: #0d6efd;
            display: block;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <i class="bi bi-person-circle login-icon"></i>
        <h3 class="text-center mb-4">Đăng nhập</h3>

        <c:if test="${not empty err}">
            <div class="alert alert-danger">${err}</div>
        </c:if>
        <c:if test="${not empty thongBao}">
            <div class="alert alert-warning">${thongBao}</div>
        </c:if>

        <form method="post" action="dangnhap">
            <div class="mb-3">
                <label class="form-label"><i class="bi bi-envelope"></i> Email</label>
                <input type="text" class="form-control" name="email" value="${param.email}" required>
            </div>
            <div class="mb-3">
                <label class="form-label"><i class="bi bi-lock"></i> Mật khẩu</label>
                <input type="password" class="form-control" name="matKhau" value="${param.matKhau}" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">
                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
            </button>
        </form>

        <div class="text-center mt-3">
            <a href="dangky" class="text-decoration-none">
                <i class="bi bi-person-plus"></i> Chưa có tài khoản? Đăng ký
            </a>
        </div>
    </div>
</body>
</html>
