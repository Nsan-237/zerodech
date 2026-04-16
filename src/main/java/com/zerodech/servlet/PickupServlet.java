package com.zerodech.servlet;

import com.zerodech.dao.PickupDAO;
import com.zerodech.model.Pickup;
import com.zerodech.model.User;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "PickupServlet", urlPatterns = {"/pickup"})
public class PickupServlet extends HttpServlet {

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
            String pickupDateStr = request.getParameter("pickupDate");
            String location      = request.getParameter("location");
            String wasteType     = request.getParameter("wasteType");
            String notes         = request.getParameter("notes");

            if (pickupDateStr == null || pickupDateStr.isEmpty() || location == null || location.trim().isEmpty()) {
                request.setAttribute("error", "La date et l'adresse sont obligatoires.");
                request.getRequestDispatcher("/request-pickup.jsp").forward(request, response);
                return;
            }

            Date pickupDate = new SimpleDateFormat("yyyy-MM-dd").parse(pickupDateStr);

            Pickup pickup = new Pickup();
            pickup.setClientId(user.getId());
            pickup.setCollectorId(null);
            pickup.setWasteType(wasteType != null && !wasteType.isEmpty() ? wasteType : "Mixed");
            pickup.setLocation(location.trim());
            pickup.setPickupDate(pickupDate);
            pickup.setStatus("PENDING");
            pickup.setNotes(notes != null ? notes.trim() : "");

            PickupDAO pickupDAO = new PickupDAO();
            boolean success = pickupDAO.insertPickup(pickup);

            if (success) {
                request.setAttribute("success", "Demande de collecte soumise avec succès !");
                request.getRequestDispatcher("/client-dashboard.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Échec de la soumission. Vérifiez la connexion et réessayez.");
                request.getRequestDispatcher("/request-pickup.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("/request-pickup.jsp").forward(request, response);
        }
    }
}
