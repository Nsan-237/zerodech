package com.zerodech.servlet;

import com.zerodech.dao.PickupDAO;
import com.zerodech.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateStatusServlet", urlPatterns = {"/updateStatus"})
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        // Only collectors and admins can update status
        if (!"COLLECTOR".equalsIgnoreCase(user.getRole()) && !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int pickupId     = Integer.parseInt(request.getParameter("pickupId"));
            String newStatus = request.getParameter("status");
            String note      = request.getParameter("collectorNote");
            if (note == null) note = "";

            PickupDAO pickupDAO = new PickupDAO();
            boolean success = pickupDAO.updateStatus(pickupId, newStatus, note);

            if (success) {
                request.setAttribute("success", "Statut mis à jour avec succès !");
            } else {
                request.setAttribute("error", "Échec de la mise à jour.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
        }

        String redirectPage = "ADMIN".equalsIgnoreCase(user.getRole())
                ? "/manage-requests.jsp" : "/collector-dashboard.jsp";
        request.getRequestDispatcher(redirectPage).forward(request, response);
    }
}
