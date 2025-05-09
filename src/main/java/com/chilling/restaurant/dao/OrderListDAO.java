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
    public OrderList getOrderListByOrderListId(int orderListId) throws SQLException{
        String sql = "SELECT * FROM orderlist WHERE table_id=?";
        try (Connection con = DBUtil.getConnection())  {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderListId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()){
                return new OrderList(
                    rs.getInt("olist_id"),
                    rs.getString("order_status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
       
        return null;
    }

    public OrderList getPendingOrderListByOrderListId(int orderListId) {
        String sql = "SELECT * FROM orderlist WHERE olist_id = ? AND order_status = 'pending'";
        try (Connection con = DBUtil.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderListId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new OrderList(
                    rs.getInt("olist_id"),
                    rs.getString("order_status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public OrderList createOrderList() throws SQLException {
        String sql = "INSERT INTO orderlist (order_status) VALUES ('pending')";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                OrderList orderList = new OrderList();
                orderList.setOrderList_id(id);
                orderList.setOrderStatus("pending");
                return orderList;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public OrderList getOrderListById(int olistId) {
        String sql = "SELECT * FROM orderlist WHERE olist_id = ?";
        try (Connection con = DBUtil.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, olistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new OrderList(
                    rs.getInt("olist_id"),
                    rs.getString("order_status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
