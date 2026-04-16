package com.zerodech.model;

import java.util.Date;

public class Pickup {
    private int id;
    private int clientId;
    private Integer collectorId;
    private String wasteType;
    private String location;
    private Date pickupDate;
    private String status;
    private String notes;
    private String collectorNote;
    private Date createdAt;
    private Date completedAt;

    // Joined fields (filled by DAO joins)
    private String clientName;
    private String clientPhone;
    private String collectorName;

    public Pickup() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getClientId() { return clientId; }
    public void setClientId(int clientId) { this.clientId = clientId; }

    public Integer getCollectorId() { return collectorId; }
    public void setCollectorId(Integer collectorId) { this.collectorId = collectorId; }

    public String getWasteType() { return wasteType; }
    public void setWasteType(String wasteType) { this.wasteType = wasteType; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public Date getPickupDate() { return pickupDate; }
    public void setPickupDate(Date pickupDate) { this.pickupDate = pickupDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getCollectorNote() { return collectorNote; }
    public void setCollectorNote(String collectorNote) { this.collectorNote = collectorNote; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getCompletedAt() { return completedAt; }
    public void setCompletedAt(Date completedAt) { this.completedAt = completedAt; }

    public String getClientName() { return clientName; }
    public void setClientName(String clientName) { this.clientName = clientName; }

    public String getClientPhone() { return clientPhone; }
    public void setClientPhone(String clientPhone) { this.clientPhone = clientPhone; }

    public String getCollectorName() { return collectorName; }
    public void setCollectorName(String collectorName) { this.collectorName = collectorName; }

    /** Returns a Bootstrap badge CSS class based on status */
    public String getStatusBadgeClass() {
        if (status == null) return "badge-secondary";
        switch (status.toUpperCase()) {
            case "PENDING":     return "status-pending";
            case "ASSIGNED":    return "status-assigned";
            case "IN_PROGRESS": return "status-inprogress";
            case "COMPLETED":   return "status-completed";
            case "CANCELLED":   return "status-cancelled";
            default:            return "status-pending";
        }
    }
}