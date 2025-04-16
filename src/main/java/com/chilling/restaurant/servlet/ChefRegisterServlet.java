package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.ChefController;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manager/chef-register")
public class ChefRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");

        String role = "chef";

        try {
            ChefController chefController = new ChefController();
            chefController.insertChef(username, password, fname, lname, phone, role);

            response.sendRedirect("chef-management");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
