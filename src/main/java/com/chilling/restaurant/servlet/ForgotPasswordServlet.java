package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Random;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");
        System.out.println(1);

        try {
            UserDAO userDAO = new UserDAO();

            if (!userDAO.checkPhoneExists(phone)) {
                request.setAttribute("error", "Phone number not found!");
                request.setAttribute("showForgotPasswordForm", true);
                request.getRequestDispatcher("/restaurant-login.jsp").forward(request, response);
                return;
            }

            System.out.println(2);
            String otp = String.valueOf(new Random().nextInt(900000) + 100000);

            System.out.println(3);
            HttpSession session = request.getSession();
            System.out.println(4);
            session.setAttribute("phone", phone);
            System.out.println(5);
            session.setAttribute("otp", otp);
            System.out.println(6);
            session.setAttribute("otpExpiry", System.currentTimeMillis() + 5 * 60 * 1000); // 5 minutes
            System.out.println(7);

            request.setAttribute("showOtpForm", true);
            request.setAttribute("sentPhone", phone); 
            request.setAttribute("otp", otp); 
            System.out.println("Generated OTP for phone " + phone + " is: " + otp);
            request.getRequestDispatcher("/restaurant-login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.setAttribute("showForgotPasswordForm", true);
            request.getRequestDispatcher("/restaurant-login.jsp").forward(request, response);
        }
    }
}
