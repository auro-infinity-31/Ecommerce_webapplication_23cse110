<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User, dao.AdminDAO, model.Product, java.util.List" %>
<%
    // Admin session check
    User admin = (User) session.getAttribute("user");
    if(admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    AdminDAO dao = new AdminDAO();
    List<Product> products = dao.getAllProducts();

    String success = request.getParameter("success");
    String error   = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Products</title>
    <link rel="stylesheet" href="../css/admin.css">
    <link rel="stylesheet" href="../css/tables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo">🛍️ E-Shop Admin</div>
    <ul>
        <li><a href="../adminDashboard"><i class="fas fa-home"></i> Dashboard</a></li>
        <li><a href="products.jsp" class="active"><i class="fas fa-box"></i> Products</a></li>
        <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
        <li><a href="users.jsp"><i class="fas fa-users"></i> Users</a></li>
        <li><a href="reports.jsp"><i class="fas fa-chart-line"></i> Reports</a></li>
        <li><a href="../LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</aside>

<div class="main">
    <header class="topbar">
        <h1>Products</h1>
        <div class="admin-info">
            <span><i class="fas fa-user-circle"></i> <%= admin.getName() %></span>
        </div>
    </header>

    <div class="container" style="margin:2rem;">
        <!-- Messages -->
        <% if(success != null) { %>
            <div style="padding:10px;background:#00b894;color:white;border-radius:6px;margin-bottom:1rem;">
                <%= success %>
            </div>
        <% } %>
        <% if(error != null) { %>
            <div style="padding:10px;background:#d63031;color:white;border-radius:6px;margin-bottom:1rem;">
                <%= error %>
            </div>
        <% } %>

        <!-- Add Product Form -->
        <h2>Add Product</h2>
        <form action="../AddProductServlet" method="post" enctype="multipart/form-data" style="margin-bottom:2rem; display:flex; gap:1rem; flex-wrap:wrap;">
            <input type="text" name="name" placeholder="Product Name" required style="flex:1; padding:0.5rem;">
            <input type="number" step="0.01" name="price" placeholder="Price" required style="flex:1; padding:0.5rem;">
            <input type="file" name="image" accept="image/*" required style="flex:1; padding:0.5rem;">
            <button type="submit" class="btn" style="flex:0 0 150px;">Add</button>
        </form>

        <!-- Products Table -->
        <div class="table-container">
            <table class="styled-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Product p : products) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getName() %></td>
                        <td>$<%= p.getPrice() %></td>
                        <td>
                            <img src="<%= request.getContextPath() + "/" + p.getImageUrl() %>" 
                                 alt="Product Image" 
                                 style="width:60px;height:60px;object-fit:cover;border-radius:6px;">
                        </td>
                        <td>
                            <form action="../DeleteProductServlet" method="post" style="margin:0;">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <button type="submit" class="btn" style="background:#d63031;">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
