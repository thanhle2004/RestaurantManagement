package com.chilling.restaurant.controller;

import com.chilling.restaurant.dao.TableDAO;
import com.chilling.restaurant.model.Table;
import java.sql.SQLException;
import java.util.List;

public class TableController {
    private TableDAO tableDAO = new TableDAO();
    
    public List<Table> getTableTypeTwoList() throws SQLException {
        return tableDAO.getAllTablesByType(2);
    }
    
    public List<Table> getTableTypeFourList() throws SQLException {
        return tableDAO.getAllTablesByType(4);
    }
    
    public List<Table> getTableTypeEightList() throws SQLException {
        return tableDAO.getAllTablesByType(8);
    }

    public void insertTable(Table table) throws SQLException, Exception {
        tableDAO.insertTable(table);
    }
    
    public void deleteTable(int id) throws SQLException {
        tableDAO.deleteTable(id);
    }
    
    public void reorderAllTableNumbers() throws SQLException {
        tableDAO.reorderAllTableNumbers();
    }
    
    public void changePassword(String password) throws SQLException {
        tableDAO.changePassword(password);
    }
}
