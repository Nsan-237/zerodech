<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Login</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<div class="auth-page">
    <div class="form-card">
        <div class="auth-logo">
            <h2>🌿 Zerodech</h2>
            <p>Welcome! Log in to your account.</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="error-box">⚠️ <%= error %></div>
        <% } %>

        <%
            String success = (String) request.getAttribute("success");
            if (success != null) {
        %>
        <div class="success-box">✅ <%= success %></div>
        <% } %>

        <form id="loginForm" action="login" method="post" novalidate>

            <div class="form-group">
                <label for="loginEmail">Email address</label>
                <input type="email" id="loginEmail" name="email"
                       placeholder="example@email.com"
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                       autocomplete="email">
            </div>

            <div class="form-group">
                <label for="loginPassword">Password</label>
                <input type="password" id="loginPassword" name="password"
                       placeholder="••••••••"
                       autocomplete="current-password">
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="margin-top:.5rem;">
                Login
            </button>
        </form>

        <div class="divider"></div>
        <p style="text-align:center;font-size:.9rem;color:var(--text-mid);">
            Don't have an account yet? <a href="register.jsp">Register</a>
        </p>
    </div>
</div>
<script src="js/validation.js"></script>
</body>
</html>
