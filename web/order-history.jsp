<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.User"%>
<%@ page import="model.Order"%>
<%@ page import="dao.OrderDAO"%>
<%@ page import="dao.DBConnection"%>
<%@ page import="java.util.List"%>

<%
    User loggedUser = (User) session.getAttribute("user");
    if(loggedUser == null){ response.sendRedirect("login.jsp"); return; }

    OrderDAO orderDAO = new OrderDAO(DBConnection.getConnection());
    List<Order> orders = orderDAO.getOrdersByUser(loggedUser.getEmail());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order History | E-Shop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body { font-family:'Poppins',sans-serif; background:#f9f9f9; padding:2rem; margin:0; }
        header, footer { background:#2c3e50; color:white; padding:1rem 2rem; display:flex; justify-content:space-between; align-items:center; }
        header nav a, footer a { color:white; margin-left:1rem; text-decoration:none; }
        h2 { text-align:center; margin-bottom:2rem; }
        table { width:90%; margin:auto; background:white; border-collapse: collapse; border-radius:8px; overflow:hidden; box-shadow:0 5px 15px rgba(0,0,0,0.1);}
        th, td { padding:1rem; text-align:center; border-bottom:1px solid #eee; }
        th { background:#6c5ce7; color:white; }
        tr:hover { background:#f1f1f1; transition:0.3s; }
        .status-pending { color:#f39c12; font-weight:600; }
        .status-delivered { color:#27ae60; font-weight:600; }
        @media(max-width:768px){ table, th, td { font-size:14px; } }
    </style>
</head>
<body>
<header>
    <h1>🛍️ E-Shop</h1>
    <nav>
        <a href="home.jsp"><i class="bi bi-house"></i> Home</a>
        <a href="cart.jsp"><i class="bi bi-cart"></i> Cart</a>
        <a href="product-details.jsp"><i class="bi bi-grid"></i> Products</a>
    </nav>
    <div class="user-info">
        <span>Welcome, <strong><%= loggedUser.getName() %></strong></span>
        <form action="logout.jsp" method="post" style="display:inline;">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</header>

<h2>Your Order History</h2>
<table>
    <tr>
        <th>Order ID</th>
        <th>Date</th>
        <th>Total (₹)</th>
        <th>Status</th>
    </tr>
<%
    if(orders.isEmpty()){
%>
    <tr><td colspan="4">No orders found.</td></tr>
<%
    } else {
        for(Order o : orders){
%>
    <tr>
        <td>#<%=o.getId()%></td>
        <td><%=o.getOrderDate()%></td>
        <td>₹<%= String.format("%.2f", o.getTotalAmount()) %></td>
        <td class="<%= o.getStatus().equalsIgnoreCase("Pending") ? "status-pending" : "status-delivered" %>">
            <%= o.getStatus() %>
        </td>
    </tr>
<%
        }
    }
%>
</table>

<footer>
    &copy; <%= java.time.Year.now() %> E-Shop
</footer>
</body>
</html>
