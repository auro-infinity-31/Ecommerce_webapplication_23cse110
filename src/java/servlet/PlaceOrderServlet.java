package servlet;

import dao.CartDAO;
import dao.OrderDAO;
import dao.DBConnection;
import model.CartItem;
import model.Order;
import model.OrderItem;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser == null) { response.sendRedirect("login.jsp"); return; }

        try (Connection conn = DBConnection.getConnection()) {
            OrderDAO orderDAO = new OrderDAO(conn);

            List<CartItem> cartItems = CartDAO.getCartItemsForUser(loggedUser.getEmail());
            if (cartItems.isEmpty()) {
                response.sendRedirect("cart.jsp");
                return;
            }

            Order order = new Order();
            order.setUserEmail(loggedUser.getEmail());
            order.setOrderDate(LocalDate.now().toString());
            order.setDeliveryDate(LocalDate.now().plusDays(5).toString());
            order.setStatus("Pending");

            double total = 0.0;
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem ci : cartItems) {
                total += ci.getPrice() * ci.getQuantity();
                OrderItem oi = new OrderItem();
                oi.setProductId(ci.getProductId());
                oi.setProductName(ci.getProductName());
                oi.setQuantity(ci.getQuantity());
                oi.setPrice(ci.getPrice());
                orderItems.add(oi);
            }
            order.setTotalAmount(total);
            order.setItems(orderItems);

            boolean success = orderDAO.placeOrder(order);
            if (success) {
                // Clear cart after placing order
                CartDAO.clearCartForUser(loggedUser.getEmail());
                response.sendRedirect("order-history.jsp");
            } else {
                session.setAttribute("orderError", "Something went wrong. Try again.");
                response.sendRedirect("cart.jsp");
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
