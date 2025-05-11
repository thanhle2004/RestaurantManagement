/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.TableController;
import com.chilling.restaurant.dao.TableDAO;
import com.chilling.restaurant.model.Table;
import com.chilling.restaurant.utils.DBUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet("/table-login")
public class TableLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            TableController tableController = new TableController();
            List<Table> tableTypeTwoList = tableController.getTableTypeTwoList();
            request.setAttribute("tableTypeTwoList", tableTypeTwoList);
            List<Table> tableTypeFourList = tableController.getTableTypeFourList();
            request.setAttribute("tableTypeFourList", tableTypeFourList);
            List<Table> tableTypeEightList = tableController.getTableTypeEightList();
            request.setAttribute("tableTypeEightList", tableTypeEightList);
            request.getRequestDispatcher("table-login.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int tableId = Integer.parseInt(request.getParameter("id"));
        String password = request.getParameter("password");

        try {
            TableDAO tableDAO = new TableDAO();
            Table table = tableDAO.getTableById(tableId);

            if (table != null && password.equals(table.getTable_password())) {
                request.getSession().setAttribute("table", table);
                response.sendRedirect(request.getContextPath() + "/table-dashboard.jsp");
                return;
            } else {
                request.setAttribute("error", "Invalid table ID or password");
                doGet(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

