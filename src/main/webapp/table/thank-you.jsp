<%@page import="com.chilling.restaurant.model.Table"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Table table = (Table) session.getAttribute("table");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thank You</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/thank-you-style/styles17.css"/>
    <script type="text/javascript">
        window.onload = function() {
            setTimeout(function() {
                document.getElementById("auto-submit-form").submit();
            }, 5000);
        };
    </script>
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
    <h2>Thank you for your feedback!</h2>
    <p>Your rating and comment have been successfully submitted.</p>
    <p>Redirecting to login in 5 seconds...</p>
    <form id="auto-submit-form" action="/restaurant/table-login" method="post">
        <input type="hidden" name="id" value="<%= table.getTable_id()%>">
        <input type="hidden" name="password" value="<%= table.getTable_password()%>">
    </form>
</body>
</html>
