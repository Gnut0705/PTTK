// File: src/dao/DocumentStatisticsDAO0.java
package dao;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.DocumentStatistics0;

public class DocumentStatisticsDAO0 extends DAO0 {
    public DocumentStatisticsDAO0() {
        super();
    }

    // Bước 10: getDocumentStats() khớp Stored Procedure & Sequence Diagram
    public ArrayList<DocumentStatistics0> getDocumentStats(Date startDate, Date endDate) {
        ArrayList<DocumentStatistics0> result = new ArrayList<>();
        if (this.con == null) return result;

        String sql = "{call getDocumentStats(?, ?)}";
        try (CallableStatement cs = con.prepareCall(sql)) {
            cs.setDate(1, startDate);
            cs.setDate(2, endDate);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    // Bước 11 - 13: Gọi lớp DocumentStatistics0 đóng gói thông tin thực thể
                    DocumentStatistics0 stat = new DocumentStatistics0();
                    stat.setId(rs.getInt("id"));
                    stat.setDocumentCode(rs.getString("documentCode"));
                    stat.setName(rs.getString("name"));
                    stat.setYearOfPublication(rs.getInt("yearOfPublication"));
                    stat.setNumberOfTimesBorrowed(rs.getInt("numberOfTimesBorrowed"));
                    result.add(stat);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}