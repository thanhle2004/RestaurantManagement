<%@ page import="java.util.*, com.chilling.restaurant.model.MenuItem" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<%
    List<MenuItem> foods = (List<MenuItem>) request.getAttribute("foodList");
    List<MenuItem> drinks = (List<MenuItem>) request.getAttribute("drinkList");
%>

<html>
<head>
    <title>Chilling Restaurant</title>
</head>
<body>
    <h2>Menu</h2>
    <a href="<%= request.getContextPath() %>/manager/menu-create.jsp">➕ Add menu</a>
    
    <h3>Food</h3>
    <table border="1" cellpadding="5">
        <tr>
    <th>N.0</th>
    <th>Image</th>
    <th>Name</th>
    <th>Price</th>
    <th>Action</th>
</tr>
<%
    int foodCount = 0;
    for (MenuItem food : foods) {
        foodCount++;
%>
<tr>
    <td><%= foodCount %></td>
    <td>
        <img src="<%= food.getItemImgPath() %>" width="100">

    </td>
    <td><%= food.getItemName() %></td>
    <td><%= food.getItemPrice() %></td>
    <td>
        <a href="menu-edit?id=<%= food.getItemId() %>">Edit</a> |
        <a href="menu-delete?id=<%= food.getItemId() %>" onclick="return confirm('Delete this food?')">Delete</a>
    </td>
</tr>
<%
    }
%>

    </table>

<h3>Drink</h3>
    <table border="1" cellpadding="5">
        <tr>
    <th>N.0</th>
    <th>Image</th>
    <th>Name</th>
    <th>Price</th>
    <th>Action</th>
</tr>
<%
    int drinkCount = 0;
    for (MenuItem drink : drinks) {
        drinkCount++;
%>
<tr>
    <td><%= drinkCount %></td>
    <td>
        <img src="<%= drink.getItemImgPath() %>" width="100">

    </td>
    <td><%= drink.getItemName() %></td>
    <td><%= drink.getItemPrice() %></td>
    <td>
        <a href="menu-edit?id=<%= drink.getItemId() %>">Edit</a> |
        <a href="menu-delete?id=<%= drink.getItemId() %>" onclick="return confirm('Delete this drink?')">Delete</a>
    </td>
</tr>
<%
    }
%>

    </table>
</body>
</html>
