package com.chilling.restaurant.model;

public class CookScheduleItem {
    private int scheduleId;
    private int schlistId;
    private int oitemId;
    private int oitemTimeCook; // Số phút để hoàn thành món ăn
    private String status;
    private OrderItem orderItem;

    public CookScheduleItem() {}

    public CookScheduleItem(int scheduleId, int schlistId, int oitemId, int oitemTimeCook, String status) {
        this.scheduleId = scheduleId;
        this.schlistId = schlistId;
        this.oitemId = oitemId;
        this.oitemTimeCook = oitemTimeCook;
        this.status = status;
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
}