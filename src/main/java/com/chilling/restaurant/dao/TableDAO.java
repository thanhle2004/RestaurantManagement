/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.Table;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TableDAO {
    public List<Table> getAllTables() throws SQLException {
        List<Table> tableList = new ArrayList<>();
       
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM tables";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Table table = new Table();
                table.setTable_id(rs.getInt("table_id"));
                table.setTable_number(rs.getInt("table_number"));
                table.setTable_type(rs.getInt("table_type"));
                table.setTable_status(rs.getString("table_status"));
                table.setTable_password(rs.getString("table_password"));
                tableList.add(table);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tableList;
    }
    
    public List<Table> getAllTablesByType(int table_type) throws SQLException {
        List<Table> tableList = new ArrayList<>();
       
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM tables WHERE table_type=?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, table_type);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Table table = new Table();
                table.setTable_id(rs.getInt("table_id"));
                table.setTable_number(rs.getInt("table_number"));
                table.setTable_type(rs.getInt("table_type"));
                table.setTable_status(rs.getString("table_status"));
                table.setTable_password(rs.getString("table_password"));
                tableList.add(table);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tableList;
    }
    
    public void insertTable(Table table) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO tables (table_number, table_type, table_status, table_password) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, 0);
            stmt.setInt(2, table.getTable_type());
            stmt.setString(3, table.getTable_status());
            stmt.setString(4, table.getTable_password());

            stmt.executeUpdate();

            reorderAllTableNumbers();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public void reorderAllTableNumbers() throws SQLException {
        String selectSQL = "SELECT table_id FROM tables ORDER BY table_type, table_id";
        String updateSQL = "UPDATE tables SET table_number = ? WHERE table_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSQL);
             ResultSet rs = selectStmt.executeQuery()) {

            int newNumber = 1;
            while (rs.next()) {
                int tableId = rs.getInt("table_id");

                try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                    updateStmt.setInt(1, newNumber++);
                    updateStmt.setInt(2, tableId);
                    updateStmt.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public void deleteTable(int tableId) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM tables WHERE table_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, tableId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void changePassword(String password) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE tables SET table_password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, password);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
