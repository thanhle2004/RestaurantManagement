/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.model;

public class Rate {
    private int rate_id;
    private int rate_value;
    private String comment;
    
    public Rate() {}

    public int getRate_id() {
        return rate_id;
    }

    public int getRate_value() {
        return rate_value;
    }

    public String getComment() {
        return comment;
    }

    public void setRate_id(int rate_id) {
        this.rate_id = rate_id;
    }

    public void setRate_value(int rate_value) {
        this.rate_value = rate_value;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
