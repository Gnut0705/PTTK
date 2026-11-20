<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Date,dao.ReaderCardDAO0,model.Reader0"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Xu ly dang ky the ban doc</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    Reader0 readerSession = (Reader0) session.getAttribute("reader");
    if (readerSession == null) {
        response.sendRedirect("../member/gdLogin0.jsp?err=session");
        return;
    }

    String readerCode = request.getParameter("txtReaderCode");
    String fullName = request.getParameter("txtFullName");
    String phoneNumber = request.getParameter("txtPhoneNumber");
    String address = request.getParameter("txtAddress");
    String email = request.getParameter("txtEmail");
    String cardCode = request.getParameter("txtCardCode");

    Date issuanceDate = null;
    Date expiryDate = null;
    try {
        issuanceDate = Date.valueOf(request.getParameter("txtCardIssuanceDate"));
        expiryDate = Date.valueOf(request.getParameter("txtExpiry"));
    } catch (Exception e) {
        // De DAO tra ve thong bao loi hop le
    }

    // BUOC 6, 7: Goi ReaderCardDAO0.addReaderCard()
    ReaderCardDAO0 dao = new ReaderCardDAO0();
    String result = dao.addReaderCard(
            readerSession.getId(),
            readerCode, fullName, phoneNumber, address, email,
            cardCode, issuanceDate, expiryDate
    );

    if ("SUCCESS".equals(result)) {
        // Dong bo thong tin moi nhat vao session de gdReaderHome0.jsp hien thi dung
        readerSession.setReaderCode(readerCode.trim());
        readerSession.setFullName(fullName.trim());
        readerSession.setPhoneNumber(phoneNumber.trim());
        readerSession.setAddress(address.trim());
        readerSession.setEmail(email.trim());
        session.setAttribute("reader", readerSession);
%>
    <script>
        alert("Đăng ký làm thẻ bạn đọc thành công!");
        window.location.href = "gdReaderHome0.jsp";
    </script>
<%
    } else {
        String safeMsg = result
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "")
                .replace("\n", " ");
%>
    <script>
        alert("<%= safeMsg %>");
        history.back();
    </script>
<%
    }
%>
</body>
</html>