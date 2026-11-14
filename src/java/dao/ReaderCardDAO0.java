// File: src/dao/ReaderCardDAO0.java
package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.Reader0;
import model.ReaderCard0;

public class ReaderCardDAO0 extends DAO0 {
    public ReaderCardDAO0() {
        super();
    }

    private boolean isDuplicate(String table, String column, String value) throws Exception {
        String sql = "SELECT COUNT(*) FROM " + table + " WHERE " + column + " = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, value);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
                return false;
            }
        }
    }

    public String addReaderCard(String readerCode, String fullName, String phoneNumber,
                                 String address, String email, String cardCode,
                                 Date issuanceDate, Date expiryDate) {
        
        try {
            // Kiểm tra trùng lặp
            if (isDuplicate("tblMember0", "username", readerCode)) return "Mã bạn đọc đã tồn tại!";
            if (isDuplicate("tblMember0", "phonenumber", phoneNumber)) return "Số điện thoại đã tồn tại!";
            if (isDuplicate("tblReader0", "email", email)) return "Email đã được sử dụng!";

            // BƯỚC 8, 9: Hàm addReaderCard() gọi lớp ReaderCard0 để đóng gói thông tin thẻ
            ReaderCard0 card = new ReaderCard0();
            card.setCardCode(cardCode);
            card.setCardIssuanceDate(issuanceDate);
            card.setExpiry(expiryDate);

            // BƯỚC 11, 12: Hàm addReaderCard() gọi lớp Reader0 để đóng gói thông tin bạn đọc
            Reader0 reader = new Reader0();
            reader.setReaderCode(readerCode);
            reader.setUsername(readerCode); // Trường username của Member0
            reader.setFullName(fullName);
            reader.setPhoneNumber(phoneNumber);
            reader.setAddress(address);
            reader.setEmail(email);
            reader.setReaderCard(card); // Liên kết Reader với Card

            // BƯỚC 14: Hàm addReaderCard() lưu dữ liệu vào CSDL
            this.con.setAutoCommit(false);

            // 1. Insert tblMember0
            String sqlInsertMember = "INSERT INTO tblMember0(username, password, phonenumber, fullname, role) VALUES(?, ?, ?, ?, ?)";
            int memberId = 0;
            try (PreparedStatement psMember = con.prepareStatement(sqlInsertMember, Statement.RETURN_GENERATED_KEYS)) {
                psMember.setString(1, reader.getUsername()); 
                psMember.setString(2, "123456");   
                psMember.setString(3, reader.getPhoneNumber());
                psMember.setString(4, reader.getFullName());
                psMember.setString(5, "reader");
                psMember.executeUpdate();

                try (ResultSet rsMember = psMember.getGeneratedKeys()) {
                    if (rsMember.next()) memberId = rsMember.getInt(1);
                }
            }

            // 2. Insert tblReader0
            String sqlInsertReader = "INSERT INTO tblReader0(readerCode, address, email, tblMember0id) VALUES(?, ?, ?, ?)";
            try (PreparedStatement psReader = con.prepareStatement(sqlInsertReader)) {
                psReader.setString(1, reader.getReaderCode());
                psReader.setString(2, reader.getAddress());
                psReader.setString(3, reader.getEmail());
                psReader.setInt(4, memberId);
                psReader.executeUpdate();
            }

            // 3. Insert tblReaderCard0
            String sqlInsertCard = "INSERT INTO tblReaderCard0(cardCode, cardIssuanceDate, expiry, tblReader0id) VALUES(?,?,?,?)";
            try (PreparedStatement psCard = con.prepareStatement(sqlInsertCard)) {
                // Lấy dữ liệu từ đối tượng reader.getReaderCard()
                psCard.setString(1, reader.getReaderCard().getCardCode());
                psCard.setDate(2, reader.getReaderCard().getCardIssuanceDate());
                psCard.setDate(3, reader.getReaderCard().getExpiry());
                psCard.setInt(4, memberId);
                psCard.executeUpdate();
            }

            this.con.commit();
            return "SUCCESS"; // Trả kết quả về cho JSP (Bước 14)

        } catch (Exception e) {
            try { this.con.rollback(); } catch (Exception ee) { ee.printStackTrace(); }
            e.printStackTrace();
            return "Lỗi hệ thống: " + e.getMessage();
        } finally {
            try { this.con.setAutoCommit(true); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}