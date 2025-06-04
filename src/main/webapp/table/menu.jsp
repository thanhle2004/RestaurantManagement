<%@page import="com.chilling.restaurant.dao.OrderItemDAO"%>
<%@page import="java.util.Set"%>
<%@page import="com.chilling.restaurant.model.Meal"%>
<%@page import="com.chilling.restaurant.model.OrderItem"%>
<%@page import="com.chilling.restaurant.model.OrderList"%>
<%@page import="com.chilling.restaurant.model.Table"%>
<%@page import="com.chilling.restaurant.model.MenuItem"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Table table = (Table) session.getAttribute("table");
    Meal meal = (Meal) session.getAttribute("meal");
    List<MenuItem> foodList = (List<MenuItem>) request.getAttribute("foodList");
    List<MenuItem> drinkList = (List<MenuItem>) request.getAttribute("drinkList");
    List<MenuItem> dessertList = (List<MenuItem>) request.getAttribute("dessertList");
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
    <a href="table-dashboard.jsp" class="back-button header-back">← Back</a>
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
                    <%
                        String category = request.getParameter("category") != null ? request.getParameter("category") : "all";
                        String link = "add-to-order?id=" + food.getItemId() + "&name=" + food.getItemName() + "&price=" + food.getItemPrice() + "&img=" + food.getItemImgPath() + "&time=" + food.getItemTimeCook() + "&category=" + java.net.URLEncoder.encode(category, "UTF-8");
                    %>
                    <a href="<%= link %>" class="add-btn">Add</a>
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
                    <%
                        String category = request.getParameter("category") != null ? request.getParameter("category") : "all";
                        String link = "add-to-order?id=" + drink.getItemId() + "&name=" + drink.getItemName() + "&price=" + drink.getItemPrice() + "&img=" + drink.getItemImgPath() + "&time=" + drink.getItemTimeCook() + "&category=" + java.net.URLEncoder.encode(category, "UTF-8");
                    %>
                    <a href="<%= link %>" class="add-btn">Add</a>
                </div>
            <% } %>
        </div>
        
        <h2 id="dessert-title" class="section-title">Dessert</h2>
        <div class="menu-grid">
            <% for (MenuItem dessert : dessertList) { %>
                <div class="menu-item" data-category="dessert">
                    <img src="<%= dessert.getItemImgPath() %>" alt="<%= dessert.getItemName() %>" />
                    <h3><%= dessert.getItemName() %></h3>
                    <p class="price">$<%= dessert.getItemPrice() %></p>
                    <%
                        String category = request.getParameter("category") != null ? request.getParameter("category") : "all";
                        String link = "add-to-order?id=" + dessert.getItemId() + "&name=" + dessert.getItemName() + "&price=" + dessert.getItemPrice() + "&img=" + dessert.getItemImgPath() + "&time=" + dessert.getItemTimeCook() + "&category=" + java.net.URLEncoder.encode(category, "UTF-8");
                    %>
                    <a href="<%= link %>" class="add-btn">Add</a>
                </div>
            <% } %>
        </div>
    </div>

<aside class="order-sidebar">
    <h2 class="section-title">Current Order</h2>
    <p>Order #<%= orderList != null ? orderList.getOrderList_id() : "N/A" %></p>
    <p>Table <%= table != null ? table.getTable_number() : "N/A" %></p>


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
            <li class="order-item">
                <div class="order-item-content">
                    <img src="<%= item.getItem().getItemImgPath() %>" alt="<%= item.getItem().getItemName() %>" class="order-item-img" />
                    <div class="order-item-details">
                        <h3><%= item.getItem().getItemName() %></h3>
                        <p class="price">$<%= String.format("%.2f", item.getItem().getItemPrice()) %></p>
                        <div class="quantity-controls">
                            <% if (isPending || item.getOrderItemQuantity() > orderItemDAO.getOrderItemBaseQuantity(orderList.getOrderList_id(), item.getOrderItem_id())) { %>
                                <a href="update-quantity?id=<%= item.getOrderItem_id() %>&action=decrease&category=<%= request.getParameter("category") %>" class="quantity-btn"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M320-440h320q17 0 28.5-11.5T680-480q0-17-11.5-28.5T640-520H320q-17 0-28.5 11.5T280-480q0 17 11.5 28.5T320-440ZM200-120q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h560q33 0 56.5 23.5T840-760v560q0 33-23.5 56.5T760-120H200Zm0-80h560v-560H200v560Zm0-560v560-560Z"/></svg></a>
                            <% } else { %>
                                <span class="quantity-btn disabled"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M320-440h320q17 0 28.5-11.5T680-480q0-17-11.5-28.5T640-520H320q-17 0-28.5 11.5T280-480q0 17 11.5 28.5T320-440ZM200-120q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h560q33 0 56.5 23.5T840-760v560q0 33-23.5 56.5T760-120H200Zm0-80h560v-560H200v560Zm0-560v560-560Z"/></svg></span>
                            <% } %>
                            <span class="quantity"><%= item.getOrderItemQuantity() %></span>
                            <a href="update-quantity?id=<%= item.getOrderItem_id() %>&action=increase&category=<%= request.getParameter("category") %>" class="quantity-btn"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M440-280h80v-160h160v-80H520v-160h-80v160H280v80h160v160ZM200-120q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h560q33 0 56.5 23.5T840-760v560q0 33-23.5 56.5T760-120H200Zm0-80h560v-560H200v560Zm0-560v560-560Z"/></svg></a>
                        </div>
                    </div>
                </div>
            </li>
        <%
                }
            } else {
        %>
            <li class="empty-order">No items yet</li>
        <% } %>
    </ul>

    <% if (orderItems != null && !orderItems.isEmpty()) {
        double tax = 2.25; // Fixed tax as per screenshot
        double total = subtotal + tax;
    %>
        <div class="order-summary">
            <p class="summary-line">Subtotal: $<%= String.format("%.2f", subtotal) %></p>
            <p class="summary-line">Total sales tax: $<%= String.format("%.2f", tax) %></p>
            <hr class="summary-divider">
            <p class="summary-total">TOTAL: $<%= String.format("%.2f", total) %></p>
        </div>

        <div class="order-actions">
            <form action="submit-order" method="post" style="display: inline;">
                <button type="submit" class="submit-btn">Send to chef</button>
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
    const dessertTitle = document.getElementById('dessert-title');

    // Reset visibility
    foodTitle.style.display = 'none';
    drinkTitle.style.display = 'none';
    dessertTitle.style.display = 'none';

    items.forEach(item => {
        const itemCategory = item.getAttribute('data-category');

        if (category === 'all') {
            item.style.display = 'block';
            if (itemCategory === 'food') foodTitle.style.display = 'block';
            if (itemCategory === 'drink') drinkTitle.style.display = 'block';
            if (itemCategory === 'dessert') dessertTitle.style.display = 'block';
        } else if (itemCategory === category) {
            item.style.display = 'block';
            if (category === 'food') foodTitle.style.display = 'block';
            if (category === 'drink') drinkTitle.style.display = 'block';
            if (category === 'dessert') dessertTitle.style.display = 'block';
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
