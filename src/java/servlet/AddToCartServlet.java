package servlet;

import dao.CartDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Add item to cart using CartDAO
            CartDAO.addToCart(user.getEmail(), productId, quantity);

            // Redirect to cart page
            response.sendRedirect("cart.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp");
        }
    }
}
