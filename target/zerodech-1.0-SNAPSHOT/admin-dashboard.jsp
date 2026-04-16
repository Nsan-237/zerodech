<%-- 
    Document   : admin-dashboard
    Created on : Apr 8, 2026, 12:27:13 PM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - Admin Dashboard</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <h2>Admin Dashboard</h2>
    <p>Welcome, <%= user.getFullName() %></p>
    <p>Role: <%= user.getRole() %></p>

    <p>Admin can monitor users, pickups, payments, and collectors.</p>
</body>
</html>