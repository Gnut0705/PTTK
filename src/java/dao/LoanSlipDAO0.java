// File: src/dao/LoanSlipDAO0.java
package dao;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Librarian0;
import model.LoanSlip0;
import model.Reader0;

public class LoanSlipDAO0 extends DAO0 {
    public LoanSlipDAO0() {
        super();
    }

    // Bước 19: getLoanSlipsByDoc() khớp Stored Procedure & Sequence Diagram
    public ArrayList<LoanSlip0> getLoanSlipsByDoc(int idDoc, Date startDate, Date endDate) {
        ArrayList<LoanSlip0> result = new ArrayList<>();
        if (this.con == null) return result;

        String sql = "{call getLoanSlipsByDoc(?, ?, ?)}";
        try (CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, idDoc);
            cs.setDate(2, startDate);
            cs.setDate(3, endDate);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    // Bước 20 - 22: Gọi lớp LoanSlip0 đóng gói thông tin thực thể
                    LoanSlip0 slip = new LoanSlip0();
                    slip.setId(rs.getInt("id"));
                    slip.setBorrowingDate(rs.getDate("borrowingDate"));
                    slip.setDueDate(rs.getDate("dueDate"));

                    Reader0 reader = new Reader0();
                    reader.setFullName(rs.getString("readerName"));
                    slip.setReader(reader);

                    Librarian0 librarian = new Librarian0();
                    librarian.setFullName(rs.getString("librarianName"));
                    slip.setLibrarian(librarian);

                    result.add(slip);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}