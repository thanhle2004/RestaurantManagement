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

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Table table = (Table) session.getAttribute("table");
        Meal meal = (Meal) session.getAttribute("meal");
        
        String orderInfo = request.getParameter("orderInfo");
        int olist_id = Integer.parseInt(request.getParameter("orderId"));

        String amountStr = request.getParameter("amount");
        double totalAmount = Double.parseDouble(amountStr);
        
        Bill bill = new Bill();
        bill.setOlist_id(olist_id);
        bill.setAmount(totalAmount);
        bill.setPayment_status("unpaid");
        
        BillDAO billDAO = new BillDAO();
        bill.setBill_id(billDAO.createBill(bill));
        System.out.println("bill id: " + bill.getBill_id());
        meal.setBillId(bill.getBill_id());
        
        MealDAO mealDAO = new MealDAO();
         try {
             mealDAO.updateBillIdInMeal(meal);
         } catch (SQLException ex) {
             Logger.getLogger(VNPayPaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
         }
        session.setAttribute("meal", meal);
        session.setAttribute("bill", bill);
        session.setAttribute("table", table);

        String vnp_TxnRef = String.valueOf(olist_id); 
        String vnp_OrderInfo = orderInfo;
        String vnp_Amount = amountStr;
        String vnp_Locale = "en";
        String vnp_IpAddr = VNPayConfig.getIpAddress(request);

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", VNPayConfig.vnp_Version);
        vnp_Params.put("vnp_Command", VNPayConfig.vnp_Command);
        vnp_Params.put("vnp_TmnCode", VNPayConfig.vnp_TmnCode);
        vnp_Params.put("vnp_Amount", vnp_Amount);
        vnp_Params.put("vnp_CurrCode", "USD");
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

        response.sendRedirect(paymentUrl);
    }
}
