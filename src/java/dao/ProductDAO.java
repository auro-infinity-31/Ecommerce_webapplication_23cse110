package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // 🟢 Get all products
    public static List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT id, name, price, image_url, description, category FROM products";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                products.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // 🟢 Get one product by id
    public static Product getProductById(int id) {
        Product p = null;
        String sql = "SELECT id, name, price, image_url, description, category FROM products WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setDescription(rs.getString("description"));
                    p.setCategory(rs.getString("category"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    // 🟢 Insert product (optional helper)
    public static void addProduct(Product p) {
        String sql = "INSERT INTO products (name, price, image_url, description, category) VALUES (?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getImageUrl());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getCategory());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
