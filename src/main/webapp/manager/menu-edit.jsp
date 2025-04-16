<%@page import="com.chilling.restaurant.model.MenuItem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>

<%
   MenuItem item = (MenuItem) request.getAttribute("item");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chilling Restaurant</title>
    </head>
    <body>
        <h2>Edit menu</h2>
        <form method="post" action="<%= request.getContextPath() %>/manager/menu-update" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= item.getItemId() %>">
            <input type="text" name="name" placeholder="Item Name" value="<%= item.getItemName() %>" required>
            <input type="number" step="0.01" name="price" placeholder="Price" value="<%= item.getItemPrice() %>" required>
            
            <select name="type">
                <option value="food" <%= item.getItemType().equals("food") ? "selected" : "" %>>Food</option>
                <option value="drink" <%= item.getItemType().equals("drink") ? "selected" : "" %>>Drink</option>
            </select><br>
            
            <img src="<%= item.getItemImgPath() %>" width="120"><br>    
            <input type="file" name="image" accept="image/*"><br>
            
            <button type="submit">Update</button>
        </form>
    </body>
</html>
