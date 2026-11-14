<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.MemberDAO0,model.Manager0"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Xu ly dang nhap</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String u = request.getParameter("txtUsername");
    String p = request.getParameter("txtPassword");

    if (u == null || u.trim().isEmpty() || p == null || p.trim().isEmpty()) {
        response.sendRedirect("gdLogin0.jsp?err=empty");
        return;
    }

    // Goi MemberDAO0 de kiem tra thong tin dang nhap
    MemberDAO0 dao = new MemberDAO0();
    Manager0 manager = dao.checkLogin(u.trim(), p);

    if (manager != null) {
        // Dang nhap thanh cong: Luu thong tin Manager vao Session
        session.setAttribute("manager", manager);
        response.sendRedirect("gdManagerHome0.jsp");
    } else {
        // Dang nhap that bai: Chuyen ve trang dang nhap kem ma loi
        response.sendRedirect("gdLogin0.jsp?err=invalid");
    }
%>
</body>
</html>
