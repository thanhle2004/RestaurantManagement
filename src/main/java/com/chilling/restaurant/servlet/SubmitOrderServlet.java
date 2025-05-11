/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/submit-order")
public class SubmitOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            Table table = (Table) session.getAttribute("table");
            OrderListDAO orderListDAO = new OrderListDAO();
            OrderList orderList = orderListDAO.getOrderListByTableId(table.getTable_id());
            OrderItemDAO orderItemDAO = new OrderItemDAO();
            
            if (orderList != null && orderList.getItems() != null) {
                
                System.out.println("Submitting order for table: " + table.getTable_number());
                for (OrderItem item : orderList.getItems()) {
                    System.out.println("Item: " + item.getItem().getItemName() +
                            ", Quantity: " + item.getOrderItemQuantity());
                }
                
                session.setAttribute("summaryItems", orderItemDAO.getItemsByOrderListId(orderList.getOrderList_id()));
                double summaryTotal = orderItemDAO.getTotalAmountByOrderListId(orderList.getOrderList_id());
                session.setAttribute("summaryTotal", String.format("%.2f", summaryTotal));
                session.setAttribute("orderList", orderList);
                
                response.sendRedirect(request.getContextPath() + "/table/order-summary.jsp");
                
            } else {
                response.sendRedirect("table-menu?error=No+items+to+submit");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubmitOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
