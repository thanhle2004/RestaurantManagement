/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.CookScheduleItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
import com.chilling.restaurant.model.Meal;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.model.OrderList;
import com.chilling.restaurant.model.Table;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/order-status")
public class OrderSummaryDataServlet extends HttpServlet {
    private final OrderListDAO orderListDAO = new OrderListDAO();
    private final CookScheduleItemDAO cookScheduleItemDAO = new CookScheduleItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Meal meal = (Meal) request.getSession().getAttribute("meal");
        int olistId = (meal != null) ? meal.getOlistId() : 0;
        OrderList orderList = (olistId > 0) ? orderListDAO.getOrderListById(olistId) : null;

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("orderListId", orderList != null ? orderList.getOrderList_id() : "N/A");
        responseData.put("orderStatus", orderList != null ? orderList.getOrderStatus() : "unavailable");

        Gson gson = new Gson();
        String json = gson.toJson(responseData);
        response.getWriter().write(json);
    }
}