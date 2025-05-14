/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.model;

import java.util.List;

public class CookScheduleList {
    private int schlistId;
    private int olistId;
    private int userId;
    private String status;
    private List<CookScheduleItem> items;

    public CookScheduleList() {}

    public CookScheduleList(int schlistId, int olistId, int userId, String status) {
        this.schlistId = schlistId;
        this.olistId = olistId;
        this.userId = userId;
        this.status = status;
    }

    public int getSchlistId() {
        return schlistId;
    }

    public void setSchlistId(int schlistId) {
        this.schlistId = schlistId;
    }

    public int getOlistId() {
        return olistId;
    }

    public void setOlistId(int olistId) {
        this.olistId = olistId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public List<CookScheduleItem> getItems() {
        return items;
    }

    public void setItems(List<CookScheduleItem> items) {
        this.items = items;
    }
}
