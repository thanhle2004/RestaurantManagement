/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.MenuDAO;
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
            MenuDAO menuDAO = new MenuDAO();
            List<MenuItem> foodList = menuDAO.getAllItemsByType("food");
            request.setAttribute("foodList", foodList);
            List<MenuItem> drinkList = menuDAO.getAllItemsByType("drink");
            request.setAttribute("drinkList", drinkList);
            List<MenuItem> dessertList = menuDAO.getAllItemsByType("dessert");
            request.setAttribute("dessertList", dessertList);
            request.getRequestDispatcher("/manager/menu-management.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
