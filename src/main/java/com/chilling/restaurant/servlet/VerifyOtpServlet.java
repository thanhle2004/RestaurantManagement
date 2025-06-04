package com.chilling.restaurant.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String userOtp = request.getParameter("otp");

        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");
        Long expiry = (Long) session.getAttribute("otpExpiry");

        if (sessionOtp != null && sessionOtp.equals(userOtp) && expiry != null && expiry > System.currentTimeMillis()) {
        request.setAttribute("showResetPasswordForm", "true");
        request.getRequestDispatcher("/restaurant-login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid or expired OTP. Please try again.");
            request.setAttribute("showOtpForm", true);
            request.getRequestDispatcher("restaurant-login.jsp").forward(request, response);
        }
    }
}
