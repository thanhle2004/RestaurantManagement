package com.chilling.restaurant.servlet;

import com.chilling.restaurant.utils.DBUtil;
import com.chilling.restaurant.model.User;
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

@WebServlet("/restaurant-login")
public class RestaurantLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT user_id, username, password, fname, lname, phone, role FROM users WHERE username=? AND password=?";//SELECT role FROM users WHERE username=? AND password=?
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                
                //////////////////////
                int userId = rs.getInt("user_id");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                String phone = rs.getString("phone");
                ////////
                String role = rs.getString("role");
                
                ///////////////////
                User user = new User(userId, username, password, fname, lname, phone, role);
                /////
                request.getSession().invalidate();
                HttpSession newSession = request.getSession(true);
                newSession.setAttribute("role", role);
                newSession.setAttribute("username", username);
                
                ////////////////////////////////////
                newSession.setAttribute("user", user); // Set User object into session
                ///

                if ("manager".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/manager/manager-dashboard.jsp");
                } else if ("chef".equals(role)) {
                    System.out.println("chef connected");
                    response.sendRedirect(request.getContextPath() + "/chef/schedule");
                }
            } else {
                response.sendRedirect("restaurant-login.jsp?error=1");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
