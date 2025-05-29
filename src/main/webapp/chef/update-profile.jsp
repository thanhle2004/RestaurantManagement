<%@ page import="com.chilling.restaurant.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-chef.jsp" %>
<%
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>Chilling Restaurant</title>
    <style>
        .modal-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            display: none;
            justify-content: center;
            align-items: center;
        }

        .modal-box {
            background: white;
            padding: 20px;
            border-radius: 10px;
            min-width: 300px;
        }

        .modal-box input {
            margin-bottom: 10px;
            width: 100%;
        }
    </style>
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
<h2>Your Information</h2>

<% if (request.getParameter("error") != null) { %>
    <p style="color: red"><%= request.getParameter("error") %></p>
<% } %>
<% if ("true".equals(request.getParameter("success"))) { %>
    <p style="color: green">Profile updated successfully!</p>
<% } %>

<div>
    <strong>Username:</strong> <%= user.getUsername() %> 
    <button onclick="showModal('username', 'Change Username', '<%= user.getUsername() %>')">Change</button><br><br>

    <strong>Password:</strong> ******** 
    <button onclick="showModal('password', 'Change Password', '')">Change</button><br><br>

    <strong>First Name:</strong> <%= user.getFname() %> 
    <button onclick="showModal('fname', 'Change First Name', '<%= user.getFname() %>')">Change</button><br><br>

    <strong>Last Name:</strong> <%= user.getLname() %> 
    <button onclick="showModal('lname', 'Change Last Name', '<%= user.getLname() %>')">Change</button><br><br>

    <strong>Phone:</strong> <%= user.getPhone() %> 
    <button onclick="showModal('phone', 'Change Phone Number', '<%= user.getPhone() %>')">Change</button><br><br>
</div>

<div id="modal-overlay" class="modal-overlay">
    <div class="modal-box">
        <form method="post" action="<%= request.getContextPath() %>/chef/update-profile">
            <input type="hidden" name="field" id="modal-field">
            <input type="hidden" name="userId" id="modal-userId">

            <h3 id="modal-label"></h3>

            <div id="modal-generic">
                <input type="text" id="modal-input" name="" placeholder=""><br>
                <input type="password" id="generic-currentPassword" name="currentPassword" placeholder="Enter Password">
            </div>

            <div id="modal-password" style="display: none;">
                <input type="password" id="password-currentPassword" name="currentPassword" placeholder="Current Password"><br>
                <input type="password" name="newPassword" placeholder="New Password">
            </div>

            <button type="submit">Save</button>
            <button type="button" onclick="closeModal()">Cancel</button>
        </form>
    </div>
</div>

<a href="<%= request.getContextPath() %>/chef/schedule">Back</a>

<script>
    function showModal(field, label, currentValue) {
        document.getElementById('modal-overlay').style.display = 'flex';
        document.getElementById('modal-label').innerText = label;
        document.getElementById('modal-field').value = field;
        document.getElementById('modal-userId').value = "<%= user.getUserId() %>";

        const modalPassword = document.getElementById('modal-password');
        const modalGeneric = document.getElementById('modal-generic');
        const input = document.getElementById('modal-input');

        // Reset visibility
        modalPassword.style.display = 'none';
        modalGeneric.style.display = 'none';

        // Disable both currentPassword inputs
        document.getElementById('generic-currentPassword').disabled = true;
        document.getElementById('password-currentPassword').disabled = true;

        if (field === 'password') {
            modalPassword.style.display = 'block';
            document.getElementById('password-currentPassword').disabled = false;
        } else {
            modalGeneric.style.display = 'block';
            input.name = field;
            input.value = currentValue;
            document.getElementById('generic-currentPassword').disabled = false;
        }
    }
</script>
</body>
</html>
