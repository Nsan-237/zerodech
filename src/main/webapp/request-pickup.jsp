<%-- 
    Document   : request-pickup
    Created on : Apr 8, 2026, 12:34:51 PM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - Request Pickup</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <h2>Request Pickup</h2>
    <form action="pickup" method="post">
        <label>Pickup Date:</label><br>
        <input type="date" name="pickupDate" required><br><br>

        <label>Location:</label><br>
        <input type="text" name="location" required><br><br>

        <button type="submit">Submit Pickup Request</button>
    </form>
</body>
</html>