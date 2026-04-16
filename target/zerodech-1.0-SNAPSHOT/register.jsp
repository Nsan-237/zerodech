<%-- 
    Document   : register
    Created on : Apr 8, 2026, 12:03:18 PM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - Register</title>
</head>
<body>
    <h2>Create Account</h2>
    <form action="register" method="post">
        <label>Full Name:</label><br>
        <input type="text" name="fullName" required><br><br>

        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <label>Role:</label><br>
        <select name="role" required>
            <option value="CLIENT">Client</option>
            <option value="COLLECTOR">Collector</option>
            <option value="ADMIN">Admin</option>
        </select><br><br>

        <label>Phone:</label><br>
        <input type="text" name="phone"><br><br>

        <label>Address:</label><br>
        <input type="text" name="address"><br><br>

        <button type="submit">Register</button>
    </form>

    <br>
    <a href="login.jsp">Back to Login</a>
</body>
</html>