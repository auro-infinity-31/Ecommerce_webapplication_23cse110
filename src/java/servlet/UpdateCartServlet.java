package servlet;

import dao.CartDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String param = params.nextElement();
            if (param.startsWith("quantity_")) {
                try {
                    int productId = Integer.parseInt(param.split("_")[1]);
                    int quantity = Integer.parseInt(request.getParameter(param));
                    CartDAO.updateCartQuantity(user.getEmail(), productId, quantity);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }

        response.sendRedirect("cart.jsp");
    }
}
