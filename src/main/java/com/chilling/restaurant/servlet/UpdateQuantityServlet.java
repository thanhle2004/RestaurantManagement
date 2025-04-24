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

@WebServlet("/update-quantity")
public class UpdateQuantityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        OrderList orderList = (OrderList) session.getAttribute("orderList");

        int oitem_id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        if (orderList != null && orderList.getItems() != null) {
            int olist_id = orderList.getOrderList_id();
            OrderItemDAO dao = new OrderItemDAO();

            for (OrderItem oi : orderList.getItems()) {
                if (oi.getOrderItem_id() == oitem_id) {
                    int quantity = oi.getOrderItemQuantity();

                    if ("increase".equals(action)) {
                        quantity++;
                    } else if ("decrease".equals(action) && quantity > 1) {
                        quantity--;
                    }

                    oi.setOrderItemQuantity(quantity);
                    dao.updateOrderItemQuantity(olist_id, oitem_id, quantity);
                    break;
                }
            }

            session.setAttribute("orderList", orderList);
        }

        response.sendRedirect("table-menu");
    }
}