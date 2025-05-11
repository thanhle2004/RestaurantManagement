<%@page import="com.chilling.restaurant.model.MenuItem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>

<%
   MenuItem item = (MenuItem) request.getAttribute("item");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chilling Restaurant - Edit Menu</title>
    <link rel="stylesheet" href="../assets/menu-edit-style/styles5.css"/>
</head>
<body>
<header class="manager-header">
    <a href="manager-dashboard.jsp" class="back-button header-back">← Back</a>
</header>

    <h2 class="form-title">Edit Menu</h2>

    <div class="form-container">
        <form method="post" action="<%= request.getContextPath() %>/manager/menu-update" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= item.getItemId() %>">

            <label><span>Name</span>
                <input type="text" name="name" value="<%= item.getItemName() %>" required>
            </label>

            <label><span>Price</span>
                <input type="number" step="0.01" name="price" value="<%= item.getItemPrice() %>" required>
            </label>

            <label><span>Time to cook</span>
                <input type="number" name="time" value="<%= item.getItemTimeCook() %>" required>
            </label>

            <label><span>Type</span>
                <select name="type">
                    <option value="food" <%= item.getItemType().equals("food") ? "selected" : "" %>>Food</option>
                    <option value="drink" <%= item.getItemType().equals("drink") ? "selected" : "" %>>Drink</option>
                </select>
            </label>

            <label class="img-preview">
                <span>Current Image</span>
                <img src="<%= item.getItemImgPath() %>" alt="Item Image">
            </label>

            <label><span>Change Image</span>
                <input type="file" name="image" accept="image/*">
            </label>

                <button type="submit" class="custom-button">Update</button>

            </div>
        </form>
    </div>
</body>
</html>
