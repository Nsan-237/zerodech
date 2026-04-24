package com.zerodech.dao;

import com.zerodech.model.Pickup;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PickupDAO {

    // ── INSERT ───────────────────────────────────────────────
    public boolean insertPickup(Pickup p) {
        String sql = "INSERT INTO pickups (client_id, collector_id, waste_type, location, pickup_date, status, notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, p.getClientId());
            if (p.getCollectorId() == null) ps.setNull(2, Types.INTEGER);
            else ps.setInt(2, p.getCollectorId());
            ps.setString(3, p.getWasteType() != null ? p.getWasteType() : "Mixed");
            ps.setString(4, p.getLocation());
            ps.setDate(5, new java.sql.Date(p.getPickupDate().getTime()));
            ps.setString(6, p.getStatus() != null ? p.getStatus() : "PENDING");
            ps.setString(7, p.getNotes());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── GET BY ID (with joins) ───────────────────────────────
    public Pickup getPickupById(int id) {
        String sql = "SELECT p.*, c.full_name AS client_name, c.phone AS client_phone, " +
                     "co.full_name AS collector_name " +
                     "FROM pickups p " +
                     "JOIN users c ON p.client_id = c.id " +
                     "LEFT JOIN users co ON p.collector_id = co.id " +
                     "WHERE p.id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── GET ALL PICKUPS BY CLIENT ────────────────────────────
    public List<Pickup> getPickupsByClient(int clientId) {
        return queryList(
            "SELECT p.*, c.full_name AS client_name, c.phone AS client_phone, " +
            "co.full_name AS collector_name " +
            "FROM pickups p JOIN users c ON p.client_id = c.id " +
            "LEFT JOIN users co ON p.collector_id = co.id " +
            "WHERE p.client_id = ? ORDER BY p.created_at DESC",
            clientId);
    }

    // ── GET ALL PICKUPS BY COLLECTOR ─────────────────────────
    public List<Pickup> getPickupsByCollector(int collectorId) {
        return queryList(
            "SELECT p.*, c.full_name AS client_name, c.phone AS client_phone, " +
            "co.full_name AS collector_name " +
            "FROM pickups p JOIN users c ON p.client_id = c.id " +
            "LEFT JOIN users co ON p.collector_id = co.id " +
            "WHERE p.collector_id = ? ORDER BY p.pickup_date ASC",
            collectorId);
    }

    // ── GET ALL PICKUPS (admin) ──────────────────────────────
    public List<Pickup> getAllPickups() {
        String sql = "SELECT p.*, c.full_name AS client_name, c.phone AS client_phone, " +
                     "co.full_name AS collector_name " +
                     "FROM pickups p JOIN users c ON p.client_id = c.id " +
                     "LEFT JOIN users co ON p.collector_id = co.id " +
                     "ORDER BY p.created_at DESC";
        List<Pickup> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── UPDATE STATUS ────────────────────────────────────────
    public boolean updateStatus(int pickupId, String status, String collectorNote) {
        String sql = "UPDATE pickups SET status = ?, collector_note = ?, " +
                     "completed_at = CASE WHEN ? = 'COMPLETED' THEN SYSDATE ELSE completed_at END " +
                     "WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, collectorNote);
            ps.setString(3, status);
            ps.setInt(4, pickupId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── ASSIGN COLLECTOR ─────────────────────────────────────
    public boolean assignCollector(int pickupId, int collectorId) {
        String sql = "UPDATE pickups SET collector_id = ?, status = 'ASSIGNED' WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, collectorId);
            ps.setInt(2, pickupId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── COUNT ALL ────────────────────────────────────────────
    public int countAll() {
        return countWhere("1=1", null);
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM pickups WHERE status = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── PRIVATE HELPERS ──────────────────────────────────────
    private List<Pickup> queryList(String sql, int param) {
        List<Pickup> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, param);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private int countWhere(String where, String val) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM pickups WHERE " + where)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Pickup mapRow(ResultSet rs) throws SQLException {
        Pickup p = new Pickup();
        p.setId(rs.getInt("id"));
        p.setClientId(rs.getInt("client_id"));
        int cid = rs.getInt("collector_id");
        p.setCollectorId(rs.wasNull() ? null : cid);
        try { p.setWasteType(rs.getString("waste_type")); } catch (SQLException ignored) {}
        p.setLocation(rs.getString("location"));
        p.setPickupDate(rs.getDate("pickup_date"));
        try { p.setStatus(rs.getString("status")); } catch (SQLException ignored) {}
        try { p.setNotes(rs.getString("notes")); } catch (SQLException ignored) {}
        try { p.setCollectorNote(rs.getString("collector_note")); } catch (SQLException ignored) {}
        try { p.setCreatedAt(rs.getDate("created_at")); } catch (SQLException ignored) {}
        try { p.setCompletedAt(rs.getDate("completed_at")); } catch (SQLException ignored) {}
        // joined columns (may not exist in all queries)
        try { p.setClientName(rs.getString("client_name")); } catch (SQLException ignored) {}
        try { p.setClientPhone(rs.getString("client_phone")); } catch (SQLException ignored) {}
        try { p.setCollectorName(rs.getString("collector_name")); } catch (SQLException ignored) {}
        return p;
    }
}