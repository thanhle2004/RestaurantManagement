package com.chilling.restaurant.model;

public class Table {
    private int table_id;
    private Integer olist_id;
    private int table_number;
    private int table_type;
    private String table_status;
    private String table_password;

    public int getTable_id() {
        return table_id;
    }
    
    public void setTable_id(int table_id) {
        this.table_id = table_id;
    }
    
    public Integer getOlist_id() {
        return olist_id;
    }
    
    public void setOlist_id(Integer olist_id) {
        this.olist_id = olist_id;
    }
    
    public int getTable_number() {
        return table_number;
    }

    public void setTable_number(int table_number) {
        this.table_number = table_number;
    }

    public int getTable_type() {
        return table_type;
    }

    public void setTable_type(int table_type) {
        this.table_type = table_type;
    }

    public String getTable_status() {
        return table_status;
    }

    public void setTable_status(String table_status) {
        this.table_status = table_status;
    }
    
    public String getTable_password() {
        return table_password;
    }
    
    public void setTable_password(String table_password) {
        this.table_password = table_password;
    }
}

