<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.User"%>
<%
    User loggedUser = (User) session.getAttribute("user");
    if(loggedUser == null){ response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout | E-Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        // Redirect to cart if user closes page after 15 seconds
        setTimeout(function(){
            window.location.href = "cart.jsp";
        }, 15000);
    </script>
</head>
<body>
<div class="container my-5">
    <div class="card mx-auto" style="max-width:500px;">
        <div class="card-body text-center">
            <h2 class="card-title mb-4">Confirm Order</h2>
            <form action="PlaceOrderServlet" method="post">
                <button type="submit" class="btn btn-success w-100">Confirm Order</button>
            </form>
            <p class="text-muted mt-3">You will be redirected to your cart automatically if this page is inactive for 15 seconds.</p>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
