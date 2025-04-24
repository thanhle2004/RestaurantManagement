package com.chilling.restaurant.model;

public class MenuItem {
    private int itemId;
    private String itemName;
    private String itemType;
    private double itemPrice;
    private int itemTimeCook;
    private String itemImgPath;
    private String itemImgPublicId;
    
    public MenuItem() {}
    
    public MenuItem(int miId, String miName, String miType, double miPrice, int miTimeCook, String miImgPath, String miImgPublicId) {
        this.itemId = miId;
        this.itemName = miName;
        this.itemType = miType;
        this.itemPrice = miPrice;
        this.itemTimeCook = miTimeCook;
        this.itemImgPath = miImgPath;
        this.itemImgPublicId = miImgPublicId;
    }
    
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
    
    public int getItemTimeCook() {
        return itemTimeCook;
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
    
    public void setItemTimeCook (int itemTimeCook) {
        this.itemTimeCook = itemTimeCook;
    }
    
    public void setItemImgPath(String itemImgPath) {
        this.itemImgPath = itemImgPath;
    }
    
    public void setItemImgPublicId(String itemImgPublicId) {
        this.itemImgPublicId = itemImgPublicId;
    }
}