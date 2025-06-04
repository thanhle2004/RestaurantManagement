/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.model;

public class Bill {
    private int bill_id;
    private int olist_id;
    private double amount;
    private String payment_status;
    
    public Bill() {}

    public int getBill_id() {
        return bill_id;
    }

    public int getOlist_id() {
        return olist_id;
    }

    public double getAmount() {
        return amount;
    }

    public String getPayment_status() {
        return payment_status;
    }

    public void setBill_id(int bill_id) {
        this.bill_id = bill_id;
    }

    public void setOlist_id(int olist_id) {
        this.olist_id = olist_id;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setPayment_status(String payment_status) {
        this.payment_status = payment_status;
    }
    
    
}
