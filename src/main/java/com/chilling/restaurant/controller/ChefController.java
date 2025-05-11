package com.chilling.restaurant.controller;

import com.chilling.restaurant.dao.UserDAO;
import com.chilling.restaurant.model.User;
import java.sql.SQLException;
import java.util.List;

public class ChefController {
    private UserDAO userDAO = new UserDAO();
    
    public List<User> getAllChefs() throws SQLException {
        return userDAO.getUserByRole("chef");
    }
    
    public User getUserById(int id) throws SQLException {
        return userDAO.getUserById(id);
    }
    
    public void updateUser(User user) throws SQLException {
        userDAO.updateUser(user);
    }
    
    public void deleteChef(int id) throws SQLException {
        userDAO.deleteChef(id);
    }
    
    public void insertChef(String username, String password, String fname, String lname, String phone, String role) throws SQLException {
        userDAO.insertChef(username, password, fname, lname, phone, role);
    }
}
