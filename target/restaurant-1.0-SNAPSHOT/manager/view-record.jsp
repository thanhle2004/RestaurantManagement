<%@ page import="java.util.*, com.chilling.restaurant.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Meal Records</title>
</head>
<body>

<h2>Meal Records</h2>

<form method="get" action="view-record">
    Search by date: <input type="date" name="searchDate" />
    <input type="submit" value="Search" />
</form>

<table border="1" cellpadding="8">
    <tr>
        <th>Meal ID</th>
        <th>Start Time</th>
        <th>End Time</th>
        <th>Total Amount</th>
        <th>Rating</th>
        <th>Comment</th>
        <th>Order List</th>
    </tr>

<%
    List<Meal> meals = (List<Meal>) request.getAttribute("meals");
    if (meals != null) {
        for (Meal meal : meals) {
%>
    <tr>
        <td><%= meal.getMealId() %></td>
        <td><%= meal.getStartTime() %></td>
        <td><%= meal.getEndTime() %></td>
        <td><%= meal.getAmount() %></td>
        <td><%= meal.getRating() %></td>
        <td><%= meal.getFeedback() %></td>
        <td>
            <form method="get" action="view-record">
                <input type="hidden" name="viewMealId" value="<%= meal.getMealId() %>" />
                <input type="hidden" name="searchDate" value="<%= request.getAttribute("searchDate") != null ? request.getAttribute("searchDate") : "" %>">
                <input type="submit" value="View" />
            </form>
        </td>
    </tr>
<%
        }
    }
%>
</table>

<%
    Meal selectedMeal = (Meal) request.getAttribute("selectedMeal");
    if (selectedMeal != null && selectedMeal.getOrderItems() != null) {
%>
    <h3>Order Items for Meal ID <%= selectedMeal.getMealId() %></h3>
    <table border="1" cellpadding="6">
        <tr>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total</th>
        </tr>
<%
        for (OrderItem item : selectedMeal.getOrderItems()) {
            double total = item.getOrderItemQuantity() * item.getItem().getItemPrice();
%>
        <tr>
            <td><%= item.getItem().getItemName() %></td>
            <td><%= item.getOrderItemQuantity() %></td>
            <td><%= item.getItem().getItemPrice() %></td>
            <td><%= total %></td>
        </tr>
<%
        }
%>
    </table>
<%
    }
%>

</body>
</html>
