<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.User"%>
<%@ page import="model.Product"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="java.util.List"%>

<%
    User loggedUser = (User) session.getAttribute("user");
    if(loggedUser == null){ response.sendRedirect("login.jsp"); return; }

    List<Product> products = ProductDAO.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
    <title>E-Shop | Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        :root {
            --primary: #6c5ce7;
            --primary-dark: #4834d4;
            --accent: #f39c12;
            --bg-gradient: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
        }
        * { box-sizing: border-box; margin:0; padding:0; }
        body { font-family: 'Poppins', sans-serif; background: var(--bg-gradient); min-height:100vh; }

        /* Navbar */
        header {
            position: sticky; top:0; background:#2c3e50; color:#fff;
            display:flex; justify-content:space-between; align-items:center; padding:1rem 2rem; z-index:100;
        }
        header h1 { font-size:1.8rem; }
        nav a { color:#fff; margin-left:1.2rem; text-decoration:none; font-weight:500; transition: opacity 0.2s ease; }
        nav a:hover { opacity:0.7; }
        .user-info { display:flex; align-items:center; }
        .user-info span { margin-right:1rem; }
        .logout-btn { background:#e74c3c; color:white; padding:0.4rem 0.8rem; border:none; border-radius:4px; cursor:pointer; font-weight:500; }

        /* Products grid */
        .container { display:grid; grid-template-columns: repeat(auto-fit, minmax(250px,1fr)); gap:1.5rem; padding:2rem; max-width:1300px; margin:auto; }
        .product { background:#fff; border-radius:16px; overflow:hidden; box-shadow:0 4px 12px rgba(0,0,0,0.05); transition: transform .3s ease, box-shadow .3s ease; display:flex; flex-direction:column; align-items:center; }
        .product:hover { transform: translateY(-6px); box-shadow:0 10px 25px rgba(0,0,0,0.15); }
        .product img { width:100%; height:200px; object-fit:cover; transition: transform .3s ease; }
        .product img:hover { transform: scale(1.05); }
        .product-info { padding:1rem; text-align:center; flex:1; display:flex; flex-direction:column; justify-content:space-between; }
        .product-info h4 { margin:0.5rem 0; font-size:1.1rem; }
        .price { color: var(--primary); font-weight:600; margin-bottom:0.8rem; }
        .details-btn, .add-to-cart-btn { display:inline-block; padding:0.5rem 1rem; border-radius:6px; text-decoration:none; font-weight:500; cursor:pointer; margin:0.3rem; transition: background 0.3s ease; }
        .details-btn { background: var(--primary); color:#fff; }
        .details-btn:hover { background: var(--primary-dark); }
        .add-to-cart-btn { background: var(--accent); color:#fff; border:none; }
        .add-to-cart-btn:hover { background:#d68910; }

        footer { background:#2c3e50; color:#fff; text-align:center; padding:1.5rem; margin-top:2rem; }
        footer a { color:#fff; margin:0 .5rem; text-decoration:none; font-size:1.2rem; }

        @media(max-width:768px) { header { flex-direction: column; align-items:flex-start; } nav { margin-top:0.5rem; } }
    </style>
</head>
<body>

<header>
    <h1>🛍️ E-Shop</h1>
    <nav>
        <a href="home.jsp"><i class="bi bi-house"></i> Home</a>
        <a href="cart.jsp"><i class="bi bi-cart"></i> Cart</a>
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
    for(Product p : products){
%>
    <div class="product">
        <img src="<%= request.getContextPath() + "/" + p.getImageUrl() %>" alt="<%= p.getName() %>">
        <div class="product-info">
            <h4><%= p.getName() %></h4>
            <p class="price">₹<%= String.format("%.2f", p.getPrice()) %></p>
            <a href="product-details.jsp?id=<%=p.getId()%>" class="details-btn">View Details</a>
            <form action="AddToCartServlet" method="post">
                <input type="hidden" name="productId" value="<%= p.getId() %>">
                <input type="hidden" name="quantity" value="1">
                <button type="submit" class="add-to-cart-btn">
                    <i class="bi bi-cart-plus"></i> Add to Cart
                </button>
            </form>
        </div>
    </div>
<% } %>
</div>

<footer>
    &copy; <%= java.time.Year.now() %> E-Shop
</footer>

</body>
</html>
