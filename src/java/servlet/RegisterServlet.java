package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.*;
import model.User;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        user.setRole(req.getParameter("role"));
        user.setName(req.getParameter("name"));
        user.setEmail(req.getParameter("email"));
        user.setPhone(req.getParameter("phone"));
        user.setGender(req.getParameter("gender"));
        user.setAddress(req.getParameter("address"));
        user.setPassword(req.getParameter("password"));
        user.setSecurityQuestion(req.getParameter("security_question"));

        try {
            Connection conn = DBConnection.getConnection();
            UserDAO dao = new UserDAO(conn);
            
            String role = req.getParameter("role");
            String pin = req.getParameter("pin");

            // if admin, check PIN
            


            // Check if user already exists
            if (dao.userExists(user.getEmail())) {
                req.setAttribute("message", "User already exists. Please login.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp); // ✅ JSP inside /web
                return;
            }
            if ("admin".equals(role) && !"110".equals(pin)) {
                req.setAttribute("message", "Invalid Admin Security PIN.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            boolean success = dao.registerUser(user);
            if (success) {
                req.setAttribute("message", "Registration successful. Please login.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp); // ✅ JSP inside /web
            } else {
                req.setAttribute("message", "Registration failed. Please try again.");
                req.getRequestDispatcher("/register.jsp").forward(req, resp); // ✅ JSP inside /web
            }
        } catch (Exception e) {
            req.setAttribute("message", "Error: " + e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
