<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Create an account</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<div class="auth-page">
    <div class="form-card wide">
        <div class="auth-logo">
            <h2>🌿 Zerodech</h2>
            <p>Create your account and join our network.</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="error-box">⚠️ <%= error %></div>
        <% } %>

        <form id="registerForm" action="register" method="post" novalidate>

            <div class="form-row">
                <div class="form-group">
                    <label for="regName">Full Name *</label>
                    <input type="text" id="regName" name="fullName"
                           placeholder="John Doe" required>
                </div>
                <div class="form-group">
                    <label for="regPhone">Phone</label>
                    <input type="tel" id="regPhone" name="phone"
                           placeholder="+237 6XX XXX XXX">
                </div>
            </div>

            <div class="form-group">
                <label for="regEmail">Email Address *</label>
                <input type="email" id="regEmail" name="email"
                       placeholder="example@email.com" required autocomplete="email">
            </div>

            <div class="form-group">
                <label for="regPassword">Password *</label>
                <input type="password" id="regPassword" name="password"
                       placeholder="Minimum 6 characters" required autocomplete="new-password">
                <span class="form-hint">At least 6 characters.</span>
            </div>

            <div class="form-group">
                <label for="regRole">Account Type *</label>
                <select id="regRole" name="role" required>
                    <option value="CLIENT">Client — I want my waste collected</option>
                    <option value="COLLECTOR">Collector — I collect waste</option>
                </select>
            </div>

            <div class="form-group">
                <label for="regAddress">Address / Neighborhood</label>
                <input type="text" id="regAddress" name="address"
                       placeholder="Douala Akwa, Cameroon">
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="margin-top:.5rem;">
                Create my account
            </button>
        </form>

        <div class="divider"></div>
        <p style="text-align:center;font-size:.9rem;color:var(--text-mid);">
            Already registered? <a href="login.jsp">Login</a>
        </p>
    </div>
</div>
<script src="js/validation.js"></script>
</body>
</html>