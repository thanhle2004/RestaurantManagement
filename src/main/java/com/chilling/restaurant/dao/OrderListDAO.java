package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.OrderList;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderListDAO {
    public OrderList getOrderListByTableId(int tableId) throws SQLException{
        String sql = "SELECT * FROM OrderList WHERE table_id=?";
        try (Connection con = DBUtil.getConnection())  {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, tableId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()){
                return new OrderList(
                    rs.getInt("olist_id"),
                    rs.getInt("table_id"),
                    rs.getString("order_status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
       
        return null;
    }

    public OrderList getPendingOrderListByTableId(int tableId) {
        String sql = "SELECT * FROM OrderList WHERE table_id = ? AND order_status = 'pending'";
        try (Connection con = DBUtil.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, tableId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new OrderList(
                    rs.getInt("olist_id"),
                    rs.getInt("table_id"),
                    rs.getString("order_status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int createOrderList(int tableId) {
        String sql = "INSERT INTO OrderList (table_id, order_status) VALUES (?, 'pending')";
        try (Connection con = DBUtil.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, tableId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
