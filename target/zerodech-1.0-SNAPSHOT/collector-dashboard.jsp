<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.zerodech.model.User, com.zerodech.model.Pickup, com.zerodech.dao.PickupDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"COLLECTOR".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    PickupDAO pickupDAO = new PickupDAO();
    List<Pickup> assignedPickups = pickupDAO.getPickupsByCollector(user.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zerodech — Collector Dashboard</title>
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">🌿 Zero<span>dech</span></div>
        <ul class="navbar-nav">
            <li><span class="navbar-user">Collector: <%= user.getFullName() %></span></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav" style="background:var(--danger)">Logout</a></li>
        </ul>
    </nav>
    <div class="page-wrapper">
        <div class="page-header">
            <h1>Your Assigned Pickups</h1>
            <p>View and update the status of the pickups assigned to you.</p>
        </div>
        
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Pickup ID</th>
                        <th>Client</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Notes</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (assignedPickups == null || assignedPickups.isEmpty()) { %>
                        <tr><td colspan="8" class="empty-state">No pickups assigned yet.</td></tr>
                    <% } else {
                        for (Pickup p : assignedPickups) { %>
                        <tr>
                            <td>#<%= p.getId() %></td>
                            <td><%= p.getClientName() %><br><small><%= p.getClientPhone() != null ? p.getClientPhone() : "" %></small></td>
                            <td><%= p.getLocation() %></td>
                            <td><%= p.getPickupDate() %></td>
                            <td><%= p.getWasteType() %></td>
                            <td><%= p.getNotes() != null ? p.getNotes() : "-" %></td>
                            <td><span class="badge badge-<%= p.getStatus().toLowerCase() %>"><%= p.getStatus() %></span></td>
                            <td>
                                <% if (!"COMPLETED".equals(p.getStatus())) { %>
                                <form action="update-status" method="POST" class="inline-form">
                                    <input type="hidden" name="pickupId" value="<%= p.getId() %>">
                                    <select name="status" required>
                                        <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(p.getStatus()) ? "selected" : "" %>>In Progress</option>
                                        <option value="COMPLETED">Completed</option>
                                    </select>
                                    <input type="text" name="collectorNote" placeholder="Notes..." value="<%= p.getCollectorNote() != null ? p.getCollectorNote() : "" %>" style="width: 100px; padding: 4px; font-size: 0.8rem;">
                                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                </form>
                                <% } else { %>
                                    <span style="color:var(--text-mid); font-size:0.85rem">Done: <%= p.getCompletedAt() %></span>
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