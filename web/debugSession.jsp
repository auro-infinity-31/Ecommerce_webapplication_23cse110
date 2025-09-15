<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");
    if (loggedUser != null) {
%>
    <h3>Session User Details:</h3>
    <ul>
        <li>Name: <%= loggedUser.getName() %></li>
        <li>Email: <%= loggedUser.getEmail() %></li>
        <li>Phone: <%= loggedUser.getPhone() %></li>
        <li>Address: <%= loggedUser.getAddress() %></li>
        <li>Role: <%= loggedUser.getRole() %></li>
        <li>Gender: <%= loggedUser.getGender() %></li>
    </ul>
<%
    } else {
%>
    <p>No user is logged in. Session is empty.</p>
<%
    }
%>
