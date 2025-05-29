<%@ page import="java.util.*, com.chilling.restaurant.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<%
    List<User> users = (List<User>) request.getAttribute("chefList");
%>

<html>
<head>
    <title>Chilling Restaurant</title>
    <link rel="stylesheet" href="../assets/chef-management-style/styles6.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap" rel="stylesheet">
    <style>
    html, body {
      height: 100%;
      overflow: auto;
      scrollbar-width: none; /* Firefox */
    }

    html::-webkit-scrollbar,
    body::-webkit-scrollbar {
      display: none; /* Chrome, Safari, Edge */
    }
    </style>
    <script>
        function enterFullScreen() {
            const elem = document.documentElement; 

            if (elem.requestFullscreen) {
              elem.requestFullscreen();
            } else if (elem.webkitRequestFullscreen) { 
              elem.webkitRequestFullscreen();
            } else if (elem.msRequestFullscreen) { 
              elem.msRequestFullscreen();
            }
        }

        function exitFullScreen() {
            if (document.exitFullscreen) {
              document.exitFullscreen();
            } else if (document.webkitExitFullscreen) { 
              document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) { 
              document.msExitFullscreen();
            }
        }
    </script>
</head>
<header class="manager-header">
    <a href="manager-dashboard.jsp" class="back-button header-back">← Back</a>
</header>
<body>
    <h2>Chef List</h2>
    <a href="<%= request.getContextPath() %>/manager/chef-register.jsp" class="add-btn">➕ Add chef</a>
    <table>
      <thead>
        <tr>
          <th>N.0</th><th>Username</th><th>First name</th><th>Last name</th><th>Phone number</th><th>Action</th>
        </tr>
      </thead>
      <tbody>
        <% int n = 0;
           for (User user : users) {
             if (user.getRole().equals("chef")) {
               n++;
        %>
        <tr>
          <td><%= n %></td>
          <td><%= user.getUsername() %></td>
          <td><%= user.getFname() %></td>
          <td><%= user.getLname() %></td>
          <td><%= user.getPhone() %></td>
          <td>
            <a href="chef-edit?id=<%= user.getUserId() %>">Edit</a> |
            <a href="chef-delete?id=<%= user.getUserId() %>" onclick="return confirm('Delete this account?')">Delete</a>
          </td>
        </tr>
        <% } } %>
      </tbody>
    </table>
</body>
</html>