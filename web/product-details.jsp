<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.User"%>
<%@ page import="model.Product"%>
<%@ page import="dao.ProductDAO"%>

<%
    User loggedUser = (User) session.getAttribute("user");
    if(loggedUser == null){ response.sendRedirect("login.jsp"); return; }

    List<Product> products = ProductDAO.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Products | E-Shop</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Poppins',sans-serif; background:#e0f7fa; padding:2rem; margin:0;}
        header, footer { background:#2c3e50; color:white; padding:1rem 2rem; display:flex; justify-content:space-between; align-items:center; }
        header nav a, footer a { color:white; margin-left:1rem; text-decoration:none; }
        h2 { text-align:center; margin-bottom:2rem; }

        .container { display:grid; grid-template-columns: repeat(auto-fit,minmax(250px,1fr)); gap:1.5rem; max-width:1300px; margin:auto; }
        .product { background:white; border-radius:12px; padding:1rem; box-shadow:0 4px 12px rgba(0,0,0,0.1); display:flex; flex-direction:column; align-items:center; transition: transform .3s ease; }
        .product:hover { transform: translateY(-5px); box-shadow:0 10px 25px rgba(0,0,0,0.15);}
        .product img { width:100%; height:180px; object-fit:cover; border-radius:8px; transition: transform .3s ease; }
        .product img:hover { transform: scale(1.05);}
        .product h4 { margin:0.5rem 0; }
        .price { color:#3498db; font-weight:600; }
        .add-to-cart-btn { background:#f39c12; color:white; border:none; padding:0.5rem 1rem; border-radius:6px; cursor:pointer; margin-top:0.5rem; transition: background .3s; }
        .add-to-cart-btn:hover { background:#d68910; }
        @media(max-width:768px){ .product { font-size:14px; } }
    </style>
</head>
<body>
<header>
    <h1>🛍️ E-Shop</h1>
    <nav>
        <a href="home.jsp"><i class="bi bi-house"></i> Home</a>
        <a href="cart.jsp"><i class="bi bi-cart"></i> Cart</a>
        <a href="order-history.jsp"><i class="bi bi-clock-history"></i> Orders</a>
    </nav>
    <div class="user-info">
        <span>Welcome, <strong><%= loggedUser.getName() %></strong></span>
        <form action="logout.jsp" method="post" style="display:inline;">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</header>

<h2>All Products</h2>
<div class="container">
<%
    for(Product p : products){
%>
    <div class="product">
        <img src="<%= request.getContextPath() + "/" + p.getImageUrl() %>" alt="<%=p.getName()%>">
        <h4><%= p.getName() %></h4>
        <p class="price">₹<%= String.format("%.2f",p.getPrice()) %></p>
        <form action="AddToCartServlet" method="post">
            <input type="hidden" name="productId" value="<%=p.getId()%>">
            <input type="hidden" name="quantity" value="1">
            <button type="submit" class="add-to-cart-btn"><i class="bi bi-cart-plus"></i> Add to Cart</button>
        </form>
    </div>
<% } %>
</div>

<footer>
    &copy; <%= java.time.Year.now() %> E-Shop
</footer>
</body>
</html>
