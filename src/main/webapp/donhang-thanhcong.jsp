<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="card shadow-sm border-0 mx-auto" style="max-width: 600px;">
            <div class="card-body text-center">
                <h2 class="card-title text-success mb-3">Cảm ơn bạn đã đặt hàng!</h2>

                <c:if test="${not empty sessionScope.thongBao}">
                    <div class="alert alert-success" role="alert">
                        ${sessionScope.thongBao}
                    </div>
                </c:if>

                <p class="mt-4">Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>
                <a href="trangchu" class="btn btn-primary mt-3">Quay về trang chủ</a>
            </div>
        </div>
    </div>
</body>
</html>

