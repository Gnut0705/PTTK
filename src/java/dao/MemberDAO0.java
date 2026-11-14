// File: src/dao/MemberDAO0.java
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Manager0;
import model.Member0;

public class MemberDAO0 extends DAO0 {
    public MemberDAO0() {
        super();
    }

    /**
     * Kiem tra thong tin dang nhap cua quan ly (Manager)
     * @param username Ten dang nhap
     * @param password Mat khau
     * @return Doi tuong Manager0 neu dang nhap thanh cong, nguoc lai tra ve null
     */
    public Manager0 checkLogin(String username, String password) {
        Manager0 manager = null;
        String sql = "SELECT m.id, m.username, m.password, m.fullname, m.phonenumber, m.role, mn.managerCode " +
                     "FROM tblMember0 m " +
                     "LEFT JOIN tblManager0 mn ON m.id = mn.tblMember0id " +
                     "WHERE m.username = ? AND m.password = ? AND m.role = 'manager'";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    manager = new Manager0();
                    manager.setId(rs.getInt("id"));
                    manager.setUsername(rs.getString("username"));
                    manager.setPassword(rs.getString("password"));
                    manager.setFullName(rs.getString("fullname"));
                    manager.setPhoneNumber(rs.getString("phonenumber"));
                    manager.setRole(rs.getString("role"));
                    manager.setManagerCode(rs.getString("managerCode"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return manager;
    }

    /**
     * Kiem tra dang nhap truyen vao doi tuong Member0
     */
    public boolean checkLogin(Member0 member) {
        if (member == null) return false;
        Manager0 m = checkLogin(member.getUsername(), member.getPassword());
        if (m != null) {
            member.setId(m.getId());
            member.setFullName(m.getFullName());
            member.setPhoneNumber(m.getPhoneNumber());
            member.setRole(m.getRole());
            return true;
        }
        return false;
    }
}
