package com.chilling.restaurant.dao;

import com.chilling.restaurant.model.MenuItem;
import com.chilling.restaurant.utils.DBUtil;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MenuDAO {
    
    private final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dgmhg5oi4",
            "api_key", "466185731953851",
            "api_secret", "UAK80EwU70sE-YTU0Ujv3sLRAbs"
    ));

    public List<MenuItem> getAllMenuItems() throws SQLException {
        List<MenuItem> menuList = new ArrayList<>();
       
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM menu";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                MenuItem item = new MenuItem();
                item.setItemId(rs.getInt("mi_id"));
                item.setItemType(rs.getString("mi_type"));
                item.setItemName(rs.getString("mi_name"));
                item.setItemPrice(rs.getDouble("mi_price"));
                item.setItemImgPath(rs.getString("mi_img_path"));
                item.setItemImgPublicId(rs.getString("mi_img_public_id"));
                menuList.add(item);
            }
        } catch (Exception e) {
            
        }

        return menuList;
    }
    
    public List<MenuItem> getAllItemsByType(String miType) throws SQLException {
        List<MenuItem> itemList = new ArrayList<>();
       
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM menu WHERE mi_type = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, miType);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                MenuItem item = new MenuItem();
                item.setItemId(rs.getInt("mi_id"));
                item.setItemName(rs.getString("mi_name"));
                item.setItemType(rs.getString("mi_type"));
                item.setItemPrice(rs.getDouble("mi_price"));
                item.setItemImgPath(rs.getString("mi_img_path"));
                item.setItemImgPublicId(rs.getString("mi_img_public_id"));
                itemList.add(item);
            }
        } catch (Exception e) {
            
        }

        return itemList;
    }
    
    public MenuItem getItemById(int miId) throws SQLException {
        MenuItem item = new MenuItem();
        
        try (Connection con = DBUtil.getConnection()) {
            String sql = "SELECT * FROM menu WHERE mi_id = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, miId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                
                item.setItemId(rs.getInt("mi_id"));
                item.setItemName(rs.getString("mi_name"));
                item.setItemType(rs.getString("mi_type"));
                item.setItemPrice(rs.getDouble("mi_price"));
                item.setItemImgPath(rs.getString("mi_img_path"));
                item.setItemImgPublicId(rs.getString("mi_img_public_id"));
            }
        } catch (Exception e) {
            
        }

        return item;
    }

    public void addMenuItem(MenuItem item) throws SQLException {
        

        try (Connection con = DBUtil.getConnection()){
            String sql = "INSERT INTO menu (mi_name, mi_type, mi_price, mi_img_path, mi_img_public_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql); 

            stmt.setString(1, item.getItemName());
            stmt.setString(2, item.getItemType());
            stmt.setDouble(3, item.getItemPrice());
            stmt.setString(4, item.getItemImgPath());
            stmt.setString(5, item.getItemImgPublicId());

            stmt.executeUpdate();
        } catch (Exception e) {
            
        }
    }

    public void deleteMenuItem(int miId) throws SQLException {
        
        String publicID = this.getItemById(miId).getItemImgPublicId();
        
        try {
            Map result = cloudinary.uploader().destroy(publicID, ObjectUtils.emptyMap());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        String sql = "DELETE FROM menu WHERE mi_id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, miId);
            stmt.executeUpdate();
        } catch (Exception e) {
            
        }
    }
    
    public void updateMenuItem(MenuItem item) throws SQLException {
        try (Connection con = DBUtil.getConnection()){
            String sql = "UPDATE menu SET mi_name=?, mi_type=?, mi_price=?, mi_img_path=?, mi_img_public_id=? WHERE mi_id=?";
            PreparedStatement stmt = con.prepareStatement(sql); 

            stmt.setString(1, item.getItemName());
            stmt.setString(2, item.getItemType());
            stmt.setDouble(3, item.getItemPrice());
            stmt.setString(4, item.getItemImgPath());
            stmt.setString(5, item.getItemImgPublicId());
            stmt.setInt(6, item.getItemId());
            stmt.executeUpdate();
        } catch (Exception e) {
            
        }
    }
}
