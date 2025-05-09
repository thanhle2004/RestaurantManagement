package com.chilling.restaurant.servlet;

import com.chilling.restaurant.utils.DBUtil;
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
        
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT role FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                request.getSession().invalidate();
                HttpSession newSession = request.getSession(true);
                newSession.setAttribute("role", role);
                newSession.setAttribute("username", username);

                if ("manager".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/manager/manager-dashboard.jsp");
                } else if ("chef".equals(role)) {
                    response.sendRedirect("chef.jsp");
                }
            } else {
                response.sendRedirect("restaurant-login.jsp?error=1");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
