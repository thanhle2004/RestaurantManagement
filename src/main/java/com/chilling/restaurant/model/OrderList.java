package com.chilling.restaurant.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderList {
    private int orderList_id;
    private String order_status;
    private LocalDateTime createdTime;
    private List<OrderItem> items = new ArrayList<>();
    private double totalAmount;

    public OrderList() {}

    public OrderList(int orderList_id, String order_status) {
        this.orderList_id = orderList_id;
        this.order_status = order_status;
    }

    public int getOrderList_id() {
        return orderList_id;
    }

    public void setOrderList_id(int orderList_id) {
        this.orderList_id = orderList_id;
    }

    public String getOrderStatus() {
        return order_status;
    }

    public void setOrderStatus(String order_status) {
        this.order_status = order_status;
    }

    public LocalDateTime getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(LocalDateTime createdTime) {
        this.createdTime = createdTime;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public double getTotalAmount() {
        double total = 0;
        for (OrderItem item : items) {
            total += item.getItem().getItemPrice() * item.getOrderItemQuantity();
        }
        return total;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
}
