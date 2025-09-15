package servlet;

import dao.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AddProductServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,   // 5MB
    maxRequestSize = 1024 * 1024 * 10
)
public class AddProductServlet extends HttpServlet {
    private static final String IMAGE_DIR = "images"; // folder inside webapp

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        Part filePart = request.getPart("image");

        if (name == null || priceStr == null || filePart == null) {
            response.sendRedirect("admin/products.jsp?error=Missing+data");
            return;
        }

        double price = Double.parseDouble(priceStr);
        String fileName = new File(filePart.getSubmittedFileName()).getName();

        // Save the file to the webapp/images folder
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + IMAGE_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Build the URL to save in DB: images/filename.jpg
        String imageUrl = IMAGE_DIR + "/" + fileName;

        // Insert into DB
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO products(name, price, image_url) VALUES(?,?,?)")) {
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setString(3, imageUrl); // store full path like old products
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/products.jsp?error=Database+error");
            return;
        }

        response.sendRedirect("admin/products.jsp?success=Product+added");
    }
}
