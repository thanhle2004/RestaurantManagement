<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chilling Restaurant</title>
        <link rel="stylesheet" href="../assets/manager-dashboard-style/styles2.css"/> 
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&display=swap" rel="stylesheet">
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
        <a href="/restaurant/check-manager" class="back-button header-back">← Log Out</a>
    </header>
    <body>
        <h1 class="title">Hello Manager</h1> 

        <div class="button-container">
            <div class="button-row">
                <a href="chef-management" class="custom-button">Chefs</a>
                <a href="table-management" class="custom-button">Tables</a>
                <a href="menu-management" class="custom-button">Menu</a>
            </div>
            <div class="button-row">
                <a href="view-record" class="custom-button">Records</a>
                <a href="<%= request.getContextPath() %>/manager/view-stats.jsp" class="custom-button">Stats</a>
                <a href="view-profile" class="custom-button">Profile</a>
            </div>
        </div>

    </body>
</html>
