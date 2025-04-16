<%@ page import="com.chilling.restaurant.model.User" %>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<%
   User user = (User) request.getAttribute("user");
%>
<html>
<head><title>Chilling Restaurant</title></head>
<body>
    <h2>Edit Information</h2>
    <form method="post" action="chef-update">
        <input type="hidden" name="id" value="<%= user.getId() %>">
        Username: <input type="text" name="username" value="<%= user.getUsername() %>" readonly><br>
        Password: <input type="text" name="password" value="<%= user.getPassword() %>" readonly><br>
        First Name: <input type="text" name="lname" value="<%= user.getLname() %>" required><br>
        Last Name: <input type="text" name="fname" value="<%= user.getFname() %>" required><br>
        Phone number: <input type="text" name="phone" value="<%= user.getPhone() %>"><br>
        <input type="hidden" name="role" value="<%= user.getRole() %>">
        <button type="submit">Update</button>
    </form>
</body>
</html>
