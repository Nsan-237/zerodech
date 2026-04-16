/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.zerodech.dao;

import com.zerodech.model.Feedback;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FeedbackDAO {

    public boolean insertFeedback(Feedback feedback) {
        boolean success = false;

        String sql = "INSERT INTO feedback (collector_id, pickup_id, comments) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, feedback.getCollectorId());
            ps.setInt(2, feedback.getPickupId());
            ps.setString(3, feedback.getComments());

            int rows = ps.executeUpdate();
            success = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
    }

    public Feedback getFeedbackById(int id) {
        Feedback feedback = null;

        String sql = "SELECT * FROM feedback WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                feedback = new Feedback();
                feedback.setId(rs.getInt("id"));
                feedback.setCollectorId(rs.getInt("collector_id"));
                feedback.setPickupId(rs.getInt("pickup_id"));
                feedback.setComments(rs.getString("comments"));
                feedback.setCreatedAt(rs.getDate("created_at"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return feedback;
    }
}