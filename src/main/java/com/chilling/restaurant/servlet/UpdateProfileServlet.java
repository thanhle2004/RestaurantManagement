package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.UserDAO;
import com.chilling.restaurant.model.User;
import com.chilling.restaurant.utils.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/chef/update-profile")
public class UpdateProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.checkRole(request, response, "chef")) return;

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/chef/update-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.checkRole(request, response, "chef")) return;

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        User updatedUser = new User();
        updatedUser.setUserId(currentUser.getUserId());

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String username = request.getParameter("username");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");

        // Kiểm tra mật khẩu hiện tại
        if (!currentUser.getPassword().equals(currentPassword)) {
            response.sendRedirect(request.getContextPath() + "/chef/update-profile?error=Invalid current password");
            return;
        }

        // Kiểm tra và cập nhật mật khẩu mới
        if (newPassword != null && !newPassword.isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/chef/update-profile?error=Passwords do not match");
                return;
            }
            updatedUser.setPassword(newPassword);
        } else {
            updatedUser.setPassword(currentUser.getPassword());
        }

        // Kiểm tra và cập nhật username
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/chef/update-profile?error=Username cannot be empty");
            return;
        }
        updatedUser.setUsername(username); // Cập nhật username mới
        updatedUser.setFname(fname);
        updatedUser.setLname(lname);
        updatedUser.setPhone(phone);
        updatedUser.setRole(currentUser.getRole());

        try {
            userDAO.updateUser(updatedUser);
            session.setAttribute("user", updatedUser); // Cập nhật session với thông tin mới
            response.sendRedirect(request.getContextPath() + "/chef/update-profile?success=true");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/chef/update-profile?error=Update failed: " + e.getMessage());
        }
    }
}