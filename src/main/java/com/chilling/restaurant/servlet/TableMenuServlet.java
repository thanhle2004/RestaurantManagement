/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.controller.MenuItemController;
import com.chilling.restaurant.dao.MealDAO;
import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
import com.chilling.restaurant.dao.TableDAO;
import com.chilling.restaurant.model.Meal;
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
import java.time.LocalDateTime;
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
            String action = request.getParameter("action");
            LocalDateTime now = LocalDateTime.now();

            if (table == null) {
                response.sendRedirect("table-login.jsp");
                return;
            }

            if (!"occupied".equals(table.getTable_status())) {
                table.setTable_status("occupied");
                TableDAO tableDAO = new TableDAO();
                tableDAO.updateTableStatus("occupied", table.getTable_id());
            }

            OrderListDAO orderListDAO = new OrderListDAO();
            MealDAO mealDAO = new MealDAO();
            OrderItemDAO orderItemDAO = new OrderItemDAO();
            TableDAO tableDAO = new TableDAO();

            OrderList orderList = (OrderList) session.getAttribute("orderList");

            if ("create-order".equals(action)) {
                orderList = orderListDAO.createOrderList();

                Meal meal = new Meal();
                meal.setOlistId(orderList.getOrderList_id());
                meal.setStartTime(now);
                
                int meal_id = mealDAO.addMeal(meal);
                meal.setMealId(meal_id);
                table.setOlist_id(orderList.getOrderList_id());
                tableDAO.updateOrderListID(orderList.getOrderList_id(), table.getTable_id());

                session.setAttribute("orderList", orderList);
                session.setAttribute("meal", meal);
            }

            if (orderList == null) {
                orderList = new OrderList();
            }

            MenuItemController menuItemController = new MenuItemController();
            List<MenuItem> foodList = menuItemController.getFoodList();
            List<MenuItem> drinkList = menuItemController.getDrinkList();
            request.setAttribute("foodList", foodList);
            request.setAttribute("drinkList", drinkList);

            List<OrderItem> orderItems = orderItemDAO.getItemsByOrderListId(orderList.getOrderList_id());
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

