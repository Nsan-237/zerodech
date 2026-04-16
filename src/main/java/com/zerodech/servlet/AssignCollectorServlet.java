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

@WebServlet(name = "AssignCollectorServlet", urlPatterns = {"/assignCollector"})
public class AssignCollectorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int pickupId    = Integer.parseInt(request.getParameter("pickupId"));
            int collectorId = Integer.parseInt(request.getParameter("collectorId"));

            PickupDAO pickupDAO = new PickupDAO();
            boolean success = pickupDAO.assignCollector(pickupId, collectorId);

            if (success) {
                request.setAttribute("success", "Collecteur assigné avec succès !");
            } else {
                request.setAttribute("error", "Échec de l'assignation.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
        }

        request.getRequestDispatcher("/manage-requests.jsp").forward(request, response);
    }
}
