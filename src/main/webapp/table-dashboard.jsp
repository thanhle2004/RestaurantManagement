<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String tableNumber = (String) session.getAttribute("tableNumber");
    String status = (String) session.getAttribute("tableStatus");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chilling Restaurant</title>
    </head>
    <body>
        <aside>
            <a href="#Home">Home</a>
            <a href="table-menu">Menu</a>
        </aside>
    </body>
</html>
