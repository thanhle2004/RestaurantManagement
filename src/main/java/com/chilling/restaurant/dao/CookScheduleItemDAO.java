package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.CookScheduleItem;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CookScheduleItemDAO {

    public CookScheduleItem getItemByOitemIdAndSchlistId(int oitemId, int schlistId) {
        String sql = "SELECT * FROM cookscheduleitem WHERE oitem_id = ? AND schlist_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, oitemId);
            ps.setInt(2, schlistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CookScheduleItem(
                    rs.getInt("schedule_id"),
                    rs.getInt("schlist_id"),
                    rs.getInt("oitem_id"),
                    rs.getInt("oitem_time_cook"),
                    rs.getString("status"),
                    rs.getInt("completed_quantity")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public CookScheduleItem createItem(CookScheduleItem item) {
        String sql = "INSERT INTO cookscheduleitem (schlist_id, oitem_id, oitem_time_cook, status, completed_quantity) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, item.getSchlistId());
            stmt.setInt(2, item.getOitemId());
            stmt.setInt(3, item.getOitemTimeCook());
            stmt.setString(4, item.getStatus());
            stmt.setInt(5, item.getCompleted_quantity());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                item.setScheduleId(id);
                return item;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateItem(CookScheduleItem item) {
        String sql = "UPDATE cookscheduleitem SET oitem_time_cook = ?, status = ? WHERE schedule_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getOitemTimeCook());
            stmt.setString(2, item.getStatus());
            stmt.setInt(3, item.getScheduleId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateStatus(String status, int oitem_id) {
        String sql = "UPDATE cookscheduleitem SET status = ? WHERE oitem_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, oitem_id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateCompletedQuantity(int completed_quantity, int oitem_id) {
        String sql = "UPDATE cookscheduleitem SET completed_quantity = ? WHERE oitem_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, completed_quantity);
            stmt.setInt(2, oitem_id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public int getCompletedQuantity(int schlistId, int oitemId) {
        String sql = "SELECT completed_quantity FROM cookscheduleitem WHERE schlist_id = ? AND oitem_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, schlistId);
            ps.setInt(2, oitemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("completed_quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean areAllItemsCompleted(int schlistId) {
        String sql = "SELECT COUNT(*) FROM cookscheduleitem WHERE schlist_id = ? AND status != 'completed'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, schlistId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0; // Nếu không còn item nào không hoàn thành
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasCookingStatus(int schlistId) {
        String sql = "SELECT COUNT(*) FROM cookscheduleitem WHERE schlist_id = ? AND status = 'cooking'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, schlistId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteCookScheduleItem(int schlistId, int oitemId) {
        String sql = "DELETE FROM cookscheduleitem WHERE schlist_id = ? AND oitem_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, schlistId);
            stmt.setInt(2, oitemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }   catch (Exception ex) {
                Logger.getLogger(OrderItemDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        return false;
    }
    
    
}