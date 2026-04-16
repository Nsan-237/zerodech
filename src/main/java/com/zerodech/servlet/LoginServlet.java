package com.zerodech.servlet;

import com.zerodech.dao.UserDAO;
import com.zerodech.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Already logged in? redirect
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            redirectByRole((User) session.getAttribute("user"), response, request);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email.trim(), password.trim());

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            redirectByRole(user, response, request);
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void redirectByRole(User user, HttpServletResponse response, HttpServletRequest request)
            throws IOException {
        String ctx = request.getContextPath();
        switch (user.getRole().toUpperCase()) {
            case "ADMIN":     response.sendRedirect(ctx + "/admin-dashboard.jsp");     break;
            case "COLLECTOR": response.sendRedirect(ctx + "/collector-dashboard.jsp"); break;
            default:          response.sendRedirect(ctx + "/client-dashboard.jsp");    break;
        }
    }
}
