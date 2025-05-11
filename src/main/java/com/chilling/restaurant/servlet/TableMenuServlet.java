/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.MenuItemController;
import com.chilling.restaurant.model.MenuItem;
import com.chilling.restaurant.model.Table;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet("/table-menu")
public class TableMenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Table table = (Table) session.getAttribute("table");
            table.setTable_status("occupied");
            if(table == null) {
                response.sendRedirect("table-login.jsp");
                return;
            }
            MenuItemController menuItemController = new MenuItemController();
            List<MenuItem> foodList = menuItemController.getFoodList();
            request.setAttribute("foodList", foodList);
            List<MenuItem> drinkList = menuItemController.getDrinkList();
            request.setAttribute("drinkList", drinkList);
            request.getRequestDispatcher("table/menu.jsp").forward(request, response);
        } catch (SQLException e) {
            Logger.getLogger(TableMenuServlet.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
