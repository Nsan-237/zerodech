package com.zerodech.model;

import java.util.Date;

public class Subscription {
    private int id;
    private int userId;
    private int planId;
    private Date startDate;
    private Date endDate;
    private String status;

    // joined fields (not in DB column, filled by DAO query)
    private String planName;
    private double planPrice;

    public Subscription() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getPlanId() { return planId; }
    public void setPlanId(int planId) { this.planId = planId; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }

    public double getPlanPrice() { return planPrice; }
    public void setPlanPrice(double planPrice) { this.planPrice = planPrice; }

    public String getFormattedPrice() {
        return String.format("%,.0f FCFA", planPrice);
    }
}
