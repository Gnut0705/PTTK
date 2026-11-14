<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.Date,dao.*,model.*"%>
<html>
<head>...</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    
    // Nhận dữ liệu từ form
    String readerCode = request.getParameter("txtReaderCode"); 
    String fullName = request.getParameter("txtFullName");
    String phoneNumber = request.getParameter("txtPhoneNumber");
    String address = request.getParameter("txtAddress");
    String email = request.getParameter("txtEmail");
    String cardCode = request.getParameter("txtCardCode");
    Date issuanceDate = Date.valueOf(request.getParameter("txtCardIssuanceDate"));
    Date expiryDate = Date.valueOf(request.getParameter("txtExpiry"));

    // BƯỚC 6: Gọi lớp ReaderCardDAO0 yêu cầu lưu thông tin
    ReaderCardDAO0 dao = new ReaderCardDAO0();
    
    // BƯỚC 7: Gọi hàm addReaderCard0() (Truyền dữ liệu thô vào) khớp Sequence Diagram
    String result = dao.addReaderCard0(readerCode, fullName, phoneNumber, address, email, cardCode, issuanceDate, expiryDate);

    // BƯỚC 14, 15: Nhận kết quả và thông báo
    if ("SUCCESS".equals(result)) {
%>
    <script>
        // BƯỚC 15: Thông báo thành công
        alert("Đăng ký làm thẻ bạn đọc thành công!");
        // BƯỚC 16, 17: Click OK -> Gọi lại gdReaderHome0.jsp
        window.location.href = "gdReaderHome0.jsp";
    </script>
<%
    } else {
%>
    <script>
        alert("<%= result %>");
        history.back();
    </script>
<%
    }
%>
</body>
</html>