/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.TableDAO;
import com.chilling.restaurant.model.Table;
import com.chilling.restaurant.utils.AuthUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet("/manager/table-management")
public class TableManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!AuthUtil.checkRole(request, response, "manager")) return;

        try {
            TableDAO tableDAO = new TableDAO();
            List<Table> tableTypeTwoList = tableDAO.getAllTablesByType(2);
            request.setAttribute("tableTypeTwoList", tableTypeTwoList);
            List<Table> tableTypeFourList = tableDAO.getAllTablesByType(4);
            request.setAttribute("tableTypeFourList", tableTypeFourList);
            List<Table> tableTypeEightList = tableDAO.getAllTablesByType(8);
            request.setAttribute("tableTypeEightList", tableTypeEightList);
            request.getRequestDispatcher("/manager/table-management.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
