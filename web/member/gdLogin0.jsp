<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dang nhap he thong</title>
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
            padding: 40px 45px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 360px;
            text-align: left;
        }
        h2 {
            color: #1a365d;
            margin-top: 0;
            margin-bottom: 25px;
            font-size: 24px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 14px;
            color: #334155;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            outline: none;
            transition: border-color 0.2s;
        }
        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #2563eb;
        }
        .btn-submit {
            width: 100%;
            background-color: #2563eb;
            color: #ffffff;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #1d4ed8;
        }
        .error-msg {
            background-color: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="card-container">
        <h2>Đăng nhập hệ thống</h2>

        <%
            String err = request.getParameter("err");
            if ("invalid".equals(err)) {
        %>
            <div class="error-msg">Tên đăng nhập hoặc mật khẩu không chính xác!</div>
        <% } else if ("empty".equals(err)) { %>
            <div class="error-msg">Vui lòng nhập đầy đủ thông tin!</div>
        <% } else if ("session".equals(err)) { %>
            <div class="error-msg">Vui lòng đăng nhập để tiếp tục!</div>
        <% } else if ("role".equals(err)) { %>
            <div class="error-msg">Tài khoản không có quyền truy cập chức năng này!</div>
        <% } %>

        <form action="doLogin0.jsp" method="POST">
            <div class="form-group">
                <label for="txtUsername">Tên đăng nhập:</label>
                <input type="text" id="txtUsername" name="txtUsername"
                       placeholder="Nhập tên đăng nhập" required autofocus />
            </div>

            <div class="form-group">
                <label for="txtPassword">Mật khẩu:</label>
                <input type="password" id="txtPassword" name="txtPassword"
                       placeholder="Nhập mật khẩu" required />
            </div>

            <button type="submit" class="btn-submit">Đăng nhập</button>
        </form>
    </div>
</body>
</html>