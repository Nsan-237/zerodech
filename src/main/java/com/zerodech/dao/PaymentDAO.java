/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.zerodech.dao;

import com.zerodech.model.Payment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PaymentDAO {

    public boolean insertPayment(Payment payment) {
        boolean success = false;

        String sql = "INSERT INTO payments (amount, payment_method, payment_date, client_id, pickup_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, payment.getAmount());
            ps.setString(2, payment.getPaymentMethod());
            ps.setDate(3, new java.sql.Date(payment.getPaymentDate().getTime()));
            ps.setInt(4, payment.getClientId());
            ps.setInt(5, payment.getPickupId());

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    public Payment getPaymentById(int id) {
        Payment payment = null;

        String sql = "SELECT * FROM payments WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setClientId(rs.getInt("client_id"));
                payment.setPickupId(rs.getInt("pickup_id"));
                payment.setCreatedAt(rs.getDate("created_at"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payment;
    }
}