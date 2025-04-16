package com.chilling.restaurant.controller;

import com.chilling.restaurant.dao.MenuDAO;
import com.chilling.restaurant.model.MenuItem;
import java.sql.SQLException;
import java.util.List;

public class MenuItemController {
    private MenuDAO menuDAO = new MenuDAO();
    
    public List<MenuItem> getFoodList() throws SQLException {
        return menuDAO.getAllItemsByType("food");
    }
    
    public List<MenuItem> getDrinkList() throws SQLException {
        return menuDAO.getAllItemsByType("drink");
    }
    
    public MenuItem getItemById(int id) throws SQLException {
        return menuDAO.getItemById(id);
    }
    
    public void addMenuItem(MenuItem item) throws SQLException {
        menuDAO.addMenuItem(item);
    }
    
    public void updateMenuItem(MenuItem item) throws SQLException {
        menuDAO.updateMenuItem(item);
    }
}
