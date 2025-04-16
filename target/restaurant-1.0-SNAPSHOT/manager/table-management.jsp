<%@ page import="java.util.*, com.chilling.restaurant.model.Table" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Table> tableTypeTwoList = (List<Table>) request.getAttribute("tableTypeTwoList");
    List<Table> tableTypeFourList = (List<Table>) request.getAttribute("tableTypeFourList");
    List<Table> tableTypeEightList = (List<Table>) request.getAttribute("tableTypeEightList");
    
    int twoCount = 1;
    int fourCount = 1;
    int eightCount = 1;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chilling Restaurant</title>
    </head>
    <body>
    <h2>Tables</h2>
    <form action="table-change-password" method="post">
        Password: <input type="text" name="password" placeholder="Enter new password" required/>
        <button type="submit">Change password</button>
    </form>
    <h3>Two seats</h3>
    <a href="${pageContext.request.contextPath}/manager/table-create?type=2">➕ Add table</a>
    <table border="1" cellpadding="5">
        <tr>
    <th>N.0</th>
    <th>Table Number</th>
    <th>Table Status</th>
    <th>Table Password</th>
    <th>Action</th>
</tr>
<%
    for (Table table : tableTypeTwoList) {
        
%>
<tr>
    <td><%= twoCount %></td>
        <td><%= table.getTable_number() %></td>
    <td><%= table.getTable_status() %></td>
    <td><%= table.getTable_password() %></td>
    <td>
        <a href="table-delete?id=<%= table.getTable_id() %>" onclick="return confirm('Delete this table?')">Delete</a>
    </td>
</tr>
<%
        twoCount++;
    }
%>

    </table>

    <h3>Four seats</h3>
    <a href="${pageContext.request.contextPath}/manager/table-create?type=4">➕ Add table</a>
    <table border="1" cellpadding="5">
        <tr>
            <th>N.0</th>
            <th>Table Number</th>
            <th>Table Status</th>
            <th>Table Password</th>
            <th>Action</th>
        </tr>
<%
    for (Table table : tableTypeFourList) {
%>
<tr>
    <td><%= fourCount %></td>
    <td><%= table.getTable_number() %></td>
    <td><%= table.getTable_status() %></td>
    <td><%= table.getTable_password() %></td>
    <td>
        <a href="table-delete?id=<%= table.getTable_id() %>" onclick="return confirm('Delete this table?')">Delete</a>
    </td>
</tr>
<%
        fourCount++;
    }
%>

    </table>

<h3>Eight seats</h3>
    <a href="${pageContext.request.contextPath}/manager/table-create?type=8">➕ Add table</a>
    <table border="1" cellpadding="5">
        <tr>
    <th>N.0</th>
    <th>Table Number</th>
    <th>Table Status</th>
    <th>Table Password</th>
    <th>Action</th>
</tr>
<%
    for (Table table : tableTypeEightList) {
%>
<tr>
    <td><%= eightCount %></td>
    <td><%= table.getTable_number() %></td>
    <td><%= table.getTable_status() %></td>
    <td><%= table.getTable_password() %></td>
    <td>
        <a href="table-delete?id=<%= table.getTable_id() %>" onclick="return confirm('Delete this table?')">Delete</a>
    </td>
</tr>
<%
        eightCount++;
    }
%>

    </table>
</body>
</html>
