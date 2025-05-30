<%@page import="com.chilling.restaurant.dao.OrderItemDAO"%>
<%@page import="java.util.Set"%>
<%@page import="com.chilling.restaurant.model.Meal"%>
<%@page import="com.chilling.restaurant.model.OrderItem"%>
<%@page import="com.chilling.restaurant.model.OrderList"%>
<%@page import="com.chilling.restaurant.model.Table"%>
<%@page import="com.chilling.restaurant.model.MenuItem"%>
<%@page import="java.util.List"%>
<%
    Table table = (Table) session.getAttribute("table");
    Meal meal = (Meal) session.getAttribute("meal");
    List<MenuItem> foodList = (List<MenuItem>) request.getAttribute("foodList");
    List<MenuItem> drinkList = (List<MenuItem>) request.getAttribute("drinkList");
    String totalAmount = (String) session.getAttribute("totalAmount");
    OrderList orderList = (OrderList) session.getAttribute("orderList");
    List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("orderItems");
    boolean isPending = (boolean) request.getAttribute("isPending");
    String action = request.getParameter("action");
    OrderItemDAO orderItemDAO = new OrderItemDAO();

    if (!isPending && "decrease".equals(action)) {
        response.sendRedirect("menu.jsp?error=Cannot decrease quantity while order is being prepared");
        return;
    }

    String message = request.getParameter("message");
    String error = request.getParameter("error");
    if (message != null) {
%>
    <p style="color: green;"><%= message %></p>
<%
    } else if (error != null) {
%>
    <p style="color: red;"><%= error %></p>
<%
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu for Table <%= table.getTable_number() %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/menu-style/styles12.css"/>
    <style>
    html, body {
      height: 100%;
      overflow: auto;
      scrollbar-width: none; 
    }

    html::-webkit-scrollbar,
    body::-webkit-scrollbar {
      display: none;
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
<header class="manager-header">
    <a href="table-dashboard.jsp" class="back-button header-back">Back</a>
</header>
<div class="menu-wrapper">
    <aside class="sidebar">
        <a href="#" class="sidebar-item" onclick="filterMenu('all')">All</a>
        <a href="#" class="sidebar-item" onclick="filterMenu('food')">Food</a>
        <a href="#" class="sidebar-item" onclick="filterMenu('drink')">Drink</a>
        <a href="#" class="sidebar-item" onclick="filterMenu('dessert')">Dessert</a>
    </aside>
    <div class="main-content">
        <% if (message != null) { %>
            <p class="message"><%= message %></p>
        <% } else if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
        <h1 class="form-title">Menu for Table <%= table.getTable_number() %></h1>

        <h2 id="food-title" class="section-title">Food</h2>
        <div class="menu-grid">
            <% for (MenuItem food : foodList) { %>
                <div class="menu-item" data-category="food">
                    <img src="<%= food.getItemImgPath() %>" alt="<%= food.getItemName() %>" />
                    <h3><%= food.getItemName() %></h3>
                    <p class="price">$<%= food.getItemPrice() %></p>
                    <a href="add-to-order?id=<%= food.getItemId() %>&name=<%= food.getItemName() %>&price=<%= food.getItemPrice() %>&img=<%= food.getItemImgPath() %>&time=<%= food.getItemTimeCook() %>&category=food" class="add-btn">Add</a>
                </div>
            <% } %>
        </div>

        <h2 id="drink-title" class="section-title">Drink</h2>
        <div class="menu-grid">
            <% for (MenuItem drink : drinkList) { %>
                <div class="menu-item" data-category="drink">
                    <img src="<%= drink.getItemImgPath() %>" alt="<%= drink.getItemName() %>" />
                    <h3><%= drink.getItemName() %></h3>
                    <p class="price">$<%= drink.getItemPrice() %></p>
                    <a href="add-to-order?id=<%= drink.getItemId() %>&name=<%= drink.getItemName() %>&price=<%= drink.getItemPrice() %>&img=<%= drink.getItemImgPath() %>&time=<%= drink.getItemTimeCook() %>&category=drink" class="add-btn">Add</a>
                </div>
            <% } %>
        </div>
    </div>

    <aside class="order-sidebar">
        <h2 class="section-title">Current Order</h2>
        <p>Order #<%= orderList != null ? orderList.getOrderList_id() : "N/A" %></p>
        <p>Table <%= table != null ? table.getTable_number() : "N/A" %></p>

        <div class="order-type">
            <label><input type="radio" name="order-type" value="dine-in" checked> Dine In</label>
            <label><input type="radio" name="order-type" value="take-away"> Take Away</label>
        </div>

        <ul class="order-items">
            <%
                double subtotal = 0;
                if (orderItems != null && !orderItems.isEmpty()) {
                    for (OrderItem item : orderItems) {
                        double itemPrice = item.getItem().getItemPrice();
                        int quantity = item.getOrderItemQuantity();
                        double itemTotal = itemPrice * quantity;
                        subtotal += itemTotal;
            %>
                <li>
                    <%= item.getItem().getItemName() %> - $<%= item.getItem().getItemPrice() %>
                    <span class="quantity">x<%= item.getOrderItemQuantity() %></span>
                    <div class="quantity-controls">
                        <% if (isPending || item.getOrderItemQuantity() > orderItemDAO.getOrderItemBaseQuantity(orderList.getOrderList_id(), item.getOrderItem_id())) { %>
                            <a href="update-quantity?id=<%= item.getOrderItem_id() %>&action=decrease&category=<%= request.getParameter("category") %>" class="quantity-btn">-</a>
                        <% } else { %>
                            <span class="quantity-btn disabled">-</span>
                        <% } %>
                        <a href="update-quantity?id=<%= item.getOrderItem_id() %>&action=increase&category=<%= request.getParameter("category") %>" class="quantity-btn">+</a>
                    </div>
                    <a href="remove-from-order?id=<%= item.getOrderItem_id() %>" class="remove-btn">Remove</a>
                </li>
            <%
                    }
                } else {
            %>
                <li class="empty-order">No items yet</li>
            <% } %>
        </ul>

        <% if (orderItems != null && !orderItems.isEmpty()) {
            double take10Percent = subtotal * 0.9;
        %>
            <p class="total">Items: <%= orderItems.size() %></p>
            <p class="total">Take 10%: $<%= String.format("%.2f", take10Percent) %></p>
            <p class="total">Total: $<%= String.format("%.2f", subtotal) %></p>

            <div class="order-actions">
                <form action="submit-order" method="post" style="display: inline;">
                    <button type="submit" class="custom-button">Submit Order</button>
                </form>
            </div>
        <% } %>
    </aside>
</div>

<script>
function filterMenu(category) {
    const items = document.querySelectorAll('.menu-item');
    const foodTitle = document.getElementById('food-title');
    const drinkTitle = document.getElementById('drink-title');

    // Reset visibility
    foodTitle.style.display = 'none';
    drinkTitle.style.display = 'none';

    items.forEach(item => {
        const itemCategory = item.getAttribute('data-category');

        if (category === 'all') {
            item.style.display = 'block';
            if (itemCategory === 'food') foodTitle.style.display = 'block';
            if (itemCategory === 'drink') drinkTitle.style.display = 'block';
        } else if (itemCategory === category) {
            item.style.display = 'block';
            if (category === 'food') foodTitle.style.display = 'block';
            if (category === 'drink') drinkTitle.style.display = 'block';
            // You can add support for 'dessert-title' here if needed
        } else {
            item.style.display = 'none';
        }
    });
}
</script>

<script>
    // Scroll restore script
    window.addEventListener("beforeunload", function () {
        sessionStorage.setItem("scrollPosition", window.scrollY);
    });

    window.addEventListener("load", function () {
        const scrollPosition = sessionStorage.getItem("scrollPosition");
        if (scrollPosition) {
            window.scrollTo(0, parseInt(scrollPosition));
            sessionStorage.removeItem("scrollPosition");
        }
    });
</script>
<script>
    // Auto filter based on category from URL
    window.addEventListener("load", function () {
        const params = new URLSearchParams(window.location.search);
        const category = params.get("category");
        if (category) {
            filterMenu(category);
        }
    });
</script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const category = urlParams.get("category");

    if (category) {
        document.querySelectorAll('.quantity-btn, .remove-btn').forEach(link => {
            const url = new URL(link.href);
            url.searchParams.set("category", category);
            link.href = url.toString();
        });
    }
});
</script>
</body>
</html>
