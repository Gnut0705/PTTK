<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.Manager0"%>
<%
    Manager0 manager = (Manager0) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../member/gdLogin0.jsp?err=session");
        return;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trang chu quan ly</title>
<style type="text/css">
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .card-container {
        background-color: #ffffff;
        padding: 40px 50px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        text-align: center;
        min-width: 380px;
    }
    h2 {
        color: #1a365d;
        margin-top: 0;
        margin-bottom: 15px;
        font-size: 24px;
    }
    .user-greeting {
        font-size: 15px;
        color: #475569;
        margin-bottom: 30px;
        background-color: #f8fafc;
        padding: 10px 16px;
        border-radius: 6px;
        border: 1px solid #e2e8f0;
    }
    .user-greeting b {
        color: #1e40af;
    }
    .button-group {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    .menu-link {
        display: block;
        background-color: #2563eb;
        color: #ffffff;
        text-decoration: none;
        padding: 12px 28px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 15px;
        transition: background-color 0.2s;
    }
    .menu-link:hover {
        background-color: #1d4ed8;
    }
    .btn-logout {
        display: block;
        background-color: #f1f5f9;
        color: #ef4444;
        text-decoration: none;
        padding: 11px 28px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.2s;
        border: 1px solid #e2e8f0;
    }
    .btn-logout:hover {
        background-color: #fee2e2;
        border-color: #fca5a5;
    }
</style>
</head>
<body>
    <div class="card-container">
        <h2>Trang chủ quản lý</h2>

        <div class="user-greeting">
            Xin chào, <b><%= manager.getFullName() %></b>
            <% if (manager.getManagerCode() != null && !manager.getManagerCode().isEmpty()) { %>
                (Mã: <%= manager.getManagerCode() %>)
            <% } %>
        </div>

        <div class="button-group">
            <!-- Bước 1, 2: Click Xem báo cáo -> gọi gdSelectReport0.jsp -->
            <a href="gdSelectReport0.jsp" class="menu-link">Xem báo cáo</a>
            <a href="../member/doLogout0.jsp" class="btn-logout">Đăng xuất</a>
        </div>
    </div>
</body>
</html>