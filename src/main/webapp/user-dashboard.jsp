<%-- 
    Document   : user-dashboard
    Created on : Apr 8, 2026, 12:14:55 PM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - User Dashboard</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <h2>User Dashboard</h2>
    <p>Welcome, <%= user.getFullName() %></p>
    <p>Role: <%= user.getRole() %></p>

    <a href="request-pickup.jsp">Request Pickup</a><br><br>
    <a href="payment.jsp">Make Payment</a><br><br>
</body>
</html>