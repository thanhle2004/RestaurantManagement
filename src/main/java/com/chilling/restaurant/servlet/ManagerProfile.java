package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.UserDAO;
import com.chilling.restaurant.model.User;
import com.chilling.restaurant.utils.AuthUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/manager/view-profile")
public class ManagerProfile extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.checkRole(request, response, "manager")) return;

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/manager/view-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtil.checkRole(request, response, "manager")) return;

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String field = request.getParameter("field");
        String userId = request.getParameter("userId");
        String currentPassword = request.getParameter("currentPassword");

        if (userId == null || !userId.equals(String.valueOf(currentUser.getUserId()))) {
            response.sendRedirect(request.getContextPath() + "/manager/view-profile?error=Invalid user ID");
            return;
        }

        User updatedUser = new User();
        updatedUser.setUserId(currentUser.getUserId());
        updatedUser.setUsername(currentUser.getUsername());
        updatedUser.setFname(currentUser.getFname());
        updatedUser.setLname(currentUser.getLname());
        updatedUser.setPhone(currentUser.getPhone());
        updatedUser.setPassword(currentUser.getPassword());
        updatedUser.setRole(currentUser.getRole());

        try {
            switch (field) {
                case "username":
                    String newUsername = request.getParameter("username");
                    if (newUsername == null || newUsername.trim().isEmpty()) {
                        throw new Exception("Username cannot be empty");
                    }
                    if (currentPassword == null || !currentPassword.equals(currentUser.getPassword())) {
                        throw new Exception("Invalid current password");
                    }
                    updatedUser.setUsername(newUsername);
                    break;

                case "password":
                    String newPassword = request.getParameter("newPassword");

                    if (currentPassword == null || !currentPassword.equals(currentUser.getPassword())) {
                        throw new Exception("Invalid current password");
                    }
                    if (newPassword == null || newPassword.trim().isEmpty()) {
                        throw new Exception("New password cannot be empty");
                    }
                    updatedUser.setPassword(newPassword);
                    break;

                case "fname":
                    String newFirstname = request.getParameter("fname");
                    if (newFirstname == null || newFirstname.trim().isEmpty()) {
                        throw new Exception("First name cannot be empty");
                    }
                    if (currentPassword == null || !currentPassword.equals(currentUser.getPassword())) {
                        throw new Exception("Invalid current password");
                    }
                    updatedUser.setFname(newFirstname);
                    break;

                case "lname":
                    String newLastname = request.getParameter("lname");
                    if (newLastname == null || newLastname.trim().isEmpty()) {
                        throw new Exception("Last name cannot be empty");
                    }
                    if (currentPassword == null || !currentPassword.equals(currentUser.getPassword())) {
                        throw new Exception("Invalid current password");
                    }
                    updatedUser.setLname(newLastname);
                    break;

                case "phone":
                    String newPhonenumber = request.getParameter("phone");
                    if (newPhonenumber == null || newPhonenumber.trim().isEmpty()) {
                        throw new Exception("Phone number cannot be empty");
                    }
                    if (currentPassword == null || !currentPassword.equals(currentUser.getPassword())) {
                        throw new Exception("Invalid current password");
                    }
                    updatedUser.setPhone(newPhonenumber);
                    break;

                default:
                    throw new Exception("Unknown field");
            }

            userDAO.updateUser(updatedUser);
            session.setAttribute("user", updatedUser);
            response.sendRedirect(request.getContextPath() + "/manager/view-profile?success=true");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manager/view-profile?error=" + e.getMessage());
        }
    }
}
