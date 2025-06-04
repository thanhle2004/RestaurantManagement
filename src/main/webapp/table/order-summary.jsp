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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/order-summary-style/styles15.css"/>
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
        .form-container {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .form-container input[type="submit"],
        .form-container button {
            padding: 10px 20px;
            background-color: orange;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .form-container input[type="submit"]:hover,
        .form-container button:hover {
            background-color: #e65c00;
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

        // Hàm cập nhật trạng thái đơn hàng
        function updateOrderStatus(data) {
            const statusMessage = document.getElementById('status-message');
            const paymentForm = document.getElementById('payment-form');

            // Cập nhật thông báo trạng thái
            let message = 'Order status unavailable.';
            if (data.orderStatus) {
                if (data.orderStatus === 'pending') {
                    message = 'Your order is sent to the chef. Please wait patiently.';
                } else if (data.orderStatus === 'preparing') {
                    message = 'Your order is being prepared. Please wait patiently.';
                } else if (data.orderStatus === 'served') {
                    message = 'Your order has been served. Enjoy your meal!';
                } else {
                    message = `Order status: ${data.orderStatus}`;
                }
            }
            if (statusMessage) {
                statusMessage.textContent = message;
            }

            // Cập nhật form thanh toán
            if (paymentForm) {
                paymentForm.style.display = data.orderStatus === 'served' ? 'inline-block' : 'none';
                if (data.orderStatus === 'served') {
                    const totalAmount = '<%= totalAmount != null ? totalAmount.replace(",", ".") : "0.00" %>';
                    const amountInUSD = parseFloat(totalAmount) * 100;
                    const exchangeRate = 23500;
                    const amountInVND = amountInUSD * exchangeRate;
                    document.getElementById('orderInfo').value = `Thanh toan don hang ${data.orderListId}`;
                    document.getElementById('orderId').value = data.orderListId;
                    document.getElementById('amount').value = Math.round(amountInVND);
                }
            }
        }

        // Hàm gọi AJAX để lấy trạng thái
        function fetchOrderStatus() {
            fetch('<%= request.getContextPath() %>/order-status')
                .then(response => response.json())
                .then(data => {
                    updateOrderStatus(data);
                })
                .catch(error => {
                    console.error('Error fetching order status:', error);
                    const errorDiv = document.getElementById('error-message');
                    if (errorDiv) {
                        errorDiv.textContent = 'Error fetching order status. Please try again later.';
                    }
                });
        }

        // Bắt đầu polling khi trang được tải
        document.addEventListener('DOMContentLoaded', () => {
            fetchOrderStatus(); // Gọi lần đầu
            setInterval(fetchOrderStatus, 5000); // Gọi lại mỗi 5 giây
        });
    </script>
</head>

<body>
    <h1>Thank you for your order!</h1>

    <div id="error-message" class="error" style="display: <%= error != null ? "block" : "none" %>;">
        <%= error != null ? error : "" %>
    </div>

    <p><strong>Table:</strong> <%= table != null ? table.getTable_number() : "N/A" %></p>

    <table id="order-items-table" border="1" cellpadding="8">
        <% if (summaryItems != null && !summaryItems.isEmpty() && orderList != null) { %>
            <tr>
                <th>Image</th>
                <th>Item</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Completion Time (minutes)</th>
                <th>Subtotal</th>
            </tr>
            <% for (OrderItem item : summaryItems) { 
                CookScheduleItem scheduleItem = cookScheduleItemDAO.getItemByOitemId(item.getOrderItem_id());
                int completionTime = (scheduleItem != null) ? scheduleItem.getOitemTimeCook() : 0;
            %>
                <tr>
                    <td><img src="<%= item.getItem().getItemImgPath() %>" width="80px" height="80px" alt="<%= item.getItem().getItemName() %>"/></td>
                    <td><%= item.getItem().getItemName() %></td>
                    <td><%= item.getOrderItemQuantity() %></td>
                    <td>$<%= String.format("%.2f", item.getItem().getItemPrice()) %></td>
                    <td><%= completionTime > 0 ? completionTime : item.getItem().getItemTimeCook() %></td>
                    <td>$<%= String.format("%.2f", item.getOrderItemQuantity() * item.getItem().getItemPrice()) %></td>
                </tr>
            <% } %>
            <tr>
                <td colspan="5"><strong>Total</strong></td>
                <td><strong>$<%= totalAmount %></strong></td>
            </tr>
        <% } else { %>
            <tr><td colspan="6">No order summary available.</td></tr>
        <% } %>
    </table>

    <p id="status-message" class="status-message">
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
        <%= message %>
    </p>

    <div class="form-container">
        <form action="../table-menu" method="get" class="backmenu">
            <input type="submit" value="Back to Menu">
        </form>

        <% if (orderList != null && "served".equals(orderList.getOrderStatus())) { %>
        <form id="payment-form" action="<%= request.getContextPath() %>/table/submitOrder" method="post" class="submit-payment">
            <input type="hidden" name="orderInfo" id="orderInfo" value="Thanh toan don hang <%= orderList.getOrderList_id() %>" />
            <input type="hidden" name="orderId" id="orderId" value="<%= orderList.getOrderList_id() %>" />
            <input type="hidden" name="amount" id="amount" value="<%= (int) (Double.parseDouble(totalAmount.replace(",", ".")) * 23500 * 100) %>" />
            <input type="hidden" name="amountInUSD" id="amountInUSD" value="<%= Double.parseDouble(totalAmount.replace(",", ".")) %>" />
            <button type="submit">Proceed to Payment</button>
        </form>
        <% } else { %>
        <form id="payment-form" action="<%= request.getContextPath() %>/table/submitOrder" method="post" class="submit-payment" style="display: none;">
            <input type="hidden" name="orderInfo" id="orderInfo" value="" />
            <input type="hidden" name="orderId" id="orderId" value="" />
            <input type="hidden" name="amount" id="amount" value="" />
            <input type="hidden" name="amountInUSD" id="amountInUSD" value="" />
            <button type="submit">Proceed to Payment</button>
        </form>
        <% } %>
    </div>
</body>
</html>