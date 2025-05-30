<%@ page import="java.util.*, com.chilling.restaurant.model.*, com.chilling.restaurant.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-chef.jsp" %>
<% 
    CookScheduleItemDAO cookScheduleItemDAO = new CookScheduleItemDAO();
    OrderListDAO orderListDAO = new OrderListDAO();
    List<OrderList> orderLists = (List<OrderList>) request.getAttribute("orderLists");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
    Integer selectedOlistId = (Integer) request.getAttribute("selectedOlistId");
    CookScheduleList schedule = (CookScheduleList) request.getAttribute("schedule");
%>

<html>
<head>
    <title>Chef Schedule - Chilling Restaurant</title>
    <style>
    html, body {
      height: 100%;
      overflow: auto;
      scrollbar-width: none; /* Firefox */
    }

    html::-webkit-scrollbar,
    body::-webkit-scrollbar {
      display: none; /* Chrome, Safari, Edge */
    }
    </style>
    <script>
        function enterFullScreen() {
            const elem = document.documentElement; 

            if (elem.requestFullscreen) {
              elem.requestFullscreen();
            } else if (elem.webkitRequestFullscreen) { 
              elem.webkitRequestFullscreen();
            } else if (elem.msRequestFullscreen) { 
              elem.msRequestFullscreen();
            }
        }

        function exitFullScreen() {
            if (document.exitFullscreen) {
              document.exitFullscreen();
            } else if (document.webkitExitFullscreen) { 
              document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) { 
              document.msExitFullscreen();
            }
        }
    </script>
</head>
<body>
    
    <div>
        <a href="<%= request.getContextPath() %>/chef/update-profile">Profile</a>
        <a href="<%= request.getContextPath() %>/check-manager">Log out</a>
    </div>
    
    
    <h2>Your Cooking Schedule</h2>
    <% if (request.getParameter("success") != null) { %>
        <p style="color: green;">Update successful!</p>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red"><%= request.getAttribute("error") %></p>
    <% } %>
    <!-- show order list -->
    <h3>Available Orders</h3>
    <% if (orderLists != null && !orderLists.isEmpty()) { %>
        <ul>
            <% for (OrderList orderList : orderLists) { %>
                <% if(!orderList.getOrderStatus().equals("ordering") && orderList.getTable().getTable_number() != 0) {
                    Table table = orderList.getTable(); %>
                <li>
                    Order #<%= orderList.getOrderList_id() %> (Table <%= table != null ? table.getTable_number() : "N/A" %>)
                    <form action="schedule" method="get">
                        <input type="hidden" name="olistId" value="<%= orderList.getOrderList_id() %>"/>
                        <button type="submit">Select Order</button>
                    </form>
                </li>
            <% }} %>
        </ul>
    <% } else { %>
        <p>No pending orders available.</p>
    <% } %>

    <% if (selectedOlistId != null && orderItems != null && !orderListDAO.getOrderStatus(selectedOlistId).equals("ordering")) { %>
        <h3>Order #<%= selectedOlistId %> Details</h3>
        <form action="schedule" method="post">
        <table border="1" cellpadding="5">
            <tr>
                <th>Item Name</th>
                <th>Quantity</th>
                <th>Completed Quantity</th>
                <th>Completion Time (minutes)</th>
                <th>Status</th>
            </tr>
            <% for (OrderItem orderItem : orderItems) { %>
                <% CookScheduleItem scheduleItem = cookScheduleItemDAO.getItemByOitemId(orderItem.getOrderItem_id()); %>
                <% if (scheduleItem == null) {
                    scheduleItem = new CookScheduleItem();
                    scheduleItem.setOitemId(orderItem.getOrderItem_id());
                    scheduleItem.setSchlistId(schedule.getSchlistId());
                    scheduleItem.setStatus("pending");
                    scheduleItem.setCompleted_quantity(0);
                    cookScheduleItemDAO.createItem(scheduleItem);
                } %>
                <tr>
                    <td><%= orderItem.getItem().getItemName() %></td>
                    <td><%= orderItem.getOrderItemQuantity() %></td>
                    <td><%= cookScheduleItemDAO.getCompletedQuantity(schedule.getSchlistId(), orderItem.getOrderItem_id()) %></td>
                    <td>
                            <input type="hidden" name="scheduleId[]" value="<%= scheduleItem.getScheduleId() %>"/>
                            <input type="hidden" name="schlistId[]" value="<%= schedule.getSchlistId() %>"/>
                            <input type="hidden" name="oitemId[]" value="<%= orderItem.getOrderItem_id() %>"/>
                            <input type="number" name="completionTime[]" min="0" 
                                   value="<%= scheduleItem.getOitemTimeCook() > 0 ? scheduleItem.getOitemTimeCook() : orderItem.getItem().getItemTimeCook() %>" 
                                   placeholder="Minutes to complete"/>
                            <select name="status[]">
                                <option value="pending" <%= "pending".equals(scheduleItem.getStatus()) ? "selected" : "" %>>pending</option>
                                <option value="cooking" <%= "cooking".equals(scheduleItem.getStatus()) ? "selected" : "" %>>cooking</option>
                                <option value="completed" <%= "completed".equals(scheduleItem.getStatus()) ? "selected" : "" %>>completed</option>
                            </select>
                            
                    </td>
                    <td><%= orderListDAO.getOrderStatus(selectedOlistId) %></td>
                </tr>
            <% } %>
        </table>
        <button type="submit">Send to customer</button>
        </form>
        <a href="<%= request.getContextPath() %>/chef/schedule">Close</a>
    <% } %>
</body>
</html>