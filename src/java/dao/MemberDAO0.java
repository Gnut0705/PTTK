// File: src/dao/MemberDAO0.java
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Manager0;
import model.Member0;
import model.Reader0;
import model.ReaderCard0;

public class MemberDAO0 extends DAO0 {
    public MemberDAO0() {
        super();
    }

    private void populateCommonFields(Member0 member, ResultSet rs) throws SQLException {
        member.setId(rs.getInt("id"));
        member.setUsername(rs.getString("username"));
        member.setPassword(rs.getString("password"));
        member.setFullName(rs.getString("fullname"));
        member.setPhoneNumber(rs.getString("phonenumber"));
        member.setRole(rs.getString("role"));
    }

    /**
     * Kiem tra thong tin dang nhap cho thanh vien (Manager hoac Reader)
     * @param username Ten dang nhap
     * @param password Mat khau
     * @return Doi tuong Manager0 / Reader0 / Member0 neu hop le, nguoc lai tra ve null
     */
    public Member0 checkLogin(String username, String password) {
        if (this.con == null) return null;

        String sql = "SELECT m.id, m.username, m.password, m.fullname, m.phonenumber, m.role, " +
                     "       mn.managerCode, " +
                     "       r.readerCode, r.address, r.email, " +
                     "       rc.id AS cardId, rc.cardCode, rc.cardIssuanceDate, rc.expiry " +
                     "FROM tblMember0 m " +
                     "LEFT JOIN tblManager0 mn ON m.id = mn.tblMember0id " +
                     "LEFT JOIN tblReader0 r ON m.id = r.tblMember0id " +
                     "LEFT JOIN tblReaderCard0 rc ON r.tblMember0id = rc.tblReader0id " +
                     "WHERE m.username = ? AND m.password = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String role = rs.getString("role");
                    if ("manager".equalsIgnoreCase(role)) {
                        Manager0 manager = new Manager0();
                        populateCommonFields(manager, rs);
                        manager.setManagerCode(rs.getString("managerCode"));
                        return manager;
                    } else if ("reader".equalsIgnoreCase(role)) {
                        Reader0 reader = new Reader0();
                        populateCommonFields(reader, rs);
                        reader.setReaderCode(rs.getString("readerCode"));
                        reader.setAddress(rs.getString("address"));
                        reader.setEmail(rs.getString("email"));

                        if (rs.getString("cardCode") != null) {
                            ReaderCard0 card = new ReaderCard0();
                            card.setId(rs.getInt("cardId"));
                            card.setCardCode(rs.getString("cardCode"));
                            card.setCardIssuanceDate(rs.getDate("cardIssuanceDate"));
                            card.setExpiry(rs.getDate("expiry"));
                            reader.setReaderCard(card);
                        }
                        return reader;
                    } else {
                        Member0 member = new Member0();
                        populateCommonFields(member, rs);
                        return member;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Kiem tra dang nhap truyen vao doi tuong Member0
     */
    public boolean checkLogin(Member0 member) {
        if (member == null) return false;
        Member0 found = checkLogin(member.getUsername(), member.getPassword());
        if (found != null) {
            member.setId(found.getId());
            member.setFullName(found.getFullName());
            member.setPhoneNumber(found.getPhoneNumber());
            member.setRole(found.getRole());
            return true;
        }
        return false;
    }
}