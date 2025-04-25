/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.MenuItemController;
import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
import com.chilling.restaurant.model.MenuItem;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.model.OrderList;
import com.chilling.restaurant.model.Table;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/table-menu")
public class TableMenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Table table = (Table) session.getAttribute("table");
            
            if (table == null) {
                response.sendRedirect("table-login.jsp");
                return;
            }

            if(!table.getTable_status().equals("occupied")) {
                table.setTable_status("occupied");
            }

            MenuItemController menuItemController = new MenuItemController();

            List<MenuItem> foodList = menuItemController.getFoodList();
            List<MenuItem> drinkList = menuItemController.getDrinkList();

            request.setAttribute("foodList", foodList);
            request.setAttribute("drinkList", drinkList);
            
            OrderListDAO orderListDAO = new OrderListDAO();
            OrderList orderList = orderListDAO.getOrderListByTableId(table.getTable_id());
            OrderItemDAO orderItemDAO = new OrderItemDAO();
            

            if (orderList == null) {
                orderList = new OrderList();
            }
            List<OrderItem> orderItems = orderItemDAO.getItemsByOrderListId(orderList.getOrderList_id());
            session.setAttribute("orderList", orderList);
            session.setAttribute("orderItems", orderItems);
            try {
                double totalAmount = orderItemDAO.getTotalAmountByOrderListId(orderList.getOrderList_id());
                session.setAttribute("totalAmount", String.format("%.2f", totalAmount));
            } catch (SQLException ex) {
                Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            request.getRequestDispatcher("table/menu.jsp").forward(request, response);
        } catch (SQLException e) {
            Logger.getLogger(TableMenuServlet.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
        }
    }
}
