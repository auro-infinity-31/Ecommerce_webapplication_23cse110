<%@page import="model.Order"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    
    User admin = (User) session.getAttribute("user");
    if(admin == null || !"admin".equals(admin.getRole())) {
        // Redirect to login if not admin
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return; // Stop the rest of the page from rendering
    }

    // Optionally, prevent browser caching (important after logout)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);


    // Dummy values; populate from DB in a servlet before forwarding:
    Integer totalProducts = (Integer)request.getAttribute("totalProducts");
    Integer totalOrders   = (Integer)request.getAttribute("totalOrders");
    Integer totalUsers    = (Integer)request.getAttribute("totalUsers");
    if(totalProducts==null) totalProducts=87;
    if(totalOrders==null) totalOrders=241;
    if(totalUsers==null) totalUsers=63;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-logo">🛍️ E-Shop Admin</div>
        <ul>
            <li><a href="admin.jsp" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="admin/products.jsp"><i class="fas fa-box"></i> Products</a></li>
            <li><a href="admin/orders.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="admin/users.jsp"><i class="fas fa-users"></i> Users</a></li>
            <li><a href="admin/reports.jsp"><i class="fas fa-chart-line"></i> Reports</a></li>
            <li><a href="LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <div class="main">
        <header class="topbar">
            <h1>Dashboard</h1>
            <div class="admin-info">
                <span><i class="fas fa-user-circle"></i> <%=admin.getName()%></span>
            </div>
        </header>

        <section class="stats-grid">
            <div class="stat-card blue">
                <div class="icon"><i class="fas fa-box"></i></div>
                <div class="details">
                    <h3><%= totalProducts %></h3>
                    <p>Products</p>
                </div>
            </div>
            <div class="stat-card green">
                <div class="icon"><i class="fas fa-shopping-cart"></i></div>
                <div class="details">
                    <h3><%= totalOrders %></h3>
                    <p>Orders</p>
                </div>
            </div>
            <div class="stat-card orange">
                <div class="icon"><i class="fas fa-users"></i></div>
                <div class="details">
                    <h3><%= totalUsers %></h3>
                    <p>Users</p>
                </div>
            </div>
        </section>

        <section class="cards-grid">
            <div class="feature-card">
                <h2>Manage Products</h2>
                <p>Add, edit, and remove items from the catalog.</p>
                <a href="admin/products.jsp">Open</a>
            </div>
            <div class="feature-card">
                <h2>Manage Orders</h2>
                <p>Track and update customer orders.</p>
                <a href="admin/orders.jsp">Open</a>
            </div>
            <div class="feature-card">
                <h2>Manage Users</h2>
                <p>View and manage registered customers.</p>
                <a href="admin/users.jsp">Open</a>
            </div>
            <div class="feature-card">
                <h2>Reports</h2>
                <p>View insights &amp; sales analytics.</p>
                <a href="admin/reports.jsp">Open</a>
            </div>
        </section>
    </div>
</body>
</html>
