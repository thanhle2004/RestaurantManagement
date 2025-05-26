/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.utils.DBUtil;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.cloudinary.json.JSONArray;
import org.cloudinary.json.JSONObject;

@WebServlet("/manager/ViewStatsServlet")
public class ViewStatsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String groupBy = request.getParameter("groupBy");
        if (groupBy == null) groupBy = "day";

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (Connection conn = DBUtil.getConnection()) {
            JSONObject json = new JSONObject();

            // 1. Total Meals
            try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM meal")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) json.put("totalMeals", rs.getInt(1));
            }

            // 2. Total Dishes
            try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM orderitem")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) json.put("totalDishes", rs.getInt(1));
            }

            // 3. Total Revenue
            try (PreparedStatement stmt = conn.prepareStatement("SELECT SUM(amount) FROM bill WHERE payment_status = 'paid'")) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) json.put("totalRevenue", rs.getDouble(1));
            }

            // 4. Revenue Chart
            String groupBySQL, orderBySQL, selectLabel;
            switch (groupBy) {
                case "week":
                    groupBySQL = "YEAR(meal.end_time), WEEK(meal.end_time)";
                    orderBySQL = "YEAR(meal.end_time), WEEK(meal.end_time)";
                    selectLabel = "CONCAT(YEAR(meal.end_time), '-W', WEEK(meal.end_time)) AS label";
                    break;
                case "month":
                    groupBySQL = "YEAR(meal.end_time), MONTH(meal.end_time)";
                    orderBySQL = "YEAR(meal.end_time), MONTH(meal.end_time)";
                    selectLabel = "CONCAT(YEAR(meal.end_time), '-', LPAD(MONTH(meal.end_time), 2, '0')) AS label";
                    break;
                case "year":
                    groupBySQL = "YEAR(meal.end_time)";
                    orderBySQL = "YEAR(meal.end_time)";
                    selectLabel = "YEAR(meal.end_time) AS label";
                    break;
                default:
                    groupBySQL = "DATE(meal.end_time)";
                    orderBySQL = "DATE(meal.end_time)";
                    selectLabel = "DATE(meal.end_time) AS label";
                    break;
            }

            JSONArray labels = new JSONArray();
            JSONArray data = new JSONArray();

            String chartQuery = "SELECT " + selectLabel + ", SUM(bill.amount) AS total " +
                                "FROM meal JOIN bill ON meal.bill_id = bill.bill_id " +
                                "WHERE bill.payment_status = 'paid' " +
                                "GROUP BY " + groupBySQL + " " +
                                "ORDER BY " + orderBySQL;

            try (PreparedStatement stmt = conn.prepareStatement(chartQuery)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    labels.put(rs.getString("label"));
                    data.put(rs.getDouble("total"));
                }
            }

            json.put("chartLabels", labels);
            json.put("chartData", data);

            // 5. Ratings Percentage
            JSONArray ratingPercentages = new JSONArray();
            int[] count = new int[5];
            int total = 0;

            try (PreparedStatement stmt = conn.prepareStatement("SELECT rating FROM rate")) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    int r = rs.getInt("rating");
                    if (r >= 1 && r <= 5) {
                        count[r - 1]++;
                        total++;
                    }
                }
            }

            for (int i = 0; i < 5; i++) {
                int percent = total == 0 ? 0 : (int) Math.round(count[i] * 100.0 / total);
                ratingPercentages.put(percent);
            }

            json.put("ratingPercents", ratingPercentages);
            json.put("ratingTotalVotes", total);

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("{\"error\":\"Internal Server Error\"}");
        }
    }
}
