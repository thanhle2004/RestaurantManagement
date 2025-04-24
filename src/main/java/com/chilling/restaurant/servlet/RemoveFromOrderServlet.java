/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.model.OrderList;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/remove-from-order")
public class RemoveFromOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        OrderList orderList = (OrderList) session.getAttribute("orderList");

        if (orderList != null) {
            int oitem_id = Integer.parseInt(request.getParameter("id"));
            int olist_id = orderList.getOrderList_id();

            Iterator<OrderItem> iterator = orderList.getItems().iterator();
            while (iterator.hasNext()) {
                OrderItem item = iterator.next();
                if (item.getOrderItem_id() == oitem_id) {
                    iterator.remove();
                    break;
                }
            }

            OrderItemDAO orderItemDAO = new OrderItemDAO();
            orderItemDAO.deleteOrderItem(olist_id, oitem_id);
            try {
                double totalAmount = orderItemDAO.getTotalAmountByOrderListId(orderList.getOrderList_id());
                session.setAttribute("totalAmount", String.format("%.2f", totalAmount));
            } catch (SQLException ex) {
                Logger.getLogger(RemoveFromOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            session.setAttribute("orderList", orderList);
        }

        response.sendRedirect("table-menu");
    }
}