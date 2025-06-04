package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manager/chef-delete")
public class ChefDeleteServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        
        
        try {
            UserDAO userDAO = new UserDAO();
            userDAO.deleteChef(id);

            response.sendRedirect("chef-management");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
