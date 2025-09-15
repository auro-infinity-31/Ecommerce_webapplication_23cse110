<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dao.AdminDAO, java.util.List, model.Order" %>
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

    AdminDAO dao = new AdminDAO();
    List<Order> orders = dao.getAllOrders();
    double totalSales = 0;
    for(Order o: orders){ totalSales += o.getTotalAmount(); }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Reports</title>
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="../css/tables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo">🛍️ E-Shop Admin</div>
    <ul>
        <li><a href="../adminDashboard"><i class="fas fa-home"></i> Dashboard</a></li>
        <li><a href="products.jsp"><i class="fas fa-box"></i> Products</a></li>
        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
        <li><a href="users.jsp"><i class="fas fa-users"></i> Users</a></li>
        <li><a href="reports.jsp" class="active"><i class="fas fa-chart-line"></i> Reports</a></li>
        <li><a href="../LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</aside>

<div class="main">
    <header class="topbar">
        <h1>Reports</h1>
        <div class="admin-info">
            <span><i class="fas fa-user-circle"></i> <%=admin.getName()%></span>
        </div>
    </header>

    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Total Orders</th>
                    <th>Total Sales ($)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= orders.size() %></td>
                    <td><%= totalSales %></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
