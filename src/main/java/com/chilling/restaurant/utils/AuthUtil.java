package com.chilling.restaurant.utils;

import jakarta.servlet.http.*;

public class AuthUtil {
    public static boolean checkRole(HttpServletRequest request, HttpServletResponse response, String requiredRole) throws java.io.IOException {
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        if (role == null || !role.equals(requiredRole)) {
            response.sendRedirect("access-denied.jsp");
            return false;
        }
        return true;
    }
}
