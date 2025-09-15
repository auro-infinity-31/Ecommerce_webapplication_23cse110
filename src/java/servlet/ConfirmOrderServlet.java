package servlet;

import dao.CartDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("user");
        if(loggedUser == null){
            response.sendRedirect("login.jsp");
            return;
        }

        // Redirect to checkout page
        response.sendRedirect("checkout.jsp");
    }
}
