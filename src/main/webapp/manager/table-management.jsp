<%@ page import="java.util.*, com.chilling.restaurant.model.Table" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<%
    List<Table> tableTypeTwoList = (List<Table>) request.getAttribute("tableTypeTwoList");
    List<Table> tableTypeFourList = (List<Table>) request.getAttribute("tableTypeFourList");
    List<Table> tableTypeEightList = (List<Table>) request.getAttribute("tableTypeEightList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chilling Restaurant</title>
    <link rel="stylesheet" href="../assets/table-management-style/styles9.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap" rel="stylesheet">
</head>
<header class="manager-header">
    <a href="manager-dashboard.jsp" class="back-button header-back">← Back</a>
</header>
<body>
    <h2>Tables</h2>
    <form action="table-change-password" method="post" class="password-form">
        <label>Password:</label>
        <input type="text" name="password" placeholder="Enter new password" required/>
        <button type="submit" class="custom-button">Change password</button>
    </form>
    <h3>Two seats</h3>
    <a href="${pageContext.request.contextPath}/manager/table-create?type=2" class="add-btn">➕ Add table</a>
    <table>
        <thead>
            <tr><th>N.0</th><th>Table Number</th><th>Table Status</th><th>Table Password</th><th>Action</th></tr>
        </thead>
        <tbody>
            <% int n = 1; for (Table table : tableTypeTwoList) { %>
            <tr>
                <td><%= n++ %></td>
                <td><%= table.getTable_number() %></td>
                <td><%= table.getTable_status() %></td>
                <td><%= table.getTable_password() %></td>
                <td><a href="table-delete?id=<%= table.getTable_id() %>" onclick="return confirm('Delete this table?')">Delete</a></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <h3>Four seats</h3>
    <a href="${pageContext.request.contextPath}/manager/table-create?type=4" class="add-btn">➕ Add table</a>
    <table>
        <thead>
            <tr><th>N.0</th><th>Table Number</th><th>Table Status</th><th>Table Password</th><th>Action</th></tr>
        </thead>
        <tbody>
            <% n = 1; for (Table table : tableTypeFourList) { %>
            <tr>
                <td><%= n++ %></td>
                <td><%= table.getTable_number() %></td>
                <td><%= table.getTable_status() %></td>
                <td><%= table.getTable_password() %></td>
                <td><a href="table-delete?id=<%= table.getTable_id() %>" onclick="return confirm('Delete this table?')">Delete</a></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <h3>Eight seats</h3>
    <a href="${pageContext.request.contextPath}/manager/table-create?type=8" class="add-btn">➕ Add table</a>
    <table>
        <thead>
            <tr><th>N.0</th><th>Table Number</th><th>Table Status</th><th>Table Password</th><th>Action</th></tr>
        </thead>
        <tbody>
            <% n = 1; for (Table table : tableTypeEightList) { %>
            <tr>
                <td><%= n++ %></td>
                <td><%= table.getTable_number() %></td>
                <td><%= table.getTable_status() %></td>
                <td><%= table.getTable_password() %></td>
                <td><a href="table-delete?id=<%= table.getTable_id() %>" onclick="return confirm('Delete this table?')">Delete</a></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>