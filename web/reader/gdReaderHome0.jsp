<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*"%>
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
        margin-bottom: 30px;
        font-size: 24px;
    }
    .menu-link {
        display: inline-block;
        background-color: #2563eb;
        color: #ffffff;
        text-decoration: none;
        padding: 12px 24px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 15px;
        transition: background-color 0.2s;
    }
    .menu-link:hover {
        background-color: #1d4ed8;
    }
</style>
</head>
<body>
    <div class="card-container">
        <h2>Trang chủ bạn đọc</h2>
        <a href="gdRegisterReaderCard0.jsp" class="menu-link">Đăng ký làm thẻ bạn đọc</a>
    </div>
</body>
</html>