package dao;

import model.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Add product to cart
    public static boolean addToCart(String userEmail, int productId, int quantity) {
        try(Connection conn = DBConnection.getConnection()){
            // Check if product already in cart
            String check = "SELECT id, quantity FROM cart_items WHERE user_email=? AND product_id=?";
            try(PreparedStatement ps = conn.prepareStatement(check)){
                ps.setString(1, userEmail);
                ps.setInt(2, productId);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    int existingQty = rs.getInt("quantity");
                    String update = "UPDATE cart_items SET quantity=? WHERE id=?";
                    try(PreparedStatement ps2 = conn.prepareStatement(update)){
                        ps2.setInt(1, existingQty + quantity);
                        ps2.setInt(2, rs.getInt("id"));
                        return ps2.executeUpdate() > 0;
                    }
                } else {
                    String insert = "INSERT INTO cart_items(user_email, product_id, quantity) VALUES(?,?,?)";
                    try(PreparedStatement ps2 = conn.prepareStatement(insert)){
                        ps2.setString(1, userEmail);
                        ps2.setInt(2, productId);
                        ps2.setInt(3, quantity);
                        return ps2.executeUpdate() > 0;
                    }
                }
            }
        } catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    // Get all cart items for a user
    public static List<CartItem> getCartItemsForUser(String userEmail){
        List<CartItem> cart = new ArrayList<>();
        String sql = "SELECT c.product_id, p.name, p.price, c.quantity, p.image_url " +
                     "FROM cart_items c JOIN products p ON c.product_id = p.id " +
                     "WHERE c.user_email=?";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                CartItem item = new CartItem();
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("name"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setImageUrl(rs.getString("image_url"));
                cart.add(item);
            }
        } catch(Exception e){ e.printStackTrace(); }
        return cart;
    }

    // Update cart quantity
    public static boolean updateCartQuantity(String userEmail, int productId, int quantity){
        String sql = "UPDATE cart_items SET quantity=? WHERE user_email=? AND product_id=?";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, quantity);
            ps.setString(2, userEmail);
            ps.setInt(3, productId);
            return ps.executeUpdate() > 0;
        } catch(Exception e){ e.printStackTrace(); return false; }
    }

    // Remove item from cart
    public static boolean removeFromCart(String userEmail, int productId){
        String sql = "DELETE FROM cart_items WHERE user_email=? AND product_id=?";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, userEmail);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch(Exception e){ e.printStackTrace(); return false; }
    }

    // Clear cart after order
    public static boolean clearCartForUser(String userEmail){
        String sql = "DELETE FROM cart_items WHERE user_email=?";
        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, userEmail);
            return ps.executeUpdate() > 0;
        } catch(Exception e){ e.printStackTrace(); return false; }
    }
}
