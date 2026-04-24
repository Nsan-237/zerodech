<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User, com.zerodech.model.SubscriptionPlan, com.zerodech.model.Subscription, com.zerodech.dao.SubscriptionDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CLIENT".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    SubscriptionDAO subDAO = new SubscriptionDAO();
    List<SubscriptionPlan> plans = subDAO.getAllPlans();
    Subscription activeSub = subDAO.getActiveSubscription(user.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Subscriptions</title>
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            <h1>Subscription Plans</h1>
            <p>Choose a plan that fits your waste management needs.</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-box"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-box"><%= request.getAttribute("success") %></div>
        <% } %>
        
        <% if (activeSub != null) { %>
            <div class="card" style="margin-bottom: 2rem; border-left: 5px solid var(--green-mid);">
                <h3 style="color:var(--green-dark); margin-bottom: 0.5rem;">Current Active Plan</h3>
                <p><strong><%= activeSub.getPlanName() %></strong> — valid until <%= activeSub.getEndDate() %></p>
            </div>
        <% } %>
        
        <div class="card-grid">
            <% if (plans != null) {
                for (SubscriptionPlan plan : plans) { 
                    boolean active = activeSub != null && activeSub.getPlanId() == plan.getId();
            %>
                <div class="plan-card <%= plan.getId() == 2 ? "featured" : "" %>">
                    <div class="plan-name"><%= plan.getName() %></div>
                    <div class="plan-price">XAF <%= plan.getPrice() %> <span>/ <%= plan.getDurationDays() %> days</span></div>
                    <p class="plan-desc"><%= plan.getDescription() %></p>
                    <form action="subscribe" method="POST">
                        <input type="hidden" name="planId" value="<%= plan.getId() %>">
                        <% if (active) { %>
                            <button type="button" class="btn btn-outline btn-block" disabled>Current Plan</button>
                        <% } else { %>
                            <button type="submit" class="btn btn-primary btn-block">Subscribe</button>
                        <% } %>
                    </form>
                </div>
            <%  } 
            } %>
        </div>
    </div>
</body>
</html>
