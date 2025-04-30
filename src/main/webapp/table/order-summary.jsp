<%@page import="com.chilling.restaurant.model.Meal"%>
<%@page import="com.chilling.restaurant.model.OrderList"%>
<%@page import="com.chilling.restaurant.model.OrderItem"%>
<%@page import="com.chilling.restaurant.model.Table"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Table table = (Table) session.getAttribute("table");
    Meal meal = (Meal) session.getAttribute("meal");
    List<OrderItem> summaryItems = (List<OrderItem>) session.getAttribute("summaryItems");
    String totalAmount = (String) session.getAttribute("summaryTotal");
    OrderList orderList = (OrderList) session.getAttribute("orderList");
    String error = (String) session.getAttribute("error");
    if (error != null) {
        session.removeAttribute("error"); // clear sau khi hiển thị
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Summary</title>
    <style>
        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .status-message {
            margin-top: 20px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <h1>Thank you for your order!</h1>

    <% if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

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
        String message;
        if (orderList.getOrderStatus().equals("pending")) {
            message = "Your order is sent to the chef. Please wait patiently.";
        } else if (orderList.getOrderStatus().equals("prepared")) {
            message = "Your order is being prepared. Please wait patiently.";
        } else if (orderList.getOrderStatus().equals("served")) {
            message = "Your order has been served. Enjoy your meal!";
        } else {
            message = "Order status: " + orderList.getOrderStatus();
        }
    %>

    <p class="status-message"><%= message %></p>

    <form action="../table-menu" method="get">
        <input type="submit" value="Back to Menu">
    </form>

    <% if (orderList.getOrderStatus().equals("pending")) { 
        String raw = totalAmount.replace(",", ".");
        Double amt = Double.parseDouble(raw);
        int amountInUSD = (int) (amt * 100);

        double exchangeRate = 23500; 
        double amountInVND = amt * exchangeRate;

        int amount = (int) (amountInVND * 100);
    %>
    <form action="submitOrder" method="post">
        <input type="hidden" name="orderInfo" id="orderInfo" value="Thanh toan don hang <%= orderList.getOrderList_id() %>" />
        <input type="hidden" name="orderId" value="<%= orderList.getOrderList_id() %>" />
        <input type="hidden" name="amount" id="amount" value="<%= amount %>" />
        <button type="submit">Proceed to Payment</button>
    </form>
    <% } %>
    
</body>
</html>
