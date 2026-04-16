/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.zerodech.servlet;

import com.zerodech.dao.PaymentDAO;
import com.zerodech.model.Payment;
import com.zerodech.model.User;
import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentMethod = request.getParameter("paymentMethod");
            int pickupId = Integer.parseInt(request.getParameter("pickupId"));

            Payment payment = new Payment();
            payment.setAmount(amount);
            payment.setPaymentMethod(paymentMethod);
            payment.setPaymentDate(new Date());
            payment.setClientId(user.getId());
            payment.setPickupId(pickupId);

            PaymentDAO paymentDAO = new PaymentDAO();
            boolean success = paymentDAO.insertPayment(payment);

            if (success) {
                response.sendRedirect("user-dashboard.jsp");
            } else {
                response.sendRedirect("payment.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp");
        }
    }
}
