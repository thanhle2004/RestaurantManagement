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
    public OrderList getOrderListByOrderListId(int orderListId) throws SQLException {
        String sql = "SELECT * FROM OrderList WHERE table_id=?";
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
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

    public OrderList getPendingOrderListByOrderListId(int orderListId) {
        String sql = "SELECT * FROM OrderList WHERE olist_id = ? AND order_status = 'pending'";
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
        String sql = "INSERT INTO OrderList (order_status) VALUES ('pending')";
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
        String sql = "SELECT * FROM OrderList WHERE olist_id = ?";
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

    public List<OrderList> getPendingOrderLists() {
        List<OrderList> orderLists = new ArrayList<>();
        String sql = "SELECT * FROM OrderList WHERE order_status IN ('pending', 'preparing')";
        try (Connection con = DBUtil.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderList orderList = new OrderList(
                    rs.getInt("olist_id"),
                    rs.getString("order_status")
                );
                orderLists.add(orderList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderLists;
    }

    public void updateOrderStatus(int olistId, String status) {
        String sql = "UPDATE OrderList SET order_status = ? WHERE olist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, olistId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}