package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.*;
import model.User;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String role = req.getParameter("role");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        

        try {
            // Admin role requires security key check
            

            // Fetch user from database
            User user = new UserDAO(DBConnection.getConnection()).loginUser(email, password, role);
            
            if (user != null) {
                // Make sure all fields are set
                HttpSession session = req.getSession();
                session.setAttribute("user", user); // user object contains email, name, address, role, etc.

                // Debug: print session user details
                System.out.println("Session User Details:");
                System.out.println("Name: " + user.getName());
                System.out.println("Email: " + user.getEmail());
                System.out.println("Phone: " + user.getPhone());
                System.out.println("Address: " + user.getAddress());
                System.out.println("Role: " + user.getRole());
                System.out.println("Gender: " + user.getGender());

                // Redirect according to role
                if ("admin".equals(role)) {
                    resp.sendRedirect(req.getContextPath() + "/adminDashboard");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/home.jsp");
                }

            } else {
                req.setAttribute("message", "Invalid email or password.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Error: " + e.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
