<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.User"%>
<%@ page import="model.CartItem"%>
<%@ page import="dao.CartDAO"%>

<%
    User loggedUser = (User) session.getAttribute("user");
    if(loggedUser == null){ response.sendRedirect("login.jsp"); return; }

    List<CartItem> cart = CartDAO.getCartItemsForUser(loggedUser.getEmail());
    double total = 0.0;
    for (CartItem item : cart) { total += item.getPrice() * item.getQuantity(); }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Cart | E-Shop</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Poppins',sans-serif; background:#f8f9fb; padding:2rem; }
        header, footer { background:#2c3e50; color:white; padding:1rem 2rem; display:flex; align-items:center; justify-content:space-between; }
        header nav a, footer a { color:white; margin-left:1rem; text-decoration:none; }
        .container { max-width:1000px; margin:auto; background:white; padding:2rem; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1);}
        h2 { text-align:center; margin-bottom:2rem; }
        table { width:100%; border-collapse: collapse; }
        th, td { padding:1rem; text-align:center; border-bottom:1px solid #ddd; }
        th { background:#6c5ce7; color:white; }
        img { width:80px; height:80px; object-fit:cover; border-radius:5px; }
        .update-btn, .remove-btn, .checkout-btn { padding:0.5rem 1rem; border:none; border-radius:5px; cursor:pointer; font-weight:500; }
        .update-btn { background:#3498db; color:#fff; }
        .remove-btn { background:#e74c3c; color:#fff; }
        .checkout-btn { background:#27ae60; color:#fff; margin-top:1rem; width:100%; font-size:1rem; }
        .update-btn:hover { background:#2980b9; }
        .remove-btn:hover { background:#c0392b; }
        .checkout-btn:hover { background:#1e8449; }
        @media(max-width:768px){ table, th, td { font-size:14px; } }
    </style>
</head>
<body>
<header>
    <h1>🛍️ E-Shop</h1>
    <nav>
        <a href="home.jsp"><i class="bi bi-house"></i> Home</a>
        <a href="product-details.jsp"><i class="bi bi-grid"></i> Products</a>
        <a href="order-history.jsp"><i class="bi bi-clock-history"></i> Orders</a>
    </nav>
    <div class="user-info">
        <span>Welcome, <strong><%= loggedUser.getName() %></strong></span>
        <form action="logout.jsp" method="post" style="display:inline;">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</header>

<div class="container">
<%
    if(cart.isEmpty()){
%>
    <p>Your cart is empty. <a href="home.jsp">Go shopping!</a></p>
<%
    } else {
%>
    <form action="UpdateCartServlet" method="post">
        <table>
            <tr>
                <th>Product</th>
                <th>Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>
<%
        for(CartItem item : cart){
%>
            <tr>
                <td><img src="<%= request.getContextPath() + "/" + item.getImageUrl() %>" /></td>
                <td><%= item.getProductName() %></td>
                <td>₹<%= String.format("%.2f", item.getPrice()) %></td>
                <td><input type="number" name="quantity_<%=item.getProductId()%>" value="<%=item.getQuantity()%>" min="1" style="width:60px;"></td>
                <td>₹<%= String.format("%.2f", item.getPrice()*item.getQuantity()) %></td>
                <td><a class="remove-btn" href="RemoveFromCartServlet?product_id=<%=item.getProductId()%>">Remove</a></td>
            </tr>
<%
        }
%>
            <tr>
                <td colspan="4" style="text-align:right;font-weight:bold;">Total:</td>
                <td colspan="2">₹<%= String.format("%.2f", total) %></td>
            </tr>
        </table>
        <button type="submit" class="update-btn">Update Cart</button>
    </form>

    <form action="checkout.jsp" method="get">
        <button type="submit" class="checkout-btn">Proceed to Checkout</button>
    </form>
<%
    }
%>
</div>

<footer>
    &copy; <%= java.time.Year.now() %> E-Shop
</footer>
</body>
</html>
