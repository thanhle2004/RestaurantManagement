<%@ page import="com.chilling.restaurant.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<%
   User user = (User) request.getAttribute("user");
%>
<html>
<head>
    <title>Chilling Restaurant</title>
    <link rel="stylesheet" href="../assets/chef-edit-style/styles8.css"/>
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
<body>
    <header class="manager-header">
        <a href="manager-dashboard.jsp" class="back-button header-back">← Back</a>
    </header>
    <h2 class="form-title">Edit Information</h2>
    <div class="form-container">
        <form method="post" action="chef-update">
            <input type="hidden" name="id" value="<%= user.getUserId() %>">
            <label>
                <span>Username</span>
                <input type="text" name="username" value="<%= user.getUsername() %>" readonly>
            </label>
            <label>
                <span>Password</span>
                <input type="text" name="password" value="<%= user.getPassword() %>" readonly>
            </label>
            <label>
                <span>First Name</span>
                <input type="text" name="fname" value="<%= user.getFname() %>" required>
            </label>
            <label>
                <span>Last Name</span>
                <input type="text" name="lname" value="<%= user.getLname() %>" required>
            </label>
            <label>
                <span>Phone number</span>
                <input type="text" name="phone" value="<%= user.getPhone() %>">
            </label>
            <input type="hidden" name="role" value="<%= user.getRole() %>">
            <button type="submit" class="custom-button">Update</button>
        </form>
    </div>
</body>
</html>