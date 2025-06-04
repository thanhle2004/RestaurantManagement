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
                case "general":
                    String newFname = request.getParameter("fname");
                    String newLname = request.getParameter("lname");
                    String newPhone = request.getParameter("phone");

                    if (newFname == null || newFname.trim().isEmpty() ||
                        newLname == null || newLname.trim().isEmpty() ||
                        newPhone == null || newPhone.trim().isEmpty()) {
                        throw new Exception("All fields are required");
                    }

                    updatedUser.setFname(newFname.trim());
                    updatedUser.setLname(newLname.trim());
                    updatedUser.setPhone(newPhone.trim());
                    break;

                case "password":
                    String currentPassword = request.getParameter("currentPassword");
                    String newPassword = request.getParameter("newValue");

                    if (currentPassword == null || !currentPassword.equals(currentUser.getPassword())) {
                        throw new Exception("Invalid current password");
                    }

                    if (newPassword == null || newPassword.trim().isEmpty()) {
                        throw new Exception("New password cannot be empty");
                    }

                    updatedUser.setPassword(newPassword.trim());
                    break;

                default:
                    throw new Exception("Unsupported update field: " + field);
            }

            userDAO.updateUser(updatedUser);
            session.setAttribute("user", updatedUser);
            response.sendRedirect(request.getContextPath() + "/manager/view-profile?success=true");

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manager/view-profile?error=" + e.getMessage());
        }
    }
}