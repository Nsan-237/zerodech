package com.zerodech.servlet;

import com.zerodech.dao.SubscriptionDAO;
import com.zerodech.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SubscribeServlet", urlPatterns = {"/subscribe"})
public class SubscribeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            int planId = Integer.parseInt(request.getParameter("planId"));
            SubscriptionDAO subDAO = new SubscriptionDAO();
            boolean success = subDAO.subscribe(user.getId(), planId);

            if (success) {
                request.setAttribute("success", "Abonnement activé avec succès !");
            } else {
                request.setAttribute("error", "Échec de l'abonnement. Réessayez.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
        }

        request.getRequestDispatcher("/client-dashboard.jsp").forward(request, response);
    }
}
