<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User, com.zerodech.model.Pickup, com.zerodech.dao.UserDAO, com.zerodech.dao.PickupDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    UserDAO userDAO = new UserDAO();
    PickupDAO pickupDAO = new PickupDAO();
    
    int totalClients = userDAO.countByRole("CLIENT");
    int totalCollectors = userDAO.countByRole("COLLECTOR");
    int totalPickups = pickupDAO.countAll();
    int pendingPickupsCount = pickupDAO.countByStatus("PENDING");
    
    List<Pickup> allPickups = pickupDAO.getAllPickups();
    List<User> allCollectors = userDAO.getAllCollectors();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Admin Dashboard</title>
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">🌿 Zero<span>dech</span></div>
        <ul class="navbar-nav">
            <li><span class="navbar-user">Admin: <%= user.getFullName() %></span></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav" style="background:var(--danger)">Logout</a></li>
        </ul>
    </nav>
    <div class="page-wrapper">
        <div class="page-header">
            <h1>Admin Dashboard</h1>
            <p>System overview and request management.</p>
        </div>
        
        <div class="card-grid" style="margin-bottom: 2rem;">
            <div class="stat-card">
                <span class="stat-label">Total Clients</span>
                <span class="stat-value"><%= totalClients %></span>
            </div>
            <div class="stat-card accent">
                <span class="stat-label">Total Collectors</span>
                <span class="stat-value"><%= totalCollectors %></span>
            </div>
            <div class="stat-card info">
                <span class="stat-label">Total Pickups</span>
                <span class="stat-value"><%= totalPickups %></span>
            </div>
            <div class="stat-card danger">
                <span class="stat-label">Pending Requests</span>
                <span class="stat-value"><%= pendingPickupsCount %></span>
            </div>
        </div>
        
        <h2 class="section-title">Recent Pickup Requests</h2>
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Client</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Collector / Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (allPickups == null || allPickups.isEmpty()) { %>
                        <tr><td colspan="6" class="empty-state">No pickups found.</td></tr>
                    <% } else {
                        for (Pickup p : allPickups) { %>
                        <tr>
                            <td>#<%= p.getId() %></td>
                            <td><%= p.getClientName() %></td>
                            <td><%= p.getLocation() %></td>
                            <td><%= p.getPickupDate() %></td>
                            <td><span class="badge badge-<%= p.getStatus().toLowerCase() %>"><%= p.getStatus() %></span></td>
                            <td>
                                <% if ("PENDING".equals(p.getStatus())) { %>
                                    <form action="assign-collector" method="POST" class="inline-form">
                                        <input type="hidden" name="pickupId" value="<%= p.getId() %>">
                                        <select name="collectorId" required>
                                            <option value="">- Assign Collector -</option>
                                            <% for (User c : allCollectors) { %>
                                                <option value="<%= c.getId() %>"><%= c.getFullName() %></option>
                                            <% } %>
                                        </select>
                                        <button type="submit" class="btn btn-primary btn-sm">Assign</button>
                                    </form>
                                <% } else { %>
                                    <strong><%= p.getCollectorName() != null ? p.getCollectorName() : "Unassigned" %></strong>
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