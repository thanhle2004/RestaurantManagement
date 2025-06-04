/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.utils.DBUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/check-manager")
public class CheckManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean managerExists = false;
        HttpSession session = request.getSession(false);
        if(session != null) {
            session.invalidate();
        }
        Boolean errorAttr = (Boolean) request.getAttribute("error");
        boolean error = (errorAttr != null) ? errorAttr : false;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT COUNT(*) FROM users WHERE role = 'manager'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                managerExists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(CheckManagerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        request.setAttribute("managerExists", managerExists);
        RequestDispatcher dispatcher = request.getRequestDispatcher("restaurant-login.jsp");
        dispatcher.forward(request, response);  
    }
}
