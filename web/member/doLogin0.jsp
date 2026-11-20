<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.MemberDAO0,model.Member0,model.Manager0,model.Reader0"%>
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

    MemberDAO0 dao = new MemberDAO0();
    Member0 member = dao.checkLogin(u.trim(), p);

    if (member instanceof Manager0) {
        session.removeAttribute("reader");
        session.setAttribute("manager", (Manager0) member);
        session.setAttribute("member", member);
        response.sendRedirect("../manager/gdManagerHome0.jsp");
    } else if (member instanceof Reader0) {
        session.removeAttribute("manager");
        session.setAttribute("reader", (Reader0) member);
        session.setAttribute("member", member);
        response.sendRedirect("../reader/gdReaderHome0.jsp");
    } else if (member != null) {
        response.sendRedirect("gdLogin0.jsp?err=role");
    } else {
        response.sendRedirect("gdLogin0.jsp?err=invalid");
    }
%>
</body>
</html>