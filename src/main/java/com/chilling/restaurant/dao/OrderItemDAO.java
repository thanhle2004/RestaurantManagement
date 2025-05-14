/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.MenuItem;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderItemDAO {
    private MenuDAO menuDAO = new MenuDAO();
    
    public List<OrderItem> getItemsByOrderListId(int orderListId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.oitem_id, oi.olist_id, oi.quantity, " +
                     "mi.mi_id, mi.mi_name, mi.mi_price, mi.mi_img_path, mi.mi_time_cook " +
                     "FROM orderitem oi " +
                     "JOIN menuitem mi ON oi.mi_id = mi.mi_id " +
                     "WHERE oi.olist_id = ?";
        try (Connection con = DBUtil.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderListId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MenuItem item = new MenuItem();
                item.setItemId(rs.getInt("mi_id"));
                item.setItemName(rs.getString("mi_name"));
                item.setItemPrice(rs.getDouble("mi_price"));
                item.setItemImgPath(rs.getString("mi_img_path"));
                item.setItemTimeCook(rs.getInt("mi_time_cook"));

                OrderItem orderItem = new OrderItem(
                        rs.getInt("oitem_id"),
                        rs.getInt("olist_id"),
                        item,
                        rs.getInt("quantity")
                );
                items.add(orderItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }
    
    public OrderItem getOrderItemById(int orderItemId) {
        OrderItem item = null;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM orderitem WHERE oitem_id = ?")) {
            ps.setInt(1, orderItemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    item = new OrderItem();
                    item.setOrderItem_id(rs.getInt("oitem_id"));
                    item.setOrderItemQuantity(rs.getInt("quantity"));
                    item.setItem(menuDAO.getItemById(rs.getInt("mi_id")));
                    item.setOrderList_id(rs.getInt("olist_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(OrderItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return item;
    } 
    
    public double getTotalAmountByOrderListId(int orderListId) throws SQLException {
        double totalAmount = 0;
        String sql = "SELECT SUM(subtotal) " +
                     "FROM (SELECT (oi.quantity * mi.mi_price) AS subtotal " +
                     "FROM menuitem mi " +
                     "JOIN orderitem oi ON mi.mi_id = oi.mi_id " +
                     "JOIN orderlist ol ON ol.olist_id = oi.olist_id " +
                     "WHERE ol.olist_id = ? " +
                     ") as SubPrice;";
        
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderListId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                totalAmount = rs.getDouble("SUM(subtotal)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalAmount;
    }
    
    public OrderItem getOrderItemByListIdAndItemId(int orderListId, int itemId) {
    String sql = "SELECT oi.oitem_id, oi.olist_id, oi.quantity, " +
                 "mi.mi_id, mi.mi_name, mi.mi_price, mi.mi_img_path, mi.mi_time_cook " +
                 "FROM orderitem oi " +
                 "JOIN menuitem mi ON oi.mi_id = mi.mi_id " +
                 "WHERE oi.olist_id = ? AND oi.mi_id = ?";
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, orderListId);
        ps.setInt(2, itemId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            MenuItem item = new MenuItem();
            item.setItemId(rs.getInt("mi_id"));
            item.setItemName(rs.getString("mi_name"));
            item.setItemPrice(rs.getDouble("mi_price"));
            item.setItemImgPath(rs.getString("mi_img_path"));
            item.setItemTimeCook(rs.getInt("mi_time_cook"));

            return new OrderItem(
                rs.getInt("oitem_id"),
                rs.getInt("olist_id"),
                item,
                rs.getInt("quantity")
            );
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

public void insertOrderItem(OrderItem orderItem) {
    String sql = "INSERT INTO orderitem (olist_id, mi_id, quantity) VALUES (?, ?, ?)";
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, orderItem.getOrderList_id());
        ps.setInt(2, orderItem.getItem().getItemId());
        ps.setInt(3, orderItem.getOrderItemQuantity());
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public boolean deleteOrderItem(int olistId, int oitemId) {
    String sql = "DELETE FROM orderitem WHERE olist_id = ? AND oitem_id = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, olistId);
        stmt.setInt(2, oitemId);
        return stmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }   catch (Exception ex) {
            Logger.getLogger(OrderItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    return false;
}

public boolean updateOrderItemQuantity(int olistId, int oitemId, int quantity) {
    String sql = "UPDATE orderitem SET quantity = ? WHERE olist_id = ? AND oitem_id = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, quantity);
        stmt.setInt(2, olistId);
        stmt.setInt(3, oitemId);
        return stmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }   catch (Exception ex) {
            Logger.getLogger(OrderItemDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    return false;
}


}
