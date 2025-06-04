<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chilling Restaurant</title>
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
    <h2>Forgot Password</h2>
    
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <label for="phone">Enter your phone number:</label><br>
        <input type="text" id="phone" name="phone" required><br><br>
        <button type="submit">Send Verification Code</button>
    </form>
</body>
</html>