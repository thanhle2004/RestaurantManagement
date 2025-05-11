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

@WebServlet("/manager/menu-edit")
public class MenuEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.checkRole(request, response, "manager")) return;
        
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            MenuItemController menuItemController = new MenuItemController();
            MenuItem item = menuItemController.getItemById(id);
            request.setAttribute("item", item);
            request.getRequestDispatcher("/manager/menu-edit.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }   
}
