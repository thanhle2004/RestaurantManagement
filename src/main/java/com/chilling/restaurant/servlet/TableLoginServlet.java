/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.utils.DBUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/table-login")
public class TableLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT table_number FROM tables ";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            List<Integer> tableList = new ArrayList<>();
            while (rs.next()) {
                tableList.add(rs.getInt("table_number"));
            }

            request.setAttribute("tables", tableList);
            request.getRequestDispatcher("table-login.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tableNumber = request.getParameter("tableNumber");
        request.getSession().setAttribute("tableNumber", tableNumber);

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * from tables WHERE table_number=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(tableNumber));
            ResultSet rs = stmt.executeQuery();
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("table-dashboard.jsp");
    }
}

