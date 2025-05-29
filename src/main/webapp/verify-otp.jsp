<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chilling Restaurant</title>
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
    <h2>Verify OTP</h2>

    <% String phone = (String) session.getAttribute("phone"); %>
    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <label>OTP sent to phone <%= phone %>:</label><br>
        <input type="text" name="otp" required><br><br>
        <button type="submit">Verify</button>
    </form>

    <% String otp = (String) request.getAttribute("otp"); %>
</body>
</html>