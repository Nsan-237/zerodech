<%-- 
    Document   : login
    Created on : Apr 8, 2026, 11:59:39 AM
    Author     : Administrator
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zerodech - Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="login" method="post">
        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button type="submit">Login</button>
    </form>

    <br>
    <a href="register.jsp">Create Account</a>
</body>
</html>
