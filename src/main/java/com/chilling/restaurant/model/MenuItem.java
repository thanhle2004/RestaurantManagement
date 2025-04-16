package com.chilling.restaurant.model;

public class MenuItem {
    private int itemId;
    private String itemName;
    private String itemType;
    private double itemPrice;
    private String itemImgPath;
    private String itemImgPublicId;
    
    public int getItemId() {
        return itemId;
    }
    
    public String getItemName() {
        return itemName;
    }
    
    public String getItemType() {
        return itemType;
    }
    
    public double getItemPrice() {
        return itemPrice;
    }
    
    public String getItemImgPath() {
        return itemImgPath;
    }
    
    public String getItemImgPublicId() {
        return itemImgPublicId;
    }
    
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }
    
    public void setItemType(String itemType) {
        this.itemType = itemType;
    }
    
    public void setItemPrice(double itemPrice) {
        this.itemPrice = itemPrice;
    }
    
    public void setItemImgPath(String itemImgPath) {
        this.itemImgPath = itemImgPath;
    }
    
    public void setItemImgPublicId(String itemImgPublicId) {
        this.itemImgPublicId = itemImgPublicId;
    }
}