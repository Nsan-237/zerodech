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

        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Name, email and password are required.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (role == null || (!role.equals("CLIENT") && !role.equals("COLLECTOR") && !role.equals("ADMIN"))) {
            role = "CLIENT";
        }

        UserDAO userDAO = new UserDAO();

        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("error", "This email is already taken. Please login.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPassword(password.trim());
        user.setRole(role.toUpperCase());
        user.setPhone(phone != null ? phone.trim() : "");
        user.setAddress(address != null ? address.trim() : "");

        boolean success = userDAO.insertUser(user);

        if (success) {
            request.setAttribute("success", "Account successfully created! Log in now.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}