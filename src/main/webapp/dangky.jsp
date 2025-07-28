<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-box {
            max-width: 500px;
            margin: 5% auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .form-label i {
            color: #0d6efd;
            margin-right: 5px;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>

<div class="register-box">
    <h3 class="text-center mb-4"><i class="fas fa-user-plus me-2"></i>Đăng ký tài khoản</h3>

    <c:if test="${not empty err}">
        <div class="alert alert-danger">${err}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

    <form action="dangky" method="post">
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-envelope"></i>Email</label>
            <input type="email" name="email" class="form-control" value="${param.email}" required>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-user"></i>Họ tên</label>
            <input type="text" name="hoTen" class="form-control" value="${param.hoTen}" required>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-lock"></i>Mật khẩu</label>
            <input type="password" name="matKhau" class="form-control" value="${param.matKhau}" required>
        </div>
        <div class="mb-3">
            <label class="form-label"><i class="fas fa-lock"></i>Nhập lại mật khẩu</label>
            <input type="password" name="nhapLaiMatKhau" class="form-control" value="${param.nhapLaiMatKhau}" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <i class="fas fa-user-check me-1"></i>Đăng ký
        </button>
        <div class="text-center mt-3">
            <a href="dangnhap" class="text-decoration-none">
                <i class="fas fa-arrow-left me-1"></i>Đã có tài khoản? Đăng nhập
            </a>
        </div>
    </form>
</div>

</body>
</html>
