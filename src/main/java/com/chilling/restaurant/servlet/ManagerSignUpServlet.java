package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manager-register")
public class ManagerSignUpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");

        String role = "manager";

        try {
            UserDAO userDAO = new UserDAO();
            userDAO.insertUser(username, password, fname, lname, phone, role);

            response.sendRedirect("check-manager");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
