<%@ page import="model.User"%>
<%
    User loggedUser = (User) session.getAttribute("user");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">?? E-Shop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="product-details.jsp">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="order-history.jsp">Orders</a></li>
                <% if(loggedUser != null){ %>
                <li class="nav-item"><span class="navbar-text mx-2">Welcome, <%=loggedUser.getName()%></span></li>
                <li class="nav-item">
                    <form action="logout.jsp" method="post">
                        <button class="btn btn-danger btn-sm">Logout</button>
                    </form>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
