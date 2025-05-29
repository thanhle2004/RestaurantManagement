<%@ page import="java.util.*, com.chilling.restaurant.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Meal Records</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/view-record-style/styles14.css"/>
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
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
    %>
    <header class="manager-header">
        <a href="manager-dashboard.jsp" class="back-button header-back">← Back</a>
    </header>
    <%
        if (message != null) {
    %>
        <p class="message text-center"><%= message %></p>
    <%
        } else if (error != null) {
    %>
        <p class="error text-center"><%= error %></p>
    <%
        }
    %>
    <h2 class="form-title">Meal Records</h2>

    <form method="get" action="view-record" class="search-form">
        Search by date: <input type="date" name="searchDate" />
        <input type="submit" value="Search" />
    </form>

    <%
        List<Meal> meals = (List<Meal>) request.getAttribute("meals");
        if (meals != null && !meals.isEmpty()) {
    %>
        <table border="1" cellpadding="8" class="meal-table">
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
            %>
        </table>
    <%
        } else {
    %>
        <p class="empty-message">No meal records found.</p>
    <%
        }
    %>

    <%
        Meal selectedMeal = (Meal) request.getAttribute("selectedMeal");
        if (selectedMeal != null && selectedMeal.getOrderItems() != null && !selectedMeal.getOrderItems().isEmpty()) {
    %>
        <h3 class="section-title">Order Items for Meal ID <%= selectedMeal.getMealId() %></h3>
        <table border="1" cellpadding="6" class="order-table">
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