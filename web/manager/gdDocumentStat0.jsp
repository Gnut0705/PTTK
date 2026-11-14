<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.sql.Date,java.net.URLEncoder,dao.*,model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thong ke tai lieu theo so lan muon</title>
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
        margin-bottom: 24px;
        font-size: 22px;
    }
    .filter-form {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 15px;
        margin-bottom: 24px;
        flex-wrap: wrap;
        font-size: 14px;
        color: #334155;
    }
    input[type="date"] {
        padding: 8px 10px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
    }
    table.stat-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
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
    .doc-link {
        color: #2563eb;
        text-decoration: none;
        font-weight: 600;
    }
    .doc-link:hover {
        text-decoration: underline;
    }
    .btn {
        padding: 9px 20px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s;
    }
    .btn-submit {
        background-color: #2563eb;
        color: #ffffff;
    }
    .btn-submit:hover {
        background-color: #1d4ed8;
    }
    .btn-back {
        background-color: #e2e8f0;
        color: #334155;
    }
    .btn-back:hover {
        background-color: #cbd5e1;
    }
    .footer-bar {
        text-align: left;
        margin-top: 10px;
    }
</style>
</head>
<body>
<%
    // Bước 8: Trang gdDocumentStat0.jsp submit vào chính nó để xử lý
    String strStart = request.getParameter("txtStartDate");
    String strEnd = request.getParameter("txtEndDate");
    ArrayList<DocumentStatistics0> listStats = null;

    if (strStart != null && !strStart.isEmpty() && strEnd != null && !strEnd.isEmpty()) {
        Date startDate = Date.valueOf(strStart);
        Date endDate = Date.valueOf(strEnd);

        // Kiểm tra ngoại lệ 5.1: Ngày bắt đầu lớn hơn ngày kết thúc
        if (startDate.after(endDate)) {
%>
            <script type="text/javascript">
                alert("Ngày bắt đầu không được lớn hơn ngày kết thúc!");
                history.back();
            </script>
<%
            return;
        }

        // Bước 9 - 14: Gọi DocumentStatisticsDAO0 lấy danh sách thống kê
        DocumentStatisticsDAO0 dao = new DocumentStatisticsDAO0();
        listStats = dao.getDocumentStats(startDate, endDate);
    }
%>
    <div class="card-container">
        <h2>Thống kê tài liệu theo số lần mượn</h2>

        <!-- Form chọn ngày bắt đầu, ngày kết thúc -->
        <form class="filter-form" name="thongketailieu" action="gdDocumentStat0.jsp" method="get">
            <div>
                <label><b>Ngày bắt đầu:</b></label>
                <input type="date" name="txtStartDate" value="<%=strStart != null ? strStart : ""%>" required />
            </div>
            <div>
                <label><b>Ngày kết thúc:</b></label>
                <input type="date" name="txtEndDate" value="<%=strEnd != null ? strEnd : ""%>" required />
            </div>
            <input type="submit" class="btn btn-submit" name="btnViewStat" value="Xem thống kê" />
        </form>

        <!-- Bước 15: Hiển thị bảng danh sách thống kê tài liệu -->
        <% if (listStats != null) { %>
        <table class="stat-table">
            <thead>
                <tr>
                    <th width="8%">TT</th>
                    <th width="18%">Mã tài liệu</th>
                    <th>Tên tài liệu</th>
                    <th width="15%">Năm XB</th>
                    <th width="18%">Số lần mượn</th>
                </tr>
            </thead>
            <tbody>
                <% if (listStats.isEmpty()) { %>
                <tr>
                    <td colspan="5">Không có tài liệu nào được mượn trong khoảng thời gian đã chọn.</td>
                </tr>
                <% } else {
                    for (int i = 0; i < listStats.size(); i++) {
                        DocumentStatistics0 doc = listStats.get(i);
                        String encodedName = URLEncoder.encode(doc.getName(), "UTF-8");
                        String detailUrl = "gdDocumentLoanHistory0.jsp?idDoc=" + doc.getId()
                                         + "&docName=" + encodedName
                                         + "&startDate=" + strStart
                                         + "&endDate=" + strEnd;
                %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><%= doc.getDocumentCode() %></td>
                    <!-- Bước 16, 17: Click chọn 1 tài liệu -> gọi gdDocumentLoanHistory0.jsp -->
                    <td style="text-align: left;">
                        <a class="doc-link" href="<%= detailUrl %>"><%= doc.getName() %></a>
                    </td>
                    <td><%= doc.getYearOfPublication() %></td>
                    <td><b><%= doc.getNumberOfTimesBorrowed() %></b></td>
                </tr>
                <%  }
                   } %>
            </tbody>
        </table>
        <% } %>

        <div class="footer-bar">
            <button type="button" class="btn btn-back" onclick="window.location.href='gdSelectReport0.jsp'">Quay lại</button>
        </div>
    </div>
</body>
</html>