// File: src/dao/ReaderCardDAO0.java
package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Reader0;
import model.ReaderCard0;

public class ReaderCardDAO0 extends DAO0 {
    private static final String PHONE_REGEX = "^0[0-9]{9}$";
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";

    public ReaderCardDAO0() {
        super();
    }

    private boolean hasReaderCard(int memberId) throws Exception {
        String sql = "SELECT COUNT(*) FROM tblReaderCard0 WHERE tblReader0id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean existsInReaderTable(int memberId) throws Exception {
        String sql = "SELECT COUNT(*) FROM tblReader0 WHERE tblMember0id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isDuplicateExcludeMember(String sql, String value, int memberId) throws Exception {
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, value);
            ps.setInt(2, memberId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isDuplicateCardCode(String cardCode) throws Exception {
        String sql = "SELECT COUNT(*) FROM tblReaderCard0 WHERE cardCode = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cardCode);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // BUOC 7: addReaderCard() khop Sequence Diagram & nghiep vu sau dang nhap
    public String addReaderCard(int memberId, String readerCode, String fullName,
                                String phoneNumber, String address, String email,
                                String cardCode, Date issuanceDate, Date expiryDate) {
        if (this.con == null) {
            return "Lỗi kết nối cơ sở dữ liệu, không thể lưu thông tin!";
        }

        // Chuan hoa du lieu dau vao
        readerCode = readerCode == null ? "" : readerCode.trim();
        fullName = fullName == null ? "" : fullName.trim();
        phoneNumber = phoneNumber == null ? "" : phoneNumber.trim();
        address = address == null ? "" : address.trim();
        email = email == null ? "" : email.trim();
        cardCode = cardCode == null ? "" : cardCode.trim();

        // Ngoai le 4.1: Kiem tra rong va dinh dang
        if (readerCode.isEmpty() || fullName.isEmpty() || phoneNumber.isEmpty()
                || address.isEmpty() || email.isEmpty() || cardCode.isEmpty()
                || issuanceDate == null || expiryDate == null) {
            return "Vui lòng nhập đầy đủ các trường thông tin bắt buộc!";
        }
        if (!phoneNumber.matches(PHONE_REGEX)) {
            return "Số điện thoại không hợp lệ (phải gồm 10 chữ số và bắt đầu bằng số 0)!";
        }
        if (!email.matches(EMAIL_REGEX)) {
            return "Địa chỉ email không đúng định dạng!";
        }

        try {
            // Ngoai le 5.1: Kiem tra ban doc da co the hoac trung lap du lieu
            if (hasReaderCard(memberId)) {
                return "Bạn đọc đã có thẻ bạn đọc!";
            }
            if (isDuplicateExcludeMember(
                    "SELECT COUNT(*) FROM tblReader0 WHERE readerCode = ? AND tblMember0id <> ?",
                    readerCode, memberId)) {
                return "Mã bạn đọc đã tồn tại!";
            }
            if (isDuplicateExcludeMember(
                    "SELECT COUNT(*) FROM tblMember0 WHERE phonenumber = ? AND id <> ?",
                    phoneNumber, memberId)) {
                return "Số điện thoại đã tồn tại!";
            }
            if (isDuplicateExcludeMember(
                    "SELECT COUNT(*) FROM tblReader0 WHERE email = ? AND tblMember0id <> ?",
                    email, memberId)) {
                return "Email đã được sử dụng!";
            }
            if (isDuplicateCardCode(cardCode)) {
                return "Mã thẻ đã tồn tại, vui lòng tải lại trang và thử lại!";
            }

            // BUOC 8, 9: Dong goi thong tin the vao ReaderCard0
            ReaderCard0 card = new ReaderCard0();
            card.setCardCode(cardCode);
            card.setCardIssuanceDate(issuanceDate);
            card.setExpiry(expiryDate);

            // BUOC 11, 12: Dong goi thong tin ban doc vao Reader0
            Reader0 reader = new Reader0();
            reader.setId(memberId);
            reader.setReaderCode(readerCode);
            reader.setFullName(fullName);
            reader.setPhoneNumber(phoneNumber);
            reader.setAddress(address);
            reader.setEmail(email);
            reader.setReaderCard(card);

            // BUOC 14: Luu du lieu vao CSDL trong 1 transaction
            this.con.setAutoCommit(false);

            // 1. Cap nhat thong tin ca nhan trong tblMember0 cua tai khoan dang dang nhap
            String sqlUpdateMember = "UPDATE tblMember0 SET fullname = ?, phonenumber = ? WHERE id = ?";
            try (PreparedStatement psMember = con.prepareStatement(sqlUpdateMember)) {
                psMember.setString(1, reader.getFullName());
                psMember.setString(2, reader.getPhoneNumber());
                psMember.setInt(3, reader.getId());
                psMember.executeUpdate();
            }

            // 2. Cap nhat hoac them moi ban ghi trong tblReader0 gan voi tblMember0id
            if (existsInReaderTable(memberId)) {
                String sqlUpdateReader = "UPDATE tblReader0 SET readerCode = ?, address = ?, email = ? WHERE tblMember0id = ?";
                try (PreparedStatement psReader = con.prepareStatement(sqlUpdateReader)) {
                    psReader.setString(1, reader.getReaderCode());
                    psReader.setString(2, reader.getAddress());
                    psReader.setString(3, reader.getEmail());
                    psReader.setInt(4, reader.getId());
                    psReader.executeUpdate();
                }
            } else {
                String sqlInsertReader = "INSERT INTO tblReader0(readerCode, address, email, tblMember0id) VALUES(?, ?, ?, ?)";
                try (PreparedStatement psReader = con.prepareStatement(sqlInsertReader)) {
                    psReader.setString(1, reader.getReaderCode());
                    psReader.setString(2, reader.getAddress());
                    psReader.setString(3, reader.getEmail());
                    psReader.setInt(4, reader.getId());
                    psReader.executeUpdate();
                }
            }

            // 3. Them moi the ban doc trong tblReaderCard0
            String sqlInsertCard = "INSERT INTO tblReaderCard0(cardCode, cardIssuanceDate, expiry, tblReader0id) VALUES(?, ?, ?, ?)";
            try (PreparedStatement psCard = con.prepareStatement(sqlInsertCard)) {
                psCard.setString(1, reader.getReaderCard().getCardCode());
                psCard.setDate(2, reader.getReaderCard().getCardIssuanceDate());
                psCard.setDate(3, reader.getReaderCard().getExpiry());
                psCard.setInt(4, reader.getId());
                psCard.executeUpdate();
            }

            this.con.commit();
            return "SUCCESS";
        } catch (Exception e) {
            try { this.con.rollback(); } catch (Exception ee) { ee.printStackTrace(); }
            e.printStackTrace();
            return "Lỗi kết nối cơ sở dữ liệu, không thể lưu thông tin!";
        } finally {
            try { this.con.setAutoCommit(true); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}