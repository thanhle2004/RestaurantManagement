/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.Bill;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BillDAO {
    public int createBill(Bill bill) {
    String sql = "INSERT INTO bill (olist_id, amount, payment_status) VALUES (?, ?, ?)";
    try (Connection con = DBUtil.getConnection()) {
        PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, bill.getOlist_id());
        stmt.setDouble(2, bill.getAmount());
        stmt.setString(3, bill.getPayment_status());
        
        int rowsInserted = stmt.executeUpdate();
        
        if (rowsInserted > 0) {
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1); 
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1; 
}

    
    public Bill getBillByOrderListID(int olist_id) throws SQLException {
        String sql = "SELECT * FROM bill WHERE olist_id = ?";
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, olist_id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Bill bill = new Bill();
                bill.setBill_id(rs.getInt("bill_id"));
                bill.setOlist_id(rs.getInt("olist_id"));
                bill.setAmount(rs.getDouble("amount"));
                bill.setPayment_status(rs.getString("payment_status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updatePaymentStatusPaid(int bill_id) {
        String sql = "UPDATE bill SET payment_status = ? WHERE bill_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, "paid");
            stmt.setInt(2, bill_id);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated == 0) {
                System.out.println("No bill found with ID: " + bill_id);
            } else {
                System.out.println("Bill ID " + bill_id + " updated to 'paid'");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
