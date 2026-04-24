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
    <title>Zerodech — Add Feedback</title>
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
            <h1>Rate Our Service</h1>
            <p>Your feedback helps us improve your experience.</p>
        </div>
        
        <div class="form-card">
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-box"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-box"><%= request.getAttribute("success") %></div>
            <% } %>
            
            <form action="feedback" method="POST">
                <div class="form-group">
                    <label>Pickup ID</label>
                    <input type="number" name="pickupId" value="<%= pidValue %>" required>
                </div>
                
                <div class="form-group">
                    <label>Rating (1 to 5)</label>
                    <div class="star-rating" style="margin-top: 0.5rem;">
                        <input type="radio" id="star5" name="rating" value="5" required>
                        <label for="star5" title="5 stars">★</label>
                        <input type="radio" id="star4" name="rating" value="4">
                        <label for="star4" title="4 stars">★</label>
                        <input type="radio" id="star3" name="rating" value="3">
                        <label for="star3" title="3 stars">★</label>
                        <input type="radio" id="star2" name="rating" value="2">
                        <label for="star2" title="2 stars">★</label>
                        <input type="radio" id="star1" name="rating" value="1">
                        <label for="star1" title="1 star">★</label>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Comments</label>
                    <textarea name="comments" placeholder="Tell us about your experience..." required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block">Submit Feedback</button>
            </form>
        </div>
    </div>
</body>
</html>