package com.chilling.restaurant.model;

public class OrderItem {
    private int orderItem_id;
    private int orderList_id;
    private MenuItem item;
    private int quantity;
    
    public OrderItem(int orderItem_id, int orderList_id, MenuItem item, int quantity) {
        this.orderItem_id = orderItem_id;
        this.orderList_id = orderList_id;
        this.item = item;
        this.quantity = quantity;
    }

    public OrderItem() {}
    
    public int getOrderItem_id() {
        return orderItem_id;
    }
    
    public void setOrderItem_id(int orderItem_id) {
        this.orderItem_id = orderItem_id;
    }
    
    public int getOrderList_id() {
        return orderList_id;
    }
    
    public void setOrderList_id(int orderList_id) {
        this.orderList_id = orderList_id;
    }
    
    public MenuItem getItem() {
        return item;
    }

    public void setItem(MenuItem item) {
        this.item = item;
    }
    
    public int getOrderItemQuantity() {
        return quantity;
    }
    
    public void setOrderItemQuantity(int quantity) {
        this.quantity = quantity;
    }
}

