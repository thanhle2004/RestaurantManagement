/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.UserDAO;
import com.chilling.restaurant.model.User;
import com.chilling.restaurant.utils.AuthUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet("/manager/chef-management")
public class ChefManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!AuthUtil.checkRole(request, response, "manager")) return;

        try {
            UserDAO userDAO = new UserDAO();
            List<User> chefList = userDAO.getUserByRole("chef");
            request.setAttribute("chefList", chefList);
            request.getRequestDispatcher("/manager/chef-management.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
