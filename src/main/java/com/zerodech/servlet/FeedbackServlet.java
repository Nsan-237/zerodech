/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.zerodech.servlet;

import com.zerodech.dao.FeedbackDAO;
import com.zerodech.model.Feedback;
import com.zerodech.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            int pickupId = Integer.parseInt(request.getParameter("pickupId"));
            String comments = request.getParameter("comments");

            Feedback feedback = new Feedback();
            feedback.setCollectorId(user.getId());
            feedback.setPickupId(pickupId);
            feedback.setComments(comments);

            FeedbackDAO feedbackDAO = new FeedbackDAO();
            boolean success = feedbackDAO.insertFeedback(feedback);

            if (success) {
                response.sendRedirect("collector-dashboard.jsp");
            } else {
                response.sendRedirect("feedback.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("feedback.jsp");
        }
    }
}
