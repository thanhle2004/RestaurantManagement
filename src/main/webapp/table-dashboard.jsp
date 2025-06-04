<%@page import="com.chilling.restaurant.model.Table"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Table table = (Table) session.getAttribute("table");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chilling Restaurant</title>
        <link rel="stylesheet" href="assets/table-dashboard-style/styles11.css"/>
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
            <a href="index.jsp" class="back-button header-back">← Back</a>
        </header> 
        <aside class="table-info">
            <h1>TABLE</h1>
            <h1><%= table.getTable_number() %></h1>
            <form action="table-menu" method="get">
                <input type="hidden" name="action" id="action" value="create-order" />
                <input type="submit" value="Order" class="custom-button"/>
            </form>
        </aside>
    </body>
</html>
