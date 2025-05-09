/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.model.Meal;
import com.chilling.restaurant.model.MenuItem;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.utils.DBUtil;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/manager/view-record")
public class ViewRecordServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchDate = request.getParameter("searchDate");
        String viewMealIdStr = request.getParameter("viewMealId");

        List<Meal> meals = new ArrayList<>();
        Meal selectedMeal = null;

        try (Connection conn = DBUtil.getConnection()) {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT m.*, r.rating, r.comment, b.amount ")
               .append("FROM meal m ")
               .append("LEFT JOIN Rate r ON m.rate_id = r.rate_id ")
               .append("LEFT JOIN Bill b ON m.bill_id = b.bill_id ");

            if (searchDate != null && !searchDate.isEmpty()) {
                sql.append("WHERE DATE(m.start_time) = ? ");
            }

            sql.append("ORDER BY m.start_time DESC");

            PreparedStatement stmt = conn.prepareStatement(sql.toString());

            if (searchDate != null && !searchDate.isEmpty()) {
                stmt.setString(1, searchDate);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Timestamp start = rs.getTimestamp("start_time");
                Timestamp end = rs.getTimestamp("end_time");

                LocalDateTime startTime = start != null ? start.toLocalDateTime() : null;
                LocalDateTime endTime = end != null ? end.toLocalDateTime() : null;

                Meal meal = new Meal(
                    rs.getInt("meal_id"),
                    rs.getInt("olist_id"),
                    rs.getInt("bill_id"),
                    rs.getInt("rate_id"),
                    startTime,
                    endTime
                );

                meal.setRating(rs.getInt("rating"));
                meal.setFeedback(rs.getString("comment"));
                meal.setAmount(rs.getBigDecimal("amount"));

                // Nếu có viewMealId thì chỉ load OrderItems cho meal đó
                if (viewMealIdStr != null && !viewMealIdStr.isEmpty()) {
                    int viewMealId = Integer.parseInt(viewMealIdStr);
                    if (meal.getMealId() == viewMealId) {
                        List<OrderItem> orderItems = fetchOrderItemsByOlistId(conn, meal.getOlistId());
                        meal.setOrderItems(orderItems);
                        selectedMeal = meal;
                    }
                }

                meals.add(meal);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(ViewRecordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("searchDate", searchDate);
        request.setAttribute("meals", meals);
        request.setAttribute("selectedMeal", selectedMeal);
        request.getRequestDispatcher("/manager/view-record.jsp").forward(request, response);
    }

    private List<OrderItem> fetchOrderItemsByOlistId(Connection conn, int olistId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();

        String sql = "SELECT oi.oitem_id, oi.quantity, mi.mi_id, mi.mi_name, mi.mi_price " +
                     "FROM orderitem oi " +
                     "JOIN menuitem mi ON oi.mi_id = mi.mi_id " +
                     "WHERE oi.olist_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, olistId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                MenuItem mi = new MenuItem();
                mi.setItemId(rs.getInt("mi_id"));
                mi.setItemName(rs.getString("mi_name"));
                mi.setItemPrice(rs.getDouble("mi_price"));

                OrderItem item = new OrderItem();
                item.setOrderItem_id(rs.getInt("oitem_id"));
                item.setOrderItemQuantity(rs.getInt("quantity"));
                item.setItem(mi);

                items.add(item);
            }
        }

        return items;
    }
}


