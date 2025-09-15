<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dao.AdminDAO, model.User, java.util.List" %>
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
    List<User> users = dao.getAllUsers();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Users</title>
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
        <li><a href="users.jsp" class="active"><i class="fas fa-users"></i> Users</a></li>
        <li><a href="reports.jsp"><i class="fas fa-chart-line"></i> Reports</a></li>
        <li><a href="../LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</aside>

<div class="main">
    <header class="topbar">
        <h1>Users</h1>
        <div class="admin-info">
            <span><i class="fas fa-user-circle"></i> <%=admin.getName()%></span>
        </div>
    </header>

    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Phone</th>
                    <th>Gender</th>
                    <th>Address</th>
                </tr>
            </thead>
            <tbody>
            <% for(User u: users) { %>
                <tr>
                    <td><%= u.getName() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getRole() %></td>
                    <td><%= u.getPhone() %></td>
                    <td><%= u.getGender() %></td>
                    <td><%= u.getAddress() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
