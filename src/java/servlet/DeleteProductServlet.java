package servlet;

import dao.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect("admin/products.jsp?error=Missing+product+ID");
            return;
        }

        int id = Integer.parseInt(idStr);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM products WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/products.jsp?error=Database+error");
            return;
        }

        response.sendRedirect("admin/products.jsp?success=Product+deleted");
    }
}
