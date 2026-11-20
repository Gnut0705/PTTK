// File: src/dao/LoanSlipDetailsDAO0.java
package dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Document0;
import model.Librarian0;
import model.LoanSlip0;
import model.LoanSlipDetails0;
import model.Reader0;

public class LoanSlipDetailsDAO0 extends DAO0 {
    public LoanSlipDetailsDAO0() {
        super();
    }

    // Bước 28: getLoanSlipDetails() khớp Stored Procedure & Sequence Diagram
    public ArrayList<LoanSlipDetails0> getLoanSlipDetails(int idLoanSlip) {
        ArrayList<LoanSlipDetails0> result = new ArrayList<>();
        if (this.con == null) return result;

        String sql = "{call getLoanSlipDetails(?)}";
        try (CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, idLoanSlip);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    // Bước 29 - 31: Gọi lớp LoanSlipDetails0 đóng gói thông tin thực thể
                    LoanSlipDetails0 detail = new LoanSlipDetails0();
                    detail.setId(rs.getInt("id"));
                    detail.setStatus(rs.getString("status"));
                    detail.setNote(rs.getString("note"));

                    Document0 doc = new Document0();
                    doc.setId(rs.getInt("docId"));
                    doc.setDocumentCode(rs.getString("documentCode"));
                    doc.setName(rs.getString("docName"));
                    detail.setDocument(doc);

                    LoanSlip0 slip = new LoanSlip0();
                    slip.setId(idLoanSlip);
                    slip.setBorrowingDate(rs.getDate("borrowingDate"));
                    slip.setDueDate(rs.getDate("dueDate"));

                    Reader0 reader = new Reader0();
                    reader.setFullName(rs.getString("readerName"));
                    slip.setReader(reader);

                    Librarian0 librarian = new Librarian0();
                    librarian.setFullName(rs.getString("librarianName"));
                    slip.setLibrarian(librarian);

                    detail.setLoanSlip(slip);
                    result.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}