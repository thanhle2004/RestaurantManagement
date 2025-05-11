package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.MenuDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manager/menu-delete")
public class MenuItemDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            MenuDAO menuDAO = new MenuDAO();
            menuDAO.deleteMenuItem(id);

            response.sendRedirect("menu-management");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
