<%@ page import="com.chilling.restaurant.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-chef.jsp" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chef Profile</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/update-profile-style/styles18.css">
    <link rel="icon" href="assets/index-style/chilling_burger.png"/>
</head>
<body>
    <% if (request.getParameter("error") != null) { %>
        <div class="alert" id="alertBox"><%= request.getParameter("error") %></div>
    <% } %>
    <% if ("true".equals(request.getParameter("success"))) { %>
        <div class="alert success" id="alertBox">Profile updated successfully!</div>
    <% } %>
    
    <div class="container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <h2>Hello, <%= user.getFname() %></h2>
            <a href="<%= request.getContextPath() %>/chef/schedule">Schedule</a>
            <a href="<%= request.getContextPath() %>/check-manager">Log out</a>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Your Profile</h1>
            <div class="cards-container">
                <!-- General Information Card -->
                <section class="profile-section">
                    <h2>General Information</h2>
                    <div class="profile-info">
                        <div class="avatar">
                        </div>
                        <div class="info-details">
                            <div class="info-row">
                                <label>First Name:</label>
                                <span><%= user.getFname() %></span>
                            </div>
                            <div class="info-row">
                                <label>Last Name:</label>
                                <span><%= user.getLname() %></span>
                            </div>
                            <div class="info-row">
                                <label>Phone Number:</label>
                                <span><%= user.getPhone() %></span>
                            </div>
                            <div class="button-container">
                                <button onclick="showModal('general', 'Update General Information')">Update</button>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Security Card -->
                <section class="security-section">
                    <h2>Security</h2>
                    <div class="security-info">
                        <div class="info-row">
                            <label>Username</label>
                            <span><%= user.getUsername() %></span>
                        </div>
                        <div class="info-row">
                            <label>Password</label>
                            <span>********</span>
                        </div>
                        </div>
                        <div class="button-container" style="padding-top:40px">
                            <button onclick="showModal('password', 'Change Password', '')">Change Password</button>
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>

    <!-- Modal Overlay -->
    <div id="modal-overlay" class="hidden">
        <div class="modal-box">
            <form id="editForm" method="post" action="update-profile">
                <input type="hidden" name="field" id="field">
                <h2 id="modal-title">Change</h2>
                
                <div id="general-form" style="display: none;">
                    <label for="fname">First Name:</label>
                    <input type="text" name="fname" id="fname" value="<%= user.getFname() %>" required><br>
                    <label for="lname">Last Name:</label>
                    <input type="text" name="lname" id="lname" value="<%= user.getLname() %>" required><br>
                    <label for="phone">Phone Number:</label>
                    <input type="text" name="phone" id="phone" value="<%= user.getPhone() %>" required><br>
                </div>
                
                <div id="single-form" style="display: none;">
                    <label id="label" for="currentPassword">Current Password:</label>
                    <input type="password" name="currentPassword" id="currentPassword"><br>
                    <label id="label" for="newValue">New Password:</label>
                    <input type="password" name="newValue" id="newValue"><br>
                </div>
                <div class="button-container">
                    <button type="submit">Update</button>
                    <button type="button" onclick="closeModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        function showModal(field, title, value) {
            document.getElementById('field').value = field;
            document.getElementById('modal-title').innerText = title;

            if (field === 'general') {
                document.getElementById('general-form').style.display = 'block';
                document.getElementById('single-form').style.display = 'none';
            } else {
                document.getElementById('general-form').style.display = 'none';
                document.getElementById('single-form').style.display = 'block';
                document.getElementById('newValue').type = field === 'password' ? 'password' : 'text';
                document.getElementById('newValue').value = value || '';
            }

            document.getElementById('modal-overlay').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('modal-overlay').style.display = 'none';
        }
        
        window.onload = function () {
            const alertBox = document.getElementById('alertBox');
            if (alertBox) {
                setTimeout(() => {
                    alertBox.remove();
                }, 5000);
            }
        };
    </script>
</body>
</html>
