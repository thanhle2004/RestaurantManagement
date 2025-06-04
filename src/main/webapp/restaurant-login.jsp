<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chilling Restaurant</title>
    <link rel="stylesheet" href="assets/restaurant-login-style/styles1.css">
</head>
<body>
    <div class="login-wrapper" id="login-wrapper">
        <!-- Login Form -->
        <div class="login-container" id="login-form">
            <h2>Internal System Login</h2>
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert" id="alertBox"><%= error %></div>
            <% } %>
            <form method="post" action="restaurant-login">
                <label for="username">Your username</label>
                <input type="text" name="username" placeholder="username" required />

                <label for="password">Password</label>
                <input type="password" name="password" placeholder="●●●●●●●●" required />

                <div class="button-group">
                    <input type="submit" value="Sign in" />
                    <input type="button" value="Back" onclick="window.location.href='index.jsp'" />
                </div>
            </form>

            <div class="forgot-password-link">
                <a href="#" onclick="showForgotPasswordForm(); return false;">Forgot password?</a>
            </div>

            <% boolean managerExists = Boolean.TRUE.equals(request.getAttribute("managerExists")); %>
            <% if (!managerExists) { %>
                <div class="signup-link">
                    <a href="#" onclick="showSignUpForm(); return false;">Sign up for manager</a>
                </div>
            <% } %>
        </div>

        <!-- Sign Up Form -->
        <div class="login-container" id="signup-form" style="display: none;">
            <h2>Sign Up for Manager</h2>
            <form method="post" action="manager-register">
                <label for="signup-username">Username</label>
                <input type="text" id="signup-username" name="username" placeholder="username" required />

                <label for="signup-password">Password</label>
                <input type="password" id="signup-password" name="password" placeholder="●●●●●●●●" required />
                <div class="fullname">
                    <div class="name">
                        <label for="fname">First Name</label>
                        <input type="text" id="fname" name="fname" placeholder="First Name" required />
                    </div>
                    <div class="name">
                        <label for="lname">Last Name</label>
                        <input type="text" id="lname" name="lname" placeholder="Last Name" required />
                    </div>
                </div>

                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone" placeholder="Phone Number" required />

                <input type="hidden" name="role" value="manager">

                <div class="button-group">
                    <input type="submit" value="Sign up" />
                    <input type="button" value="Cancel" onclick="showLoginForm()" />
                </div>
            </form>
        </div>

        <!-- Forgot Password Form -->
        <div class="login-container" id="forgot-password-form" style="display: none;">
            <h2>Forgot Password</h2>
            <% String msg = (String) request.getAttribute("message"); %>
            <% if (msg != null) { %>
                <p style="color: green;"><%= msg %></p>
            <% } %>
            <form method="post" action="forgot-password">
                <label for="forgot-phone">Enter your phone number:</label>
                <input type="text" id="forgot-phone" name="phone" required />
                <div class="button-group">
                    <input type="submit" value="Send Verification Code" />
                    <input type="button" value="Back" onclick="showLoginForm()" />
                </div>
            </form>
        </div>

        <!-- OTP Verification Form -->
        <div class="login-container" id="otp-form" style="display: none;">
            <h2>Verify OTP</h2>
            <% String otpError = (String) request.getAttribute("error"); %>
            <% if (otpError != null) { %>
                <p style="color: red;"><%= otpError %></p>
            <% } %>
            <% String phone = (String) session.getAttribute("phone"); %>
            <p>Enter the code sent to: <strong><%= phone %></strong></p>
            <form method="post" action="verify-otp">
                <label for="otp">OTP</label>
                <input type="text" id="otp" name="otp" required />
                <div class="button-group">
                    <input type="submit" value="Verify" />
                    <input type="button" value="Cancel" onclick="showLoginForm()" />
                </div>
            </form>
        </div>

        <!-- Reset Password Form -->
        <div class="login-container" id="reset-password-form" style="display: none;">
            <h2>Reset Your Password</h2>
            <% String resetError = (String) request.getAttribute("resetError"); %>
            <% if (resetError != null) { %>
                <p style="color: red;"><%= resetError %></p>
            <% } %>
            <form method="post" action="reset-password" id="reset-password-form-element">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>

                <label for="confirmNewPassword">Confirm New Password:</label>
                <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>
                <p id="passwordMismatch" style="color: red; display: none;">Passwords do not match!</p>

                <div class="button-group">
                    <input type="submit" value="Reset Password" />
                    <input type="button" value="Cancel" onclick="showLoginForm()" />
                </div>
            </form>
        </div>

        <!-- Image -->
        <div class="login-image" id="login-image">
            <img src="assets/restaurant-login-style/login-restaurant.jpg" alt="Restaurant" />
        </div>
    </div>

    <script>
        window.onload = function () {
            <% if ("true".equals(String.valueOf(request.getAttribute("showResetPasswordForm")))) { %>
                showResetPasswordForm();
            <% } else if ("true".equals(String.valueOf(request.getAttribute("showOtpForm")))) { %>
                showOTPForm();
            <% } else if ("true".equals(String.valueOf(request.getAttribute("showForgotPasswordForm")))) { %>
                showForgotPasswordForm();
            <% } else if ("true".equals(String.valueOf(request.getAttribute("showSignUpForm")))) { %>
                showSignUpForm();
            <% } else { %>
                showLoginForm();
            <% } %>

            const alertBox = document.getElementById('alertBox');
            if (alertBox) {
                setTimeout(() => {
                    alertBox.remove();
                }, 3000);
            }

            // Password matching validation
            const resetForm = document.getElementById('reset-password-form-element');
            if (resetForm) {
                resetForm.addEventListener('submit', function (event) {
                    const newPassword = document.getElementById('newPassword').value;
                    const confirmNewPassword = document.getElementById('confirmNewPassword').value;
                    const passwordMismatch = document.getElementById('passwordMismatch');

                    if (newPassword !== confirmNewPassword) {
                        event.preventDefault();
                        passwordMismatch.style.display = 'block';
                    } else {
                        passwordMismatch.style.display = 'none';
                    }
                });
            }
        };

        function showLoginForm() {
            hideAllForms();
            document.getElementById("login-form").style.display = "block";
        }

        function showSignUpForm() {
            hideAllForms();
            document.getElementById("signup-form").style.display = "block";
        }

        function showForgotPasswordForm() {
            hideAllForms();
            document.getElementById("forgot-password-form").style.display = "block";
        }

        function showOTPForm() {
            hideAllForms();
            document.getElementById("otp-form").style.display = "block";
        }

        function showResetPasswordForm() {
            hideAllForms();
            document.getElementById("reset-password-form").style.display = "block";
        }

        function hideAllForms() {
            document.getElementById("login-form").style.display = "none";
            document.getElementById("signup-form").style.display = "none";
            document.getElementById("forgot-password-form").style.display = "none";
            document.getElementById("otp-form").style.display = "none";
            document.getElementById("reset-password-form").style.display = "none";
        }
    </script>
</body>
</html>