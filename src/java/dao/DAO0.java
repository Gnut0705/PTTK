// File: src/dao/DAO0.java
package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO0 {
    public static Connection con;

    public DAO0() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/libman0?autoReconnect=true&useSSL=false";
            String dbClass = "com.mysql.jdbc.Driver";
            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "123456");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}