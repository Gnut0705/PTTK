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
<title>Chon thong ke</title>
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
        padding: 35px 45px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        width: 420px;
    }
    h2 {
        text-align: center;
        color: #1a365d;
        margin-top: 0;
        margin-bottom: 25px;
        font-size: 22px;
    }
    .form-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 25px;
        font-size: 15px;
        color: #334155;
    }
    select {
        width: 72%;
        padding: 9px 12px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
        background-color: #ffffff;
    }
    .btn-group {
        text-align: center;
    }
    .btn {
        padding: 10px 24px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        margin: 0 5px;
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
    <div class="card-container">
        <h2>Chọn thống kê</h2>
        <!-- Bước 4, 5: Chọn thống kê tài liệu theo lượt mượn -> gọi gdDocumentStat0.jsp -->
        <form name="chonthongke" action="gdDocumentStat0.jsp" method="get">
            <div class="form-row">
                <label><b>Loại TK:</b></label>
                <select name="cboReportType">
                    <option value="docStat">TK tài liệu theo lượt mượn</option>
                    <option value="readerStat" disabled>TK độc giả theo số lần mượn</option>
                    <option value="supplierStat" disabled>TK nhà cung cấp theo số lượng nhập</option>
                </select>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-back" onclick="window.location.href='gdManagerHome0.jsp'">Quay lại</button>
                <input type="submit" class="btn btn-submit" name="btnView" value="Xem" />
            </div>
        </form>
    </div>
</body>
</html>