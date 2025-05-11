<%@ page import="com.chilling.restaurant.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-chef.jsp" %>
<%
    User user = (User) session.getAttribute("user");
%>
<html>
<head><title>Update Profile - Chilling Restaurant</title></head>
<body>
    <h2>Update Your Information</h2>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red"><%= request.getParameter("error") %></p>
    <% } %>
    <% if (request.getParameter("success") != null) { %>
        <p style="color: green">Profile updated successfully!</p>
    <% } %>
    <form method="post" action="update-profile">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        Username: <input type="text" name="username" value="<%= user.getUsername() %>"><br>
        Current Password: <input type="password" name="currentPassword" required><br>
        New Password: <input type="password" name="password"><br>
        Confirm New Password: <input type="password" name="confirmPassword"><br>
        First Name: <input type="text" name="fname" value="<%= user.getFname() %>" required><br>
        Last Name: <input type="text" name="lname" value="<%= user.getLname() %>" required><br>
        Phone Number: <input type="text" name="phone" value="<%= user.getPhone() %>"><br>
        <button type="submit">Save</button>
    </form>
    <br>
    <a href="<%= request.getContextPath() %>/chef/schedule">Back to Schedule</a>
</body>
</html>