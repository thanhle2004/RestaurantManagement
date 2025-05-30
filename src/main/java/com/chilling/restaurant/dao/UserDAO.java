package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.User;
import com.chilling.restaurant.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    public List<User> getUserByRole(String role) throws SQLException {
        List<User> userList = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM users WHERE role = ? ";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFname(rs.getString("fname"));
                user.setLname(rs.getString("lname"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    public User getUserById(int id) throws SQLException {
        User user = null;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM users WHERE user_id = ? ";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if(rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setPassword(rs.getString("password"));
                user.setUsername(rs.getString("username"));
                user.setFname(rs.getString("fname"));
                user.setLname(rs.getString("lname"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public void updateUser(User user) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE users SET username=?, fname=?, lname=?, phone=?, password=?, role=? WHERE user_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername()); // Thêm username
            stmt.setString(2, user.getFname());
            stmt.setString(3, user.getLname());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getRole());
            stmt.setInt(7, user.getUserId());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void deleteChef(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void insertUser(String username, String password, String fname, String lname, String phone, String role) throws SQLException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO users (username, password, fname, lname, phone, role) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, fname);
            stmt.setString(4, lname);
            stmt.setString(5, phone);
            stmt.setString(6, role);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public boolean updatePasswordByPhone(String phone, String newPassword) throws SQLException {
        String sql = "UPDATE users SET password = ? WHERE phone = ?";
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, phone);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean checkPhoneExists(String phone) {
        String sql = "SELECT 1 FROM users WHERE phone = ?";
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}