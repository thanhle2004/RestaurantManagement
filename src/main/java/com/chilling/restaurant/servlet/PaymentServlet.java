package com.chilling.restaurant.servlet;

import com.chilling.restaurant.model.OrderList;
import com.chilling.restaurant.service.QRCodeGenerator;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;

@WebServlet("/table/payment")
public class PaymentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {
        try {
            // 1. Lấy thông tin Order từ session
            OrderList orderList = (OrderList) request.getSession().getAttribute("orderList");
            String raw = request.getParameter("totalAmount").replace(",", ".");
            double amt = Double.parseDouble(raw);
            int amount = (int) (amt * 100);

            String orderId = String.valueOf(orderList.getOrderList_id());

            // 2. Tạo URL thanh toán VNPay (demo)
            String paymentUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html"
                    + "?vnp_TxnRef=" + orderId
                    + "&vnp_Amount=" + amount
                    + "&vnp_CurrCode=VND"
                    + "&vnp_Terminal=WEB"
                    + "&vnp_TransactionType=00"
                    + "&vnp_OrderInfo=" + java.net.URLEncoder.encode("Thanh toán đơn " + orderId, "UTF-8")
                    + "&vnp_ReturnUrl=" + java.net.URLEncoder.encode(
                        request.getRequestURL().toString().replace(request.getServletPath(), "/payment-success.jsp"),
                        "UTF-8"
                    );

            // 3. Tạo folder images trong webapp nếu chưa có
            ServletContext ctx = request.getServletContext();
            String imagesPath = ctx.getRealPath("/images");
            File imagesDir = new File(imagesPath);
            if (!imagesDir.exists()) imagesDir.mkdirs();

            String qrFileName = orderId + "_qr.png";
            String qrFullPath = imagesPath + File.separator + qrFileName;
            QRCodeGenerator.generateQRCode(paymentUrl, qrFullPath);

            request.setAttribute("paymentUrl", paymentUrl);
            request.setAttribute("qrFileName", qrFileName);

            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}