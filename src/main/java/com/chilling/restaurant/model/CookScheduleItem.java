package com.chilling.restaurant.model;

public class CookScheduleItem {
    private int scheduleId;
    private int schlistId;
    private int oitemId;
    private int oitemTimeCook; // Số phút để hoàn thành món ăn
    private String status;
    private OrderItem orderItem;
    private int completed_quantity;

    public CookScheduleItem() {}

    public CookScheduleItem(int scheduleId, int schlistId, int oitemId, int oitemTimeCook, String status, int completed_quantity) {
        this.scheduleId = scheduleId;
        this.schlistId = schlistId;
        this.oitemId = oitemId;
        this.oitemTimeCook = oitemTimeCook;
        this.status = status;
        this.completed_quantity = completed_quantity;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getSchlistId() {
        return schlistId;
    }

    public void setSchlistId(int schlistId) {
        this.schlistId = schlistId;
    }

    public int getOitemId() {
        return oitemId;
    }

    public void setOitemId(int oitemId) {
        this.oitemId = oitemId;
    }

    public int getOitemTimeCook() {
        return oitemTimeCook;
    }

    public void setOitemTimeCook(int oitemTimeCook) {
        this.oitemTimeCook = oitemTimeCook;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public OrderItem getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(OrderItem orderItem) {
        this.orderItem = orderItem;
    }
    
    public int getCompleted_quantity() {
        return completed_quantity;
    }
    
    public void setCompleted_quantity(int completed_quantity) {
        this.completed_quantity = completed_quantity;
    }
}