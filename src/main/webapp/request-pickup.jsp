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
    <title>Zerodech — Request Pickup</title>
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="js/validation.js" defer></script>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">🌿 Zero<span>dech</span></div>
        <ul class="navbar-nav">
            <li><a href="client-dashboard.jsp">Dashboard</a></li>
            <li><span class="navbar-user"><%= user.getFullName() %></span></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav" style="background:var(--danger)">Logout</a></li>
        </ul>
    </nav>
    <div class="page-wrapper">
        <div class="page-header">
            <a href="client-dashboard.jsp" style="font-size: 0.9rem; margin-bottom: 1rem; display: inline-block;">&larr; Back to Dashboard</a>
            <h1>Request a Pickup</h1>
            <p>Schedule a waste collection at your preferred time.</p>
        </div>
        
        <div class="form-card wide">
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-box"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-box"><%= request.getAttribute("success") %></div>
            <% } %>
            <form action="pickup" method="POST" id="pickupForm">
                <div class="form-row">
                    <div class="form-group">
                        <label>Pickup Date *</label>
                        <input type="date" name="pickupDate" required>
                    </div>
                    <div class="form-group">
                        <label>Waste Type *</label>
                        <select name="wasteType" required>
                            <option value="">- Select Type -</option>
                            <option value="Mixed">Mixed Waste</option>
                            <option value="Recyclable">Recyclable (Plastic/Paper)</option>
                            <option value="Organic">Organic (Food Waste)</option>
                            <option value="Hazardous">Hazardous / Electronic</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Pickup Location Address *</label>
                    <input type="text" name="location" placeholder="e.g., Bonamoussadi, Douala" value="<%= user.getAddress() != null ? user.getAddress() : "" %>" required>
                    <span class="form-hint">Confirm or update your address for this pickup.</span>
                </div>
                
                <div class="form-group">
                    <label>Additional Notes (Optional)</label>
                    <textarea name="notes" placeholder="Any special instructions for the collector?"></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block">Submit Pickup Request</button>
            </form>
        </div>
    </div>
</body>
</html>