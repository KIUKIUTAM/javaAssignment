package db.impl;

import entity.Staff;
import java.sql.*;
import db.BaseDB;

public class StaffDB extends BaseDB {
    private String jdbcUrl;
    private String user;
    private String password;

    public StaffDB(String jdbcUrl, String user, String password) {
        super(jdbcUrl, user, password);
    }

    public Staff getStaffByCredentials(String userId, String password, String role) {
        String sql = "SELECT * FROM staff WHERE user_id = ? AND password = ? AND role = ?";
        String hashedPassword = sha256(password);
        return executeQuerySingle(sql, this::mapStaff, userId, hashedPassword, role);
    }

    public Staff getStaffByUserId(String userId) {
        String sql = "SELECT * FROM staff WHERE user_id = ?";
        return executeQuerySingle(sql, this::mapStaff, userId);
    }

    private String sha256(String password) {
        try {
            java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    private Staff mapStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setId(rs.getInt("id"));
        staff.setUserId(rs.getString("user_id"));
        staff.setName(rs.getString("name"));
        staff.setPassword(rs.getString("password"));
        staff.setRole(rs.getString("role"));
        int storeId = rs.getInt("store_id");
        if (!rs.wasNull()) {
            staff.setStoreId(storeId);
        } else {
            staff.setStoreId(null);
        }
        return staff;
    }
}
