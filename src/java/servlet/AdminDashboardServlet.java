package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

import dao.DBConnection;
import javax.servlet.annotation.WebServlet;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {

            // Get counts from DB
            int totalProducts = getCount(conn, "SELECT COUNT(*) FROM products");
            int totalOrders   = getCount(conn, "SELECT COUNT(*) FROM orders");
            int totalUsers    = getCount(conn, "SELECT COUNT(*) FROM users WHERE role='user'");

            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("totalOrders", totalOrders);
            req.setAttribute("totalUsers", totalUsers);

            // Forward to admin.jsp
            req.getRequestDispatcher("/admin.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private int getCount(Connection conn, String sql) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
