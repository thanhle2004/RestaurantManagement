package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
import com.chilling.restaurant.dao.CookScheduleItemDAO;
import com.chilling.restaurant.model.Meal;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.model.OrderList;
import com.chilling.restaurant.model.Table;

import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/submit-order")
public class SubmitOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            Table table = (Table) session.getAttribute("table");
            Meal meal = (Meal) session.getAttribute("meal");
            OrderListDAO orderListDAO = new OrderListDAO();
            OrderList orderList = orderListDAO.getOrderListById(meal.getOlistId());
            OrderItemDAO orderItemDAO = new OrderItemDAO();
            CookScheduleItemDAO cookScheduleItemDAO = new CookScheduleItemDAO();
            
            if (orderList != null) {
                System.out.println("Submitting order for table: " + table.getTable_number());
                List<OrderItem> items = orderItemDAO.getItemsByOrderListId(orderList.getOrderList_id());
                for (OrderItem item : items) {
                    System.out.println("Item: " + item.getItem().getItemName() +
                            ", Quantity: " + item.getOrderItemQuantity());
                }
                
                session.setAttribute("summaryItems", items);
                double summaryTotal = orderItemDAO.getTotalAmountByOrderListId(orderList.getOrderList_id());
                session.setAttribute("summaryTotal", String.format("%.2f", summaryTotal));
                session.setAttribute("orderList", orderList);
                session.setAttribute("table", table);
                session.setAttribute("meal", meal);
                
                response.sendRedirect(request.getContextPath() + "/table/order-summary.jsp");
            } else {
                response.sendRedirect("table-menu?error=No+items+to+submit");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubmitOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}