package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.CookScheduleItem;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CookScheduleItemDAO {

    public CookScheduleItem getItemByOitemIdAndSchlistId(int oitemId, int schlistId) {
        String sql = "SELECT * FROM CookScheduleItem WHERE oitem_id = ? AND schlist_id = ?";
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
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public CookScheduleItem createItem(CookScheduleItem item) {
        String sql = "INSERT INTO CookScheduleItem (schlist_id, oitem_id, oitem_time_cook, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, item.getSchlistId());
            stmt.setInt(2, item.getOitemId());
            stmt.setInt(3, item.getOitemTimeCook());
            stmt.setString(4, item.getStatus());
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
        String sql = "UPDATE CookScheduleItem SET oitem_time_cook = ?, status = ? WHERE schedule_id = ?";
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

    public boolean areAllItemsCompleted(int schlistId) {
        String sql = "SELECT COUNT(*) FROM CookScheduleItem WHERE schlist_id = ? AND status != 'completed'";
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
        String sql = "SELECT COUNT(*) FROM CookScheduleItem WHERE schlist_id = ? AND status = 'cooking'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, schlistId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Có ít nhất một item đang nấu
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}