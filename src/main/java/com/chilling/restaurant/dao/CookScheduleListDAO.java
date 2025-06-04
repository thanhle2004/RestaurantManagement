package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.CookScheduleList;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CookScheduleListDAO {

    public CookScheduleList getScheduleByOlistIdAndUserId(int olistId, int userId) {
        String sql = "SELECT * FROM CookScheduleList WHERE olist_id = ? AND user_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, olistId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CookScheduleList(
                    rs.getInt("schlist_id"),
                    rs.getInt("olist_id"),
                    rs.getInt("user_id"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public CookScheduleList getScheduleByOlistId(int olistId) {
        String sql = "SELECT * FROM CookScheduleList WHERE olist_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, olistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CookScheduleList(
                    rs.getInt("schlist_id"),
                    rs.getInt("olist_id"),
                    rs.getInt("user_id"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public int getScheduleIdByOlistId(int olistId) {
        String sql = "SELECT schlist_id FROM CookScheduleList WHERE olist_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, olistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("schlist_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public CookScheduleList createSchedule(CookScheduleList schedule) {
        String sql = "INSERT INTO CookScheduleList (olist_id, user_id, status) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, schedule.getOlistId());
            stmt.setInt(2, schedule.getUserId());
            stmt.setString(3, schedule.getStatus());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                schedule.setSchlistId(id);
                return schedule;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateStatus(int schlistId, String status) {
        String sql = "UPDATE CookScheduleList SET status = ? WHERE schlist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, schlistId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public CookScheduleList getScheduleById(int schlistId) {
        String sql = "SELECT * FROM CookScheduleList WHERE schlist_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, schlistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CookScheduleList(
                    rs.getInt("schlist_id"),
                    rs.getInt("olist_id"),
                    rs.getInt("user_id"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public String getScheduleListStatusByOlistId(int olistId) {
        String sql = "SELECT status FROM cookschedulelist WHERE olist_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, olistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public int getScheduleListIdByOlistId(int olistId) {
        String sql = "SELECT schlist_id FROM cookschedulelist WHERE olist_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, olistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("schlist_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}