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
    
    boolean isValidSignature = signValue.equals(vnp_SecureHash);

    String responseCode = request.getParameter("vnp_ResponseCode");
    String message = "";
    
    String vnp_TxnRef = request.getParameter("vnp_TxnRef");
    int olist_id = Integer.parseInt(vnp_TxnRef);
   
    if (!"00".equals(responseCode)) {
        message = "Unsuccessful. Error Code: " + responseCode;
    } else {
        message = "Successful!";
        
        BillDAO billDAO = new BillDAO();
        bill.setPayment_status("paid");
        billDAO.updateBillStatus(bill);
    }
    
    session.setAttribute("bill", bill);
%>

<html>
<head>
    <title>VNPAY Return</title>
    <style>
        .rating-container {
            width: 100%;
            max-width: 400px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fefefe;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            font-family: sans-serif;
        }

        .rating-form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }

        .star-rating input[type="radio"] {
            display: none;
        }

        .star-rating label {
            font-size: 32px;
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s;
        }

        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #FFD700;
        }

        .star-rating input[type="radio"]:checked ~ label {
            color: #ccc;
        }

        .star-rating input[type="radio"]:checked + label,
        .star-rating input[type="radio"]:checked + label ~ label {
            color: #FFD700;
        }

        textarea {
            resize: vertical;
            padding: 10px;
            font-size: 14px;
        }

        button {
            background-color: #28a745;
            color: white;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <h1>Payment Result</h1>

    <p style="<%= isValidSignature ? (responseCode.equals("00") ? "color:green;" : "color:red;") : "color:red;" %>">
        <%= message %>
    </p>

    <% if ("00".equals(responseCode)) { %>
        <div class="rating-container">
            <h2>Leave a Rating</h2>
            <form action="/restaurant/submit-rating" method="post" class="rating-form">
                <input type="hidden" name="olist_id" value="<%= olist_id %>">
                <input type="hidden" name="meal_id" value="<%= meal.getMealId() %>">
                <div class="star-rating">
                    <input type="radio" name="rate_value" id="star5" value="5"><label for="star5">&#9733;</label>
                    <input type="radio" name="rate_value" id="star4" value="4"><label for="star4">&#9733;</label>
                    <input type="radio" name="rate_value" id="star3" value="3"><label for="star3">&#9733;</label>
                    <input type="radio" name="rate_value" id="star2" value="2"><label for="star2">&#9733;</label>
                    <input type="radio" name="rate_value" id="star1" value="1" required><label for="star1">&#9733;</label>
                </div>
                <label for="comment">Comment:</label>
                <textarea name="comment" id="comment" rows="4" placeholder="Write your feedback..." required></textarea>

                <button type="submit">Submit Rating</button>
            </form>
        </div>

    <% } %>
</body>
</html>
