<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CLIENT".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    String pId = request.getParameter("pickupId");
    String pidValue = (pId != null) ? pId : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Payment</title>
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">🌿 Zero<span>dech</span></div>
        <ul class="navbar-nav">
            <li><a href="client-dashboard.jsp">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav" style="background:var(--danger)">Logout</a></li>
        </ul>
    </nav>
    <div class="page-wrapper">
        <div class="page-header text-center" style="margin-top: 2rem;">
            <h1>Make a Payment</h1>
            <p>Securely pay for your pickup request.</p>
        </div>
        
        <div class="form-card">
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-box"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-box"><%= request.getAttribute("success") %></div>
            <% } %>
            
            <form action="payment" method="POST">
                <div class="form-group">
                    <label>Amount (XAF)</label>
                    <input type="number" name="amount" step="1" placeholder="e.g. 5000" required>
                </div>
                
                <div class="form-group">
                    <label>Pickup ID</label>
                    <input type="number" name="pickupId" value="<%= pidValue %>" required>
                </div>
                
                <div class="form-group">
                    <label>Payment Method</label>
                    <select name="paymentMethod" required>
                        <option value="">- Select Method -</option>
                        <option value="Mobile Money (MTN)">Mobile Money (MTN)</option>
                        <option value="Orange Money">Orange Money</option>
                        <option value="Credit Card">Credit Card</option>
                        <option value="Cash">Cash on Pickup</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-success btn-block">Confirm Payment</button>
            </form>
        </div>
    </div>
</body>
</html>