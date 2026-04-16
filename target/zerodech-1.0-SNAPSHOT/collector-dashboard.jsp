<%-- 
    Document   : collector-dashboard
    Created on : Apr 8, 2026, 12:17:21 PM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - Collector Dashboard</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <h2>Collector Dashboard</h2>
    <p>Welcome, <%= user.getFullName() %></p>
    <p>Role: <%= user.getRole() %></p>

    <a href="feedback.jsp">Add Feedback</a><br><br>
</body>
</html>