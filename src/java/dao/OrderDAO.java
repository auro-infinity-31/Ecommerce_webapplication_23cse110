package dao;

import model.Order;
import model.OrderItem;

import java.sql.*;
import java.util.List;

public class OrderDAO {
    private Connection conn;

    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean placeOrder(Order order) throws SQLException {
        boolean success = false;
        String insertOrderSQL = "INSERT INTO orders(user_email, order_date, delivery_date, total_amount, status) VALUES (?, ?, ?, ?, ?)";
        String insertItemSQL = "INSERT INTO order_items(order_id, product_id, product_name, quantity, price) VALUES (?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false);

            // Insert into orders table
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, order.getUserEmail());
                ps.setString(2, order.getOrderDate());
                ps.setString(3, order.getDeliveryDate());
                ps.setDouble(4, order.getTotalAmount());
                ps.setString(5, order.getStatus());
                int affectedRows = ps.executeUpdate();

                if (affectedRows == 0) throw new SQLException("Creating order failed, no rows affected.");

                // Get generated order ID
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int orderId = rs.getInt(1);

                    // Insert order items
                    try (PreparedStatement psItem = conn.prepareStatement(insertItemSQL)) {
                        for (OrderItem item : order.getItems()) {
                            psItem.setInt(1, orderId);
                            psItem.setInt(2, item.getProductId());
                            psItem.setString(3, item.getProductName());
                            psItem.setInt(4, item.getQuantity());
                            psItem.setDouble(5, item.getPrice());
                            psItem.addBatch();
                        }
                        psItem.executeBatch();
                    }
                } else {
                    throw new SQLException("Failed to get order ID.");
                }
            }

            conn.commit();
            success = true;

        } catch (SQLException e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(true);
        }

        return success;
    }

    // Fetch all orders for a user
    public List<Order> getOrdersByUser(String userEmail) throws SQLException {
        List<Order> orders = new java.util.ArrayList<>();
        String sqlOrders = "SELECT * FROM orders WHERE user_email = ? ORDER BY id DESC";
        String sqlItems = "SELECT * FROM order_items WHERE order_id = ?";

        try (PreparedStatement psOrders = conn.prepareStatement(sqlOrders)) {
            psOrders.setString(1, userEmail);
            ResultSet rsOrders = psOrders.executeQuery();

            while (rsOrders.next()) {
                Order order = new Order();
                order.setId(rsOrders.getInt("id"));
                order.setUserEmail(rsOrders.getString("user_email"));
                order.setOrderDate(rsOrders.getString("order_date"));
                order.setDeliveryDate(rsOrders.getString("delivery_date"));
                order.setTotalAmount(rsOrders.getDouble("total_amount"));
                order.setStatus(rsOrders.getString("status"));

                // Get items for this order
                try (PreparedStatement psItems = conn.prepareStatement(sqlItems)) {
                    psItems.setInt(1, order.getId());
                    ResultSet rsItems = psItems.executeQuery();
                    List<OrderItem> items = new java.util.ArrayList<>();
                    while (rsItems.next()) {
                        OrderItem item = new OrderItem();
                        item.setProductId(rsItems.getInt("product_id"));
                        item.setProductName(rsItems.getString("product_name"));
                        item.setQuantity(rsItems.getInt("quantity"));
                        item.setPrice(rsItems.getDouble("price"));
                        items.add(item);
                    }
                    order.setItems(items);
                }

                orders.add(order);
            }
        }

        return orders;
    }
}
