package com.zerodech.dao;

import com.zerodech.model.Subscription;
import com.zerodech.model.SubscriptionPlan;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class SubscriptionDAO {

    // ── GET ALL PLANS ────────────────────────────────────────
    public List<SubscriptionPlan> getAllPlans() {
        List<SubscriptionPlan> list = new ArrayList<>();
        String sql = "SELECT * FROM subscription_plans ORDER BY price ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                SubscriptionPlan plan = new SubscriptionPlan();
                plan.setId(rs.getInt("id"));
                plan.setName(rs.getString("name"));
                plan.setPrice(rs.getDouble("price"));
                plan.setDescription(rs.getString("description"));
                plan.setDurationDays(rs.getInt("duration_days"));
                list.add(plan);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── GET PLAN BY ID ───────────────────────────────────────
    public SubscriptionPlan getPlanById(int id) {
        String sql = "SELECT * FROM subscription_plans WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                SubscriptionPlan plan = new SubscriptionPlan();
                plan.setId(rs.getInt("id"));
                plan.setName(rs.getString("name"));
                plan.setPrice(rs.getDouble("price"));
                plan.setDescription(rs.getString("description"));
                plan.setDurationDays(rs.getInt("duration_days"));
                return plan;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── SUBSCRIBE / RENEW ────────────────────────────────────
    public boolean subscribe(int userId, int planId) {
        // Cancel existing active subscription first
        String cancelSql = "UPDATE subscriptions SET status = 'CANCELLED' WHERE user_id = ? AND status = 'ACTIVE'";
        String insertSql = "INSERT INTO subscriptions (user_id, plan_id, start_date, end_date, status) " +
                           "VALUES (?, ?, SYSDATE, SYSDATE + ?, 'ACTIVE')";
        SubscriptionPlan plan = getPlanById(planId);
        if (plan == null) return false;

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement cancel = con.prepareStatement(cancelSql);
                 PreparedStatement insert = con.prepareStatement(insertSql)) {
                cancel.setInt(1, userId);
                cancel.executeUpdate();

                insert.setInt(1, userId);
                insert.setInt(2, planId);
                insert.setInt(3, plan.getDurationDays());
                insert.executeUpdate();

                con.commit();
                return true;
            } catch (SQLException e) {
                con.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── GET ACTIVE SUBSCRIPTION FOR USER ─────────────────────
    public Subscription getActiveSubscription(int userId) {
        String sql = "SELECT s.*, sp.name AS plan_name, sp.price AS plan_price " +
                     "FROM subscriptions s JOIN subscription_plans sp ON s.plan_id = sp.id " +
                     "WHERE s.user_id = ? AND s.status = 'ACTIVE' AND s.end_date >= SYSDATE " +
                     "ORDER BY s.start_date DESC FETCH FIRST 1 ROW ONLY";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── COUNT ACTIVE SUBSCRIPTIONS ───────────────────────────
    public int countActive() {
        String sql = "SELECT COUNT(*) FROM subscriptions WHERE status = 'ACTIVE' AND end_date >= SYSDATE";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Subscription mapRow(ResultSet rs) throws SQLException {
        Subscription s = new Subscription();
        s.setId(rs.getInt("id"));
        s.setUserId(rs.getInt("user_id"));
        s.setPlanId(rs.getInt("plan_id"));
        s.setStartDate(rs.getDate("start_date"));
        s.setEndDate(rs.getDate("end_date"));
        s.setStatus(rs.getString("status"));
        try { s.setPlanName(rs.getString("plan_name")); } catch (SQLException ignored) {}
        try { s.setPlanPrice(rs.getDouble("plan_price")); } catch (SQLException ignored) {}
        return s;
    }
}
