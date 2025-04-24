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
    </head>
    <body>
        <aside>
            <h1>Table</h1>
            <h1><%= table.getTable_number() %></h1>
            <a href="table-menu">Order</a>
        </aside>
    </body>
</html>
