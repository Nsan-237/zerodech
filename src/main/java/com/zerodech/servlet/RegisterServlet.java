package com.zerodech.servlet;

import com.zerodech.dao.UserDAO;
import com.zerodech.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");
        String phone    = request.getParameter("phone");
        String address  = request.getParameter("address");

        // ── Basic validation ──────────────────────────────────
        if (fullName == null || fullName.trim().isEmpty() ||
            email    == null || email.trim().isEmpty()    ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Nom, email et mot de passe sont obligatoires.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Default role to CLIENT if not provided / invalid
        if (role == null || (!role.equals("CLIENT") && !role.equals("COLLECTOR"))) {
            role = "CLIENT";
        }

        // ── Check email uniqueness ────────────────────────────
        UserDAO userDAO = new UserDAO();
        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("error", "Cet email est déjà utilisé. Veuillez vous connecter.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // ── Build user and insert ─────────────────────────────
        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPassword(password.trim());
        user.setRole(role.toUpperCase());
        user.setPhone(phone != null ? phone.trim() : "");
        user.setAddress(address != null ? address.trim() : "");

        boolean success = userDAO.insertUser(user);

        if (success) {
            request.setAttribute("success", "Compte créé avec succès ! Connectez-vous maintenant.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Échec de l'inscription. Veuillez réessayer.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
