<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.sql.Date,dao.*,model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chi tiet cac lan tai lieu duoc muon</title>
<style type="text/css">
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        min-height: 100vh;
        margin: 0;
        padding-top: 40px;
    }
    .card-container {
        background-color: #ffffff;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        width: 760px;
    }
    h2 {
        text-align: center;
        color: #1a365d;
        margin-top: 0;
        margin-bottom: 20px;
        font-size: 22px;
    }
    .info-box {
        background-color: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 6px;
        padding: 12px 18px;
        margin-bottom: 20px;
        font-size: 14px;
        color: #334155;
        line-height: 1.8;
    }
    table.stat-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    table.stat-table th, table.stat-table td {
        border: 1px solid #cbd5e1;
        padding: 10px 12px;
        font-size: 14px;
        text-align: center;
    }
    table.stat-table th {
        background-color: #eff6ff;
        color: #1e40af;
        font-weight: 600;
    }
    table.stat-table tr:hover {
        background-color: #f8fafc;
    }
    .slip-link {
        color: #2563eb;
        text-decoration: none;
        font-weight: 600;
    }
    .slip-link:hover {
        text-decoration: underline;
    }
    .btn-back {
        padding: 9px 20px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        background-color: #e2e8f0;
        color: #334155;
    }
    .btn-back:hover {
        background-color: #cbd5e1;
    }
</style>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    int idDoc = Integer.parseInt(request.getParameter("idDoc"));
    String docName = request.getParameter("docName");
    String strStart = request.getParameter("startDate");
    String strEnd = request.getParameter("endDate");

    Date startDate = Date.valueOf(strStart);
    Date endDate = Date.valueOf(strEnd);

    // Bước 18 - 23: Gọi LoanSlipDAO0 lấy danh sách các lần mượn của tài liệu
    LoanSlipDAO0 dao = new LoanSlipDAO0();
    ArrayList<LoanSlip0> listSlips = dao.getLoanSlipsByDoc(idDoc, startDate, endDate);
%>
    <div class="card-container">
        <h2>Chi tiết các lần tài liệu được mượn</h2>

        <div class="info-box">
            <div><b>Tài liệu:</b> <%= docName != null ? docName : "" %></div>
            <div>
                <b>Từ ngày:</b> <%= strStart %>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <b>Đến ngày:</b> <%= strEnd %>
            </div>
        </div>

        <!-- Bước 24: Hiển thị danh sách các lần tài liệu được mượn -->
        <table class="stat-table">
            <thead>
                <tr>
                    <th width="8%">TT</th>
                    <th width="20%">Mã phiếu mượn</th>
                    <th>Tên bạn đọc</th>
                    <th width="20%">Ngày mượn</th>
                    <th width="20%">Hạn trả</th>
                </tr>
            </thead>
            <tbody>
                <% if (listSlips == null || listSlips.isEmpty()) { %>
                <tr>
                    <td colspan="5">Không có dữ liệu phiếu mượn.</td>
                </tr>
                <% } else {
                    for (int i = 0; i < listSlips.size(); i++) {
                        LoanSlip0 ls = listSlips.get(i);
                        String slipCode = "LS" + String.format("%02d", ls.getId());
                %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <!-- Bước 25, 26: Click chọn 1 lần mượn -> gọi gdLoanSlipDetail0.jsp -->
                    <td>
                        <a class="slip-link" href="gdLoanSlipDetail0.jsp?idLoanSlip=<%= ls.getId() %>"><%= slipCode %></a>
                    </td>
                    <td style="text-align: left;"><%= ls.getReader().getFullName() %></td>
                    <td><%= ls.getBorrowingDate() %></td>
                    <td><%= ls.getDueDate() %></td>
                </tr>
                <%  }
                   } %>
            </tbody>
        </table>

        <button type="button" class="btn-back" onclick="history.back()">Quay lại</button>
    </div>
</body>
</html>