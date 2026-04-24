<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User, com.zerodech.model.Pickup, com.zerodech.dao.PickupDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CLIENT".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    PickupDAO pickupDAO = new PickupDAO();
    List<Pickup> myPickups = pickupDAO.getPickupsByClient(user.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — My Requests</title>
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
            <h1>My Pickup Requests</h1>
            <p>Track the status of your past and upcoming waste collections.</p>
        </div>
        
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Pickup ID</th>
                        <th>Type</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Collector</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (myPickups == null || myPickups.isEmpty()) { %>
                        <tr><td colspan="7" class="empty-state">You have no pickup requests yet. <a href="request-pickup.jsp">Request one now!</a></td></tr>
                    <% } else {
                        for (Pickup p : myPickups) { %>
                        <tr>
                            <td>#<%= p.getId() %></td>
                            <td><%= p.getWasteType() %></td>
                            <td><%= p.getLocation() %></td>
                            <td><%= p.getPickupDate() %></td>
                            <td><span class="badge badge-<%= p.getStatus().toLowerCase() %>"><%= p.getStatus() %></span></td>
                            <td><%= p.getCollectorName() != null ? p.getCollectorName() : "Unassigned" %></td>
                            <td>
                                <% if ("COMPLETED".equals(p.getStatus())) { %>
                                    <a href="feedback.jsp?pickupId=<%= p.getId() %>" class="btn btn-outline btn-sm">Leave Feedback</a>
                                <% } else { %>
                                    <a href="payment.jsp?pickupId=<%= p.getId() %>" class="btn btn-primary btn-sm">Pay</a>
                                <% } %>
                            </td>
                        </tr>
                    <%  }
                    } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
