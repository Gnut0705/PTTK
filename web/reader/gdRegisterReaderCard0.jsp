<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.time.LocalDate,model.Reader0"%>
<%
    Reader0 reader = (Reader0) session.getAttribute("reader");
    if (reader == null) {
        response.sendRedirect("../member/gdLogin0.jsp?err=session");
        return;
    }

    LocalDate issuanceDate = LocalDate.now();
    LocalDate expiryDate = issuanceDate.plusYears(1);
    String autoCardCode = String.format("RC%08d", System.currentTimeMillis() % 100000000L);

    String curReaderCode = reader.getReaderCode() != null ? reader.getReaderCode() : "";
    String curFullName = reader.getFullName() != null ? reader.getFullName() : "";
    String curPhoneNumber = reader.getPhoneNumber() != null ? reader.getPhoneNumber() : "";
    String curAddress = reader.getAddress() != null ? reader.getAddress() : "";
    String curEmail = reader.getEmail() != null ? reader.getEmail() : "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dang ky lam the ban doc</title>
<style type="text/css">
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }
    .form-container {
        background-color: #ffffff;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        width: 440px;
    }
    h2 {
        text-align: center;
        color: #1a365d;
        margin-top: 0;
        margin-bottom: 20px;
        font-size: 22px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    td {
        padding: 8px 4px;
        font-size: 14px;
        color: #334155;
    }
    .section-title {
        padding-top: 14px;
        padding-bottom: 6px;
        font-size: 15px;
        color: #1e40af;
        border-bottom: 1px solid #e2e8f0;
    }
    input[type="text"],
    input[type="email"] {
        width: 100%;
        padding: 9px 12px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
        box-sizing: border-box;
        transition: border-color 0.2s, box-shadow 0.2s;
    }
    input[type="text"]:focus,
    input[type="email"]:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        outline: none;
    }
    input[readonly] {
        background-color: #f1f5f9;
        color: #64748b;
        cursor: not-allowed;
        border-color: #e2e8f0;
    }
    .btn-group {
        padding-top: 20px;
        text-align: center;
    }
    .btn {
        padding: 10px 24px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        margin: 0 6px;
        transition: background-color 0.2s;
    }
    .btn-back {
        background-color: #e2e8f0;
        color: #334155;
    }
    .btn-back:hover {
        background-color: #cbd5e1;
    }
    .btn-submit {
        background-color: #2563eb;
        color: #ffffff;
    }
    .btn-submit:hover {
        background-color: #1d4ed8;
    }
</style>
</head>
<body>
    <div class="form-container">
        <h2>Đăng ký làm thẻ bạn đọc</h2>
        <form name="dangkythe" action="doRegisterReaderCard0.jsp" method="post">
            <table>
                <tr>
                    <td colspan="2" class="section-title"><b>Thông tin đăng ký làm thẻ bạn đọc</b></td>
                </tr>
                <tr>
                    <td width="35%">Mã bạn đọc(MSV):</td>
                    <td><input type="text" name="txtReaderCode" value="<%= curReaderCode %>"
                               placeholder="Nhập mã sinh viên (VD: B23DCCN900)..." required /></td>
                </tr>
                <tr>
                    <td>Họ và tên:</td>
                    <td><input type="text" name="txtFullName" value="<%= curFullName %>"
                               placeholder="Nhập họ và tên..." required /></td>
                </tr>
                <tr>
                    <td>Số điện thoại:</td>
                    <td><input type="text" name="txtPhoneNumber" value="<%= curPhoneNumber %>"
                               pattern="0[0-9]{9}"
                               title="Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0"
                               placeholder="Nhập số điện thoại..." required /></td>
                </tr>
                <tr>
                    <td>Địa chỉ:</td>
                    <td><input type="text" name="txtAddress" value="<%= curAddress %>"
                               placeholder="Nhập địa chỉ..." required /></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input type="email" name="txtEmail" value="<%= curEmail %>"
                               placeholder="Nhập địa chỉ email..." required /></td>
                </tr>
                <tr>
                    <td colspan="2" class="section-title"><b>Thông tin thẻ</b></td>
                </tr>
                <tr>
                    <td>Mã thẻ:</td>
                    <td><input type="text" name="txtCardCode" value="<%= autoCardCode %>" readonly /></td>
                </tr>
                <tr>
                    <td>Ngày cấp:</td>
                    <td><input type="text" name="txtCardIssuanceDate" value="<%= issuanceDate.toString() %>" readonly /></td>
                </tr>
                <tr>
                    <td>Ngày hết hạn:</td>
                    <td><input type="text" name="txtExpiry" value="<%= expiryDate.toString() %>" readonly /></td>
                </tr>
                <tr>
                    <td colspan="2" class="btn-group">
                        <button type="button" class="btn btn-back"
                                onclick="window.location.href='gdReaderHome0.jsp'">Quay lại</button>
                        <input type="submit" class="btn btn-submit" name="btnAdd" value="Thêm" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>