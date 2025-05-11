package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.ChefController;
import com.chilling.restaurant.model.User;
import com.chilling.restaurant.utils.AuthUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manager/chef-edit")
public class ChefEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.checkRole(request, response, "manager")) return;
        
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            ChefController chefController = new ChefController();
            User user = chefController.getUserById(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/manager/chef-edit.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = new User();
            user.setUserId(Integer.parseInt(request.getParameter("id")));
            user.setUsername(request.getParameter("username"));
            user.setFname(request.getParameter("fname"));
            user.setLname(request.getParameter("lname"));
            user.setPhone(request.getParameter("phone"));
            user.setRole(request.getParameter("role"));
            
            ChefController chefController = new ChefController();
            chefController.updateUser(user);
            
            response.sendRedirect("chef-management");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
