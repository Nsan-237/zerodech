<%-- 
    Document   : feedback
    Created on : Apr 8, 2026, 12:41:47 PM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - Feedback</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <h2>Add Feedback</h2>
    <form action="feedback" method="post">
        <label>Pickup ID:</label><br>
        <input type="number" name="pickupId" required><br><br>

        <label>Comments:</label><br>
        <textarea name="comments" required></textarea><br><br>

        <button type="submit">Submit Feedback</button>
    </form>
</body>
</html>