<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CLIENT".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Client Dashboard</title>
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">🌿 Zero<span>dech</span></div>
        <ul class="navbar-nav">
            <li><span class="navbar-user">Hello, <%= user.getFullName() %></span></li>
            <li><a href="client-dashboard.jsp">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav" style="background:var(--danger)">Logout</a></li>
        </ul>
    </nav>
    <div class="page-wrapper">
        <div class="page-header">
            <h1>Welcome, <%= user.getFullName() %>!</h1>
            <p>Manage your waste collection requests and subscriptions.</p>
        </div>
        <div class="card-grid">
            <a href="request-pickup.jsp" class="action-card">
                <div class="icon">🚛</div>
                <h3>Request Pickup</h3>
                <p>Schedule a new waste collection at your preferred time.</p>
            </a>
            <a href="my-requests.jsp" class="action-card">
                <div class="icon">📅</div>
                <h3>My Requests</h3>
                <p>View the status of your current and past pickups.</p>
            </a>
            <a href="subscription-plans.jsp" class="action-card">
                <div class="icon">💳</div>
                <h3>Subscriptions</h3>
                <p>View and manage your waste collection subscription plans.</p>
            </a>
            <a href="payment.jsp" class="action-card">
                <div class="icon">💸</div>
                <h3>Make Payment</h3>
                <p>Pay for pickups or subscriptions securely.</p>
            </a>
        </div>
    </div>
</body>
</html>