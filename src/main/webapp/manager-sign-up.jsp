<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Chilling Restaurant</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="assets/restaurant-login-style/styles1.css">
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
        <a href="check-manager" class="back-button header-back">&larr; Back</a>
    </header>
    <h2 class="form-title">Hello my new manager</h2>
    <div class="form-container">
        <form method="post" action="manager-register">
            <label>
                <span>Username</span>
                <input type="text" name="username" required>
            </label>
            <label>
                <span>Password</span>
                <input type="password" name="password" required>
            </label>
            <label>
                <span>First Name</span>
                <input type="text" name="fname" required>
            </label>
            <label>
                <span>Last Name</span>
                <input type="text" name="lname" required>
            </label>
            <label>
                <span>Phone Number</span>
                <input type="text" name="phone">
            </label>
            <input type="hidden" name="role" value="manager">
            <button type="submit" class="custom-button">Sign up</button>
        </form>
    </div>
</body>
</html>