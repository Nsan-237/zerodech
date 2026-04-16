<%-- 
    Document   : payment
    Created on : Apr 8, 2026, 12:36:19 PM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - Payment</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <h2>Make Payment</h2>
    <form action="payment" method="post">
        <label>Amount:</label><br>
        <input type="number" name="amount" step="0.01" required><br><br>

        <label>Payment Method:</label><br>
        <input type="text" name="paymentMethod" required><br><br>

        <label>Pickup ID:</label><br>
        <input type="number" name="pickupId" required><br><br>

        <button type="submit">Pay</button>
    </form>
</body>
</html>