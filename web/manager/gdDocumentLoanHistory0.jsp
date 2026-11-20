<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,dao.*,model.*"%>
<%
    Manager0 manager = (Manager0) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../member/gdLogin0.jsp?err=session");
        return;
    }

    int idLoanSlip = 0;
    try {
        idLoanSlip = Integer.parseInt(request.getParameter("idLoanSlip"));
    } catch (Exception e) {
        response.sendRedirect("gdDocumentStat0.jsp");
        return;
    }

    // Bước 27 - 32: Gọi LoanSlipDetailsDAO0.getLoanSlipDetails() lấy chi tiết phiếu mượn
    LoanSlipDetailsDAO0 dao = new LoanSlipDetailsDAO0();
    ArrayList<LoanSlipDetails0> details = dao.getLoanSlipDetails(idLoanSlip);

    LoanSlip0 slip = (details != null && !details.isEmpty()) ? details.get(0).getLoanSlip() : null;
    String slipCode = "LS" + String.format("%02d", idLoanSlip);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chi tiet phieu muon</title>
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
    .info-row {
        display: flex;
        justify-content: space-between;
    }
    .info-col {
        width: 48%;
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
    <div class="card-container">
        <h2>Chi tiết phiếu mượn</h2>

        <% if (slip != null) { %>
        <div class="info-box">
            <div><b>Mã phiếu mượn:</b> <%= slipCode %></div>
            <div class="info-row">
                <div class="info-col"><b>Bạn đọc:</b> <%= slip.getReader().getFullName() %></div>
                <div class="info-col"><b>NV thư viện:</b> <%= slip.getLibrarian().getFullName() %></div>
            </div>
            <div class="info-row">
                <div class="info-col"><b>Ngày mượn:</b> <%= slip.getBorrowingDate() %></div>
                <div class="info-col"><b>Hạn trả:</b> <%= slip.getDueDate() %></div>
            </div>
        </div>
        <% } %>

        <!-- Bước 33: Hiển thị chi tiết các tài liệu trong phiếu mượn -->
        <table class="stat-table">
            <thead>
                <tr>
                    <th width="8%">TT</th>
                    <th width="18%">Mã tài liệu</th>
                    <th>Tên tài liệu</th>
                    <th width="20%">Tình trạng</th>
                    <th width="22%">Ghi chú</th>
                </tr>
            </thead>
            <tbody>
                <% if (details == null || details.isEmpty()) { %>
                <tr>
                    <td colspan="5">Không có chi tiết tài liệu cho phiếu mượn này.</td>
                </tr>
                <% } else {
                    for (int i = 0; i < details.size(); i++) {
                        LoanSlipDetails0 d = details.get(i);
                %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><%= d.getDocument().getDocumentCode() %></td>
                    <td style="text-align: left;"><%= d.getDocument().getName() %></td>
                    <td><%= d.getStatus() %></td>
                    <td style="text-align: left;"><%= d.getNote() != null ? d.getNote() : "" %></td>
                </tr>
                <%  }
                   } %>
            </tbody>
        </table>

        <button type="button" class="btn-back" onclick="history.back()">Quay lại</button>
    </div>
</body>
</html>