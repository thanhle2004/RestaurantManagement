/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.model;

import java.time.LocalDateTime;

public class Meal {
    private int mealId;
    private int olistId;
    private int billId;
    private int rateId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    public Meal() {
    }

    public Meal(int mealId, int olistId, int billId, int rateId, LocalDateTime startTime, LocalDateTime endTime) {
        this.mealId = mealId;
        this.olistId = olistId;
        this.billId = billId;
        this.rateId = rateId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getMealId() {
        return mealId;
    }

    public void setMealId(int mealId) {
        this.mealId = mealId;
    }

    public int getOlistId() {
        return olistId;
    }

    public void setOlistId(int olistId) {
        this.olistId = olistId;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getRateId() {
        return rateId;
    }

    public void setRateId(int rateId) {
        this.rateId = rateId;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }
}

