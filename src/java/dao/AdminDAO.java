package dao;

import model.Product;
import model.User;
import model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    private Connection conn;

    public AdminDAO() throws SQLException {
        // use your existing DBConnection utility
        this.conn = DBConnection.getConnection();
    }

    /* ---------------------- Products ---------------------- */
    public List<Product> getAllProducts() throws SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, name, price, image_url FROM products";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image_url"));
                list.add(p);
            }
        }
        return list;
    }

    /* ---------------------- Orders ---------------------- */
    public List<Order> getAllOrders() throws SQLException {
    List<Order> list = new ArrayList<>();
    String sql = "SELECT o.id, u.email AS user_email, o.order_date, o.delivery_date, " +
                 "o.total_amount, o.status " +
                 "FROM orders o JOIN users u ON o.user_email = u.email"; // <-- use your actual column
    try (PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Order order = new Order();
            order.setId(rs.getInt("id"));
            order.setUserEmail(rs.getString("user_email"));
            order.setOrderDate(rs.getString("order_date"));
            order.setDeliveryDate(rs.getString("delivery_date"));
            order.setTotalAmount(rs.getDouble("total_amount"));
            order.setStatus(rs.getString("status"));
            list.add(order);
        }
    }
    return list;
}

    /* ---------------------- Users ---------------------- */
    public List<User> getAllUsers() throws SQLException {
        List<User> list = new ArrayList<>();
        // You only store these fields in your User model, so fetch exactly them
        String sql = "SELECT role, name, email, phone, gender, address, password, security_question FROM users";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setRole(rs.getString("role"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setGender(rs.getString("gender"));
                u.setAddress(rs.getString("address"));
                u.setPassword(rs.getString("password"));
                u.setSecurityQuestion(rs.getString("security_question"));
                list.add(u);
            }
        }
        return list;
    }
}
