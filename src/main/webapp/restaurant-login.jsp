<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chilling Restaurant</title>
    <link rel="stylesheet" href="assets/restaurant-login-style/styles1.css">

</head>

<body>
    <div class="login-wrapper">
        <div class="login-container">
            <h2>Sign in</h2>
            <form method="post" action="restaurant-login">
                <label for="username">Your username</label>
                <input type="text" name="username" placeholder="you@example.com" />

                <label for="password">Password</label>
                <input type="password" name="password" placeholder="●●●●●●●●" />

                <div class="button-group">
                    <input type="submit" value="Sign in" />
                    <input type="button" value="Back" onclick="window.location.href='index.jsp'" />
                </div>
            </form>
            <div class="signup-link">
                Don’t have an account? <a href="#">Sign up</a>
            </div>
        </div>
        <div class="login-image">
            <img src="assets/restaurant-login-style/login-restaurant.jpg" alt="alt"/>
        </div>
    </div>
</body>

</html>
