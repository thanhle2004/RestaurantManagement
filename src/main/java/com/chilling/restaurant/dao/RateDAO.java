/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.dao;

import com.chilling.restaurant.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RateDAO {
    public int createRate(int rate_value, String comment) {
    int generatedId = -1;
    try (Connection con = DBUtil.getConnection()) {
        String sql = "INSERT INTO rate (rating, comment) VALUES (?, ?)";
        PreparedStatement stmt = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, rate_value);
        stmt.setString(2, comment);
        
        int rowsInserted = stmt.executeUpdate();
        
        if (rowsInserted > 0) {
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1); 
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return generatedId;
}

}
