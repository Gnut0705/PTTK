<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.Reader0"%>
<%
    Reader0 reader = (Reader0) session.getAttribute("reader");
    if (reader == null) {
        response.sendRedirect("../member/gdLogin0.jsp?err=session");
        return;
    }
    String displayName = reader.getFullName() != null && !reader.getFullName().isEmpty()
            ? reader.getFullName()
            : reader.getUsername();
    String displayCode = reader.getReaderCode() != null && !reader.getReaderCode().isEmpty()
            ? " (Mã: " + reader.getReaderCode() + ")"
            : "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trang chu ban doc</title>
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
        min-width: 350px;
    }
    h2 {
        color: #1a365d;
        margin-top: 0;
        margin-bottom: 18px;
        font-size: 24px;
    }
    .welcome-box {
        background-color: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 6px;
        padding: 10px 16px;
        margin-bottom: 24px;
        font-size: 14px;
        color: #334155;
    }
    .welcome-name {
        color: #1d4ed8;
        font-weight: 600;
    }
    .menu-link {
        display: block;
        background-color: #2563eb;
        color: #ffffff;
        text-decoration: none;
        padding: 12px 24px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 15px;
        margin-bottom: 12px;
        transition: background-color 0.2s;
    }
    .menu-link:hover {
        background-color: #1d4ed8;
    }
    .logout-link {
        display: block;
        background-color: #f8fafc;
        color: #dc2626;
        border: 1px solid #fecaca;
        text-decoration: none;
        padding: 11px 24px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 14px;
        transition: background-color 0.2s;
    }
    .logout-link:hover {
        background-color: #fef2f2;
    }
</style>
</head>
<body>
    <div class="card-container">
        <h2>Trang chủ bạn đọc</h2>
        <div class="welcome-box">
            Xin chào, <span class="welcome-name"><%= displayName %></span><%= displayCode %>
        </div>
        <a href="gdRegisterReaderCard0.jsp" class="menu-link">Đăng ký làm thẻ bạn đọc</a>
        <a href="../member/doLogout0.jsp" class="logout-link">Đăng xuất</a>
    </div>
</body>
</html>