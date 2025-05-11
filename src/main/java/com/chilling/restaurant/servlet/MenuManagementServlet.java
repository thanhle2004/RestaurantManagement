/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.MenuItemController;
import com.chilling.restaurant.model.MenuItem;
import com.chilling.restaurant.utils.AuthUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet("/manager/menu-management")
public class MenuManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!AuthUtil.checkRole(request, response, "manager")) return;

        try {
            MenuItemController menuItemController = new MenuItemController();
            List<MenuItem> foodList = menuItemController.getFoodList();
            request.setAttribute("foodList", foodList);
            List<MenuItem> drinkList = menuItemController.getDrinkList();
            request.setAttribute("drinkList", drinkList);
            request.getRequestDispatcher("/manager/menu-management.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
