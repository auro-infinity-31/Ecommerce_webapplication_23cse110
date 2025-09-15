package dao;

import java.sql.*;
import model.User;

public class UserDAO {
    private Connection conn;

    // ✅ Pass connection from outside (recommended)
    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Or, if you really want to fetch internally:
    // public UserDAO() {
    //     this.conn = DBconnection.getConnection();
    // }

    // Register user
    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (role, name, email, phone, gender, address, password, security_question) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getRole());
            ps.setString(2, user.getName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getGender());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getPassword());
            ps.setString(8, user.getSecurityQuestion());
            return ps.executeUpdate() > 0;
        }
    }

    // Login user
    public User loginUser(String email, String password, String role) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND role = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, role);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setGender(rs.getString("gender"));
                    user.setRole(rs.getString("role"));  // ✅ set role from DB
                    user.setPassword(rs.getString("password")); // optional
                    user.setSecurityQuestion(rs.getString("security_question")); // optional
                    return user;
                }
            }
        }
        return null;
    }

    // Check if user exists
    public boolean userExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}
