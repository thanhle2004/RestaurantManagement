<%@page import="com.chilling.restaurant.model.OrderList"%>
<%@page import="com.chilling.restaurant.model.OrderItem"%>
<%@page import="com.chilling.restaurant.model.Table"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Table table = (Table) session.getAttribute("table");
    List<OrderItem> summaryItems = (List<OrderItem>) session.getAttribute("summaryItems");
    String totalAmount = (String) session.getAttribute("summaryTotal");
    OrderList orderList = (OrderList) session.getAttribute("orderList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Summary</title>
</head>
<body>
    <h1>Thank you for your order!</h1>

    <% if (table != null) { %>
        <p><strong>Table:</strong> <%= table.getTable_number() %></p>
    <% } %>

    <% if (summaryItems != null && !summaryItems.isEmpty()) { %>
        <table border="1" cellpadding="8">
            <tr>
                <th>Image</th>
                <th>Item</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Subtotal</th>
            </tr>
            <% for (OrderItem item : summaryItems) { %>
                <tr>
                    <td><img src="<%= item.getItem().getItemImgPath() %>" width="80px" height="80px" alt="alt"/></td>
                    <td><%= item.getItem().getItemName() %></td>
                    <td><%= item.getOrderItemQuantity() %></td>
                    <td>$<%= item.getItem().getItemPrice() %></td>
                    <td>$<%= item.getOrderItemQuantity() * item.getItem().getItemPrice() %></td>
                </tr>
            <% } %>
            <tr>
                <td colspan="4"><strong>Total</strong></td>
                <td><strong>$<%= totalAmount %></strong></td>
            </tr>
        </table>
    <% } else { %>
        <p>No order summary available.</p>
    <% } %>
    
    <%
        String message="";
        if(orderList.getOrderStatus().equals("pending")) {
            message = "Your order is sent to chef. Please wait patiently.";
        } else if(orderList.getOrderStatus().equals("prepared")) {
            message = "Your order is being prepared. Please wait patiently.";
        } else {
            message = "Your order is completed. Enjoy your meal!";
        }
    %>

    <p><%= message %></p>
</body>
</html>
