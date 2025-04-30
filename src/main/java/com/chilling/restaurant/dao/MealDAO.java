/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.Meal;
import com.chilling.restaurant.utils.DBUtil;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MealDAO {

    public int addMeal(Meal meal) throws SQLException {
        String sql = "INSERT INTO Meal (olist_id, start_time) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, meal.getOlistId());
            stmt.setTimestamp(2, Timestamp.valueOf(meal.getStartTime()));
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if(rs.next()) {
                        return rs.getInt(1);
                    } else {
                        throw new SQLException("Failed");
                    }
                }
            } else {
                throw new SQLException("Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void updateMeal(Meal meal) throws SQLException {
        String sql = "UPDATE Meal SET olist_id = ?, bill_id = ?, rate_id = ?, start_time = ?, end_time = ? WHERE meal_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, meal.getOlistId());
            stmt.setInt(2, meal.getBillId());
            stmt.setInt(3, meal.getRateId());
            stmt.setTimestamp(4, Timestamp.valueOf(meal.getStartTime()));
            stmt.setTimestamp(5, Timestamp.valueOf(meal.getEndTime()));
            stmt.setInt(6, meal.getMealId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteMeal(int mealId) throws SQLException {
        String sql = "DELETE FROM Meal WHERE meal_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, mealId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Meal getMealById(int mealId) throws SQLException {
        String sql = "SELECT * FROM Meal WHERE meal_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, mealId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Meal meal = new Meal();
                    meal.setMealId(rs.getInt("meal_id"));
                    meal.setOlistId(rs.getInt("olist_id"));
                    meal.setBillId(rs.getInt("bill_id"));
                    meal.setRateId(rs.getInt("rate_id"));
                    meal.setStartTime(rs.getTimestamp("start_time").toLocalDateTime());
                    meal.setEndTime(rs.getTimestamp("end_time").toLocalDateTime());
                    return meal;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Meal getMealByOrderListId(int olistId) throws SQLException {
        String sql = "SELECT * FROM Meal WHERE olist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, olistId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Meal meal = new Meal();
                    meal.setMealId(rs.getInt("meal_id"));
                    meal.setOlistId(rs.getInt("olist_id"));
                    meal.setBillId(rs.getInt("bill_id"));
                    meal.setRateId(rs.getInt("rate_id"));
                    meal.setStartTime(rs.getTimestamp("start_time").toLocalDateTime());
                    meal.setEndTime(rs.getTimestamp("end_time").toLocalDateTime());
                    return meal;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Meal> getAllMeals() throws SQLException {
        List<Meal> meals = new ArrayList<>();
        String sql = "SELECT * FROM Meal";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Meal meal = new Meal();
                meal.setMealId(rs.getInt("meal_id"));
                meal.setOlistId(rs.getInt("olist_id"));
                meal.setBillId(rs.getInt("bill_id"));
                meal.setRateId(rs.getInt("rate_id"));
                meal.setStartTime(rs.getTimestamp("start_time").toLocalDateTime());
                meal.setEndTime(rs.getTimestamp("end_time").toLocalDateTime());
                meals.add(meal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return meals;
    }
    
    public void updateBillIdInMeal(Meal meal) throws SQLException {
        String sql = "UPDATE meal SET bill_id = ? WHERE meal_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, meal.getBillId());
            stmt.setInt(2, meal.getMealId());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(MealDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
 
}
