<%@page import="com.chilling.restaurant.model.Bill"%>
<%@page import="com.chilling.restaurant.dao.BillDAO"%>
<%@page import="com.chilling.restaurant.model.Meal"%>
<%@page import="com.chilling.restaurant.model.Table"%>
<%@page import="com.chilling.restaurant.model.OrderList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chilling.restaurant.utils.DBUtil"%>
<%@ page import="com.chilling.restaurant.config.VNPayConfig" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%  
    Table table = (Table) session.getAttribute("table");
    Meal meal = (Meal) session.getAttribute("meal");
    Bill bill = (Bill) session.getAttribute("bill");
    
    Map<String, String> fields = new HashMap<>();
    for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
        String fieldName = params.nextElement();
        String fieldValue = request.getParameter(fieldName);
        if (fieldValue != null && fieldValue.length() > 0) {
            fields.put(fieldName, fieldValue);
        }
    }

    String vnp_SecureHash = request.getParameter("vnp_SecureHash");
    if (fields.containsKey("vnp_SecureHashType")) {
        fields.remove("vnp_SecureHashType");
    }
    if (fields.containsKey("vnp_SecureHash")) {
        fields.remove("vnp_SecureHash");
    }

    String signValue = VNPayConfig.hashAllFields(fields);
    System.out.println("signValue: " + signValue);
    System.out.println("vnp_SecureHash: " + vnp_SecureHash);

    String responseCode = request.getParameter("vnp_ResponseCode");
    String message = "";
    
    String vnp_TxnRef = request.getParameter("vnp_TxnRef");
    int olist_id = Integer.parseInt(vnp_TxnRef);
   
    if (!"00".equals(responseCode)) {
        message = "Unsuccessful. Error Code: " + responseCode;
    } else {
        message = "Successful!";
    }
    
    session.setAttribute("bill", bill);
%>

<html>
<head>
    <title>VNPAY Return</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vnpay-return-style/styles16.css"/>
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
    <h1>Payment Result</h1>

    <% if ("00".equals(responseCode)) { %>
        <div class="rating-container">
            <h2>Leave a Rating</h2>
            <form action="/restaurant/submit-rating" method="post" class="rating-form">
                <input type="hidden" name="olist_id" value="<%= olist_id %>">
                <input type="hidden" name="meal_id" value="<%= meal.getMealId() %>">
                <input type="hidden" name="table_id" value="<%= table.getTable_id() %>">
                <div class="star-rating">
                    <input type="radio" name="rate_value" id="star5" value="5"><label for="star5">★</label>
                    <input type="radio" name="rate_value" id="star4" value="4"><label for="star4">★</label>
                    <input type="radio" name="rate_value" id="star3" value="3"><label for="star3">★</label>
                    <input type="radio" name="rate_value" id="star2" value="2"><label for="star2">★</label>
                    <input type="radio" name="rate_value" id="star1" value="1" required><label for="star1">★</label>
                </div>
                <label for="comment">Comment:</label>
                <textarea name="comment" id="comment" rows="4" placeholder="Write your feedback..." required></textarea>
                <button type="submit">Submit Rating</button>
            </form>
        </div>
    <% } %>
    <script>
        setTimeout(() => {
            const alert = document.getElementById('payment-alert');
            if (alert) {
                alert.remove(); // hoặc alert.style.display = 'none';
            }
        }, 5000); // 5 giây
    </script>
</body>
</html>
