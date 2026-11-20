<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dang xuat</title>
</head>
<body>
<%
    session.removeAttribute("manager");
    session.removeAttribute("reader");
    session.removeAttribute("member");
    session.invalidate();
    response.sendRedirect("gdLogin0.jsp");
%>
</body>
</html>