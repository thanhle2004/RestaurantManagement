<%@ page import="java.util.*, com.chilling.restaurant.model.*, com.chilling.restaurant.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-chef.jsp" %>
<% 
    CookScheduleItemDAO cookScheduleItemDAO = new CookScheduleItemDAO();
    List<OrderList> orderLists = (List<OrderList>) request.getAttribute("orderLists");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
    Integer selectedOlistId = (Integer) request.getAttribute("selectedOlistId");
    CookScheduleList schedule = (CookScheduleList) request.getAttribute("schedule");
%>

<html>
<head>
    <title>Chef Schedule - Chilling Restaurant</title>
</head>
<body>
    

    <!-- Thêm nút Cập nhật thông tin và Quay lại -->
    <div>
        <a href="<%= request.getContextPath() %>/chef/update-profile">Cập nhật thông tin</a>
        <a href="<%= request.getContextPath() %>/restaurant-login.jsp">Quay lại</a>
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
                <% Table table = orderList.getTable(); %>
                <li>
                    Order #<%= orderList.getOrderList_id() %> (Table <%= table != null ? table.getTable_number() : "N/A" %>)
                    <form action="schedule" method="get">
                        <input type="hidden" name="olistId" value="<%= orderList.getOrderList_id() %>"/>
                        <button type="submit">Select Order</button>
                    </form>
                </li>
            <% } %>
        </ul>
    <% } else { %>
        <p>No pending orders available.</p>
    <% } %>

    <!-- show form input time Order List -->
    <% if (selectedOlistId != null && orderItems != null) { %>
        <h3>Order #<%= selectedOlistId %> Details</h3>
        <table border="1" cellpadding="5">
            <tr>
                <th>Item Name</th>
                <th>Quantity</th>
                <th>Completion Time (minutes)</th>
                <th>Status</th>
            </tr>
            <% for (OrderItem orderItem : orderItems) { %>
                <%-- Kiểm tra hoặc tạo CookScheduleItem liên kết với món ăn --%>
                <% CookScheduleItem scheduleItem = cookScheduleItemDAO.getItemByOitemIdAndSchlistId(orderItem.getOrderItem_id(), schedule.getSchlistId()); %>
                <% if (scheduleItem == null) {
                    scheduleItem = new CookScheduleItem();
                    scheduleItem.setOitemId(orderItem.getOrderItem_id());
                    scheduleItem.setSchlistId(schedule.getSchlistId());
                    scheduleItem.setStatus("pending");
                    cookScheduleItemDAO.createItem(scheduleItem);
                } %>
                <tr>
                    <td><%= orderItem.getItem().getItemName() %></td>
                    <td><%= orderItem.getOrderItemQuantity() %></td>
                    <td>
                        <form action="schedule" method="post">
                            <input type="hidden" name="scheduleId" value="<%= scheduleItem.getScheduleId() %>"/>
                            <input type="hidden" name="schlistId" value="<%= schedule.getSchlistId() %>"/>
                            <input type="hidden" name="oitemId" value="<%= orderItem.getOrderItem_id() %>"/>
                            <input type="number" name="completionTime" min="0" 
                                   value="<%= scheduleItem.getOitemTimeCook() > 0 ? scheduleItem.getOitemTimeCook() : "" %>" 
                                   placeholder="Minutes to complete"/>
                            <select name="status">
                                <option value="pending" <%= "pending".equals(scheduleItem.getStatus()) ? "selected" : "" %>>pending</option>
                                <option value="cooking" <%= "cooking".equals(scheduleItem.getStatus()) ? "selected" : "" %>>cooking</option>
                                <option value="completed" <%= "completed".equals(scheduleItem.getStatus()) ? "selected" : "" %>>completed</option>
                            </select>
                            <button type="submit">Update</button>
                        </form>
                    </td>
                    <td><%= scheduleItem.getStatus() %></td>
                </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>