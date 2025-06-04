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
    User user = (User) session.getAttribute("user");
%>

<html>
<head>
    <title>Chef Schedule - Chilling Restaurant</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/schedule-style/styles17.css" />
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
    <div class="chef-container">
        <aside class="chef-sidebar">
            <h2>Hello, <%= user.getFname() %></h2>
            <a href="<%= request.getContextPath() %>/chef/update-profile">Profile</a>
            <a href="<%= request.getContextPath() %>/check-manager">Log out</a>
        </aside>

        <main class="chef-content">
            <h1>Your Cooking Schedule</h1>
            
            <h2>Pending Orders</h2>
            <% if (orderLists != null && !orderLists.isEmpty()) { %>
                <ul class="order-list">
                    <% for (OrderList orderList : orderLists) {
                        if (!orderList.getOrderStatus().equals("ordering") && orderList.getTable().getTable_number() != 0) {
                            Table table = orderList.getTable(); %>
                            <li class="order-card">
                                <div class="order-info">
                                    <h3>Order #<%= orderList.getOrderList_id() %></h3>
                                    <p>Table <%= table != null ? table.getTable_number() : "N/A" %></p>
                                </div>
                                <form action="schedule" method="get" style="display:inline;">
                                    <input type="hidden" name="olistId" value="<%= orderList.getOrderList_id() %>"/>
                                    <button type="submit" class="btn-orange">Choose</button>
                                </form>
                            </li>
                    <% }} %>
                </ul>
            <% } else { %>
                <p class="info">No pending orders available.</p>
            <% } %>

            <% if (selectedOlistId != null && orderItems != null && !orderListDAO.getOrderStatus(selectedOlistId).equals("ordering")) { %>
                <!-- Modal for Order Details -->
                <div id="orderModal" class="modal">
                    <% if (request.getParameter("success") != null) { %>
                        <div class="alert success" id="alertBox">Update successful!</div>
                    <% } %>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert" id="alertBox"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <div class="modal-content">
                        <span class="close-btn">×</span>
                        <h2>Order #<%= selectedOlistId %></h2>
                        <form action="schedule" method="post" class="food-form">
                            <table class="styled-table">
                                <thead>
                                    <tr>
                                        <th>Item Name</th>
                                        <th>Quantity</th>
                                        <th>Completed Quantity</th>
                                        <th>Completion Time (minutes)</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
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
                                            </td>
                                            <td>
                                                <select name="status[]">
                                                    <option value="pending" <%= "pending".equals(scheduleItem.getStatus()) ? "selected" : "" %>>pending</option>
                                                    <option value="cooking" <%= "cooking".equals(scheduleItem.getStatus()) ? "selected" : "" %>>cooking</option>
                                                    <option value="completed" <%= "completed".equals(scheduleItem.getStatus()) ? "selected" : "" %>>completed</option>
                                                </select>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <div class="form-actions">
                                <button type="submit" class="btn-orange">Send to customer</button>
                            </div>
                        </form>
                    </div>
                </div>
            <% } %>
        </main>
    </div>

    <script>
        // Get the modal
        var modal = document.getElementById("orderModal");

        // Get the close button
        var closeBtn = document.getElementsByClassName("close-btn")[0];

        // Show the modal if an order is selected
        <% if (selectedOlistId != null && orderItems != null && !orderListDAO.getOrderStatus(selectedOlistId).equals("ordering")) { %>
            modal.style.display = "flex";
        <% } %>

        // Close the modal when the close button is clicked
        if (closeBtn) {
            closeBtn.onclick = function() {
                modal.style.display = "none";
                // Redirect to the schedule page to clear the selection
                window.location.href = "<%= request.getContextPath() %>/chef/schedule";
            };
        }

        // Close the modal if the user clicks outside of the modal content
        window.onclick = function(event) {
            if (event.target === modal) {
                modal.style.display = "none";
                window.location.href = "<%= request.getContextPath() %>/chef/schedule";
            }
        };
        
        window.onload = function () {
            const alertBox = document.getElementById('alertBox');
            if (alertBox) {
                setTimeout(() => {
                    alertBox.remove();
                }, 5000);
            }
        };
    </script>
</body>
</html>