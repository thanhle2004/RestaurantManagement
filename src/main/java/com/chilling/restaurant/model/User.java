package com.chilling.restaurant.model;

public class User {
    private int user_id;
    private String username;
    private String password;
    private String fname;
    private String lname;
    private String phone;
    private String role;

    public User() {}
    
    public User(int user_id, String username, String password, String fname, String lname, String phone, String role) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
        this.fname = fname;
        this.lname = lname;
        this.phone = phone;
        this.role = role;
    }
    // Getters & Setters
    
    public int getUserId() {
        return user_id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public String getFname() {
        return fname;
    }
    
    public String getLname() {
        return lname;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public String getRole() {
        return role;
    }

    public void setUserId(int user_id) {
        this.user_id = user_id;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setRole(String role) {
        this.role = role;
    }
}

