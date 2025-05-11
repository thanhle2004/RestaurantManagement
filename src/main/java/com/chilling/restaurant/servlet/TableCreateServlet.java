package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.TableController;
import com.chilling.restaurant.dao.TableDAO;
import com.chilling.restaurant.model.Table;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manager/table-create")
public class TableCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int type = Integer.parseInt(request.getParameter("type"));
        try {
            TableController tableController = new TableController();
            TableDAO tableDAO = new TableDAO();
            Table newTable = new Table();
            newTable.setTable_type(type);
            newTable.setTable_status("available");
            newTable.setTable_password("123");
            tableDAO.insertTable(newTable);
            
            response.sendRedirect("table-management");
        } catch (Exception e) {
            throw new ServletException(e);
        } 
    }
}
