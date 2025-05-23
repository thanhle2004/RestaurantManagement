<%@page import="java.util.List"%>

<%@page import="com.chilling.restaurant.model.Meal"%>
<%@page import="com.chilling.restaurant.model.OrderList"%>
<%@page import="com.chilling.restaurant.model.OrderItem"%>
<%@page import="com.chilling.restaurant.model.Table"%>
<%@page import="com.chilling.restaurant.model.CookScheduleItem"%>
<%@page import="com.chilling.restaurant.dao.OrderListDAO"%>
<%@page import="com.chilling.restaurant.dao.CookScheduleItemDAO"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Table table = (Table) session.getAttribute("table");
    Meal meal = (Meal) session.getAttribute("meal");
    List<OrderItem> summaryItems = (List<OrderItem>) session.getAttribute("summaryItems");
    String totalAmount = (String) session.getAttribute("summaryTotal");
    OrderListDAO orderListDAO = new OrderListDAO();
    int olistId = (meal != null) ? meal.getOlistId() : 0;
    OrderList orderList = (olistId > 0) ? orderListDAO.getOrderListById(olistId) : null;
    CookScheduleItemDAO cookScheduleItemDAO = new CookScheduleItemDAO();
    String error = (String) session.getAttribute("error");
    if (error != null) {
        session.removeAttribute("error"); 
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

    <% if (summaryItems != null && !summaryItems.isEmpty() && orderList != null) { %>
        <table border="1" cellpadding="8">
            <tr>
                <th>Image</th>
                <th>Item</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Completion Time (minutes)</th>
                <th>Subtotal</th>
            </tr>
            
            
            <% for (OrderItem item : summaryItems) { 
                CookScheduleItem scheduleItem = cookScheduleItemDAO.getItemByOitemIdAndSchlistId(item.getOrderItem_id(), orderList.getOrderList_id());
                int completionTime = (scheduleItem != null) ? scheduleItem.getOitemTimeCook() : 0;
            %>
            
                <tr>
                    <td><img src="<%= item.getItem().getItemImgPath() %>" width="80px" height="80px" alt="alt"/></td>
                    <td><%= item.getItem().getItemName() %></td>
                    <td><%= item.getOrderItemQuantity() %></td>
                    <td>$<%= item.getItem().getItemPrice() %></td>
                    <td><%= completionTime > 0 ? completionTime : "Estimating" %></td>
                    <td>$<%= item.getOrderItemQuantity() * item.getItem().getItemPrice() %></td>
                </tr>
            <% } %>
            
            <tr>
                <td colspan="5"><strong>Total</strong></td>
                <td><strong>$<%= totalAmount %></strong></td>
            </tr>
            
        </table>
    <% } else { %>
        <p>No order summary available.</p>
    <% } %>

    
    <%
        String message;
        if (orderList != null) {
            if ("pending".equals(orderList.getOrderStatus())) {
                message = "Your order is sent to the chef. Please wait patiently.";
            } else if ("preparing".equals(orderList.getOrderStatus())) {
                message = "Your order is being prepared. Please wait patiently.";
            } else if ("served".equals(orderList.getOrderStatus())) {
                message = "Your order has been served. Enjoy your meal!";
            } else {
                message = "Order status: " + orderList.getOrderStatus();
            }
        } else {
            message = "Order status unavailable.";
        }
    %>

    <p class="status-message"><%= message %></p>

    <form action="../table-menu" method="get">
        <input type="submit" value="Back to Menu">
    </form>
    

    <% if (orderList != null && "served".equals(orderList.getOrderStatus())) { 
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