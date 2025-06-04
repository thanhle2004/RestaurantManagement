/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.chilling.restaurant.servlet;

import com.chilling.restaurant.config.VNPayConfig;
import com.chilling.restaurant.dao.BillDAO;
import com.chilling.restaurant.dao.MealDAO;
import com.chilling.restaurant.model.Bill;
import com.chilling.restaurant.model.Meal;
import com.chilling.restaurant.model.Table;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/table/submitOrder")
public class VNPayPaymentServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(VNPayPaymentServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Table table = (Table) session.getAttribute("table");
            Meal meal = (Meal) session.getAttribute("meal");

            if (table == null || meal == null) {
                LOGGER.severe("Table or Meal is null in session");
                session.setAttribute("error", "Invalid session data. Please try again.");
                response.sendRedirect(request.getContextPath() + "/order-summary.jsp");
                return;
            }

            String orderInfo = request.getParameter("orderInfo");
            String orderIdStr = request.getParameter("orderId");
            String amountStr = request.getParameter("amount");
            String amountInUSDStr = request.getParameter("amountInUSD");

            // Kiểm tra tham số
            if (orderInfo == null || orderIdStr == null || amountStr == null) {
                LOGGER.severe("Missing required parameters: orderInfo, orderId, or amount");
                session.setAttribute("error", "Invalid payment data. Please try again.");
                response.sendRedirect(request.getContextPath() + "/order-summary.jsp");
                return;
            }

            // Chuyển đổi orderId
            int olist_id;
            try {
                olist_id = Integer.parseInt(orderIdStr);
            } catch (NumberFormatException e) {
                LOGGER.severe("Invalid orderId format: " + orderIdStr);
                session.setAttribute("error", "Invalid order ID. Please try again.");
                response.sendRedirect(request.getContextPath() + "/order-summary.jsp");
                return;
            }

            // Chuyển đổi amount
            double totalAmount;
            try {
                totalAmount = Double.parseDouble(amountStr);
            } catch (NumberFormatException e) {
                LOGGER.severe("Invalid amount format: " + amountStr);
                session.setAttribute("error", "Invalid amount format. Please try again.");
                response.sendRedirect(request.getContextPath() + "/order-summary.jsp");
                return;
            }

            // Tính amountInUSD nếu không được gửi
            double totalAmountInUSD;
            if (amountInUSDStr != null && !amountInUSDStr.isEmpty()) {
                try {
                    totalAmountInUSD = Double.parseDouble(amountInUSDStr);
                } catch (NumberFormatException e) {
                    LOGGER.severe("Invalid amountInUSD format: " + amountInUSDStr);
                    session.setAttribute("error", "Invalid USD amount format. Please try again.");
                    response.sendRedirect(request.getContextPath() + "/order-summary.jsp");
                    return;
                }
            } else {
                // Tính amountInUSD từ amount (VND)
                totalAmountInUSD = totalAmount / (23500 * 100); // amount là VND, chia cho tỷ giá
                LOGGER.info("Calculated amountInUSD: " + totalAmountInUSD);
            }

            // Tạo Bill
            Bill bill = new Bill();
            bill.setOlist_id(olist_id);
            bill.setAmount(totalAmountInUSD);
            bill.setPayment_status("unpaid");

            BillDAO billDAO = new BillDAO();
            bill.setBill_id(billDAO.createBill(bill));
            LOGGER.info("Created bill with ID: " + bill.getBill_id());

            // Cập nhật Meal
            meal.setBillId(bill.getBill_id());
            MealDAO mealDAO = new MealDAO();
            try {
                mealDAO.updateBillIdInMeal(meal);
                LOGGER.info("Updated billId in meal: " + bill.getBill_id());
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error updating billId in meal", e);
                session.setAttribute("error", "Database error. Please try again.");
                response.sendRedirect(request.getContextPath() + "/order-summary.jsp");
                return;
            }

            // Lưu vào session
            session.setAttribute("meal", meal);
            session.setAttribute("bill", bill);
            session.setAttribute("table", table);

            // Tạo tham số VNPay
            String vnp_TxnRef = String.valueOf(olist_id);
            String vnp_OrderInfo = orderInfo;
            String vnp_Amount = String.valueOf((long) totalAmount);
            String vnp_Locale = "en";
            String vnp_IpAddr = VNPayConfig.getIpAddress(request);

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", VNPayConfig.vnp_Version);
            vnp_Params.put("vnp_Command", VNPayConfig.vnp_Command);
            vnp_Params.put("vnp_TmnCode", VNPayConfig.vnp_TmnCode);
            vnp_Params.put("vnp_Amount", vnp_Amount);
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.put("vnp_OrderType", "other");
            vnp_Params.put("vnp_Locale", vnp_Locale);
            vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            Date date = new Date();
            String vnp_CreateDate = formatter.format(date);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.MINUTE, 10);
            Date expireDate = calendar.getTime();
            String vnp_ExpireDate = formatter.format(expireDate);

            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            String queryUrl = VNPayConfig.hashAllFields(vnp_Params);
            String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;

            LOGGER.info("Redirecting to VNPay: " + paymentUrl);
            response.sendRedirect(paymentUrl);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in VNPayPaymentServlet", e);
            request.getSession().setAttribute("error", "An unexpected error occurred. Please try again.");
            response.sendRedirect(request.getContextPath() + "/order-summary.jsp");
        }
    }
}