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
</head>
<body>
    <h1>Welcome, Table <%= table.getTable_number() %>!</h1>
    <h2>Food</h2>
    <ul>
    <% for (MenuItem food : foodList) { %>
        <li>
            <a href="add-to-order?id=<%= food.getItemId() %>&name=<%= food.getItemName() %>&price=<%= food.getItemPrice() %>&img=<%= food.getItemImgPath() %>&time=<%= food.getItemTimeCook() %>">
                <img src="<%= food.getItemImgPath() %>" alt="alt" width="80" />
                <%= food.getItemName() %> - $<%= food.getItemPrice() %>
            </a>
        </li>
    <% } %>
    </ul>

    <h2>Drink</h2>
    <ul>
    <% for (MenuItem drink : drinkList) { %>
        <li>
            <a href="add-to-order?id=<%= drink.getItemId() %>&name=<%= drink.getItemName() %>&price=<%= drink.getItemPrice() %>&img=<%= drink.getItemImgPath() %>&time=<%= drink.getItemTimeCook() %>">
                <img src="<%= drink.getItemImgPath() %>" alt="alt" width="80" />
                <%= drink.getItemName() %> - $<%= drink.getItemPrice() %>
            </a>
        </li>
    <% } %>
    </ul>
    
    <h2>Your Order</h2>
    <%
        if (orderList != null && orderItems != null) {
    %>
    <form action="submit-order" method="post">
        <table border="1">
            <tr>
                <th>Image</th>
                <th>Item</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>
        <%
            for (OrderItem item : orderItems) {
        %>
            <tr>
                <td><img src="<%= item.getItem().getItemImgPath() %>" width="80" height="80" alt="alt"/></td>
                <td><%= item.getItem().getItemName() %></td>
                <td>
                    <td>
                        <% if (isPending || item.getOrderItemQuantity() > orderItemDAO.getOrderItemBaseQuantity(orderList.getOrderList_id(), item.getOrderItem_id())) { 
                            System.out.println("Quantity: " + item.getOrderItemQuantity() + ", Base quantity:" + orderItemDAO.getOrderItemBaseQuantity(orderList.getOrderList_id(), item.getOrderItem_id()));
                        %>
                            <a href="update-quantity?id=<%= item.getOrderItem_id()%>&action=decrease">-</a>
                        <% } else { %>
                            <span style="color:gray;">-</span>
                        <% } %>
                        <%= item.getOrderItemQuantity() %>
                        <a href="update-quantity?id=<%= item.getOrderItem_id() %>&action=increase">+</a>
                    </td>

                </td>
                <td>$<%= item.getItem().getItemPrice() %></td>
                <td>$<%= item.getOrderItemQuantity() * item.getItem().getItemPrice() %></td>
                <td>
                    <a href="remove-from-order?id=<%= item.getOrderItem_id() %>">Remove</a>
                </td>
            </tr>
        <%
            }
        %>
            <tr>
                <td colspan="4"><strong>Total</strong></td>
                <td colspan="2"><strong>$<%= totalAmount %></strong></td>
            </tr>
        </table>
    <%
        } else {
    %>
        <p>Order list is empty.</p>
    <%
        }
    %>
        <input type="submit" value="Submit Order" />
    </form>
</body>
</html>
