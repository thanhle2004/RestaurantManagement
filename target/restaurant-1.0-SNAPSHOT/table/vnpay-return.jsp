<%@ page import="com.chilling.restaurant.config.VNPayConfig" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Begin process return from VNPAY
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

    // Calculate hash from fields
    String signValue = VNPayConfig.hashAllFields(fields);
    System.out.println("signValue: " + signValue);
    System.out.println("vnp_SecureHash: " + vnp_SecureHash);
    
    boolean isValidSignature = signValue.equals(vnp_SecureHash);

    String responseCode = request.getParameter("vnp_ResponseCode");
    String message = "";
   
    if (!"00".equals(responseCode)) {
        message = "Unsuccessful. Error Code: " + responseCode;
    } else {
        message = "Successful!";
    }
%>

<html>
<head>
    <title>VNPAY Return</title>
</head>
<body>
    <h1>Payment Result</h1>

    <p style="<%= isValidSignature ? (responseCode.equals("00") ? "color:green;" : "color:red;") : "color:red;" %>">
        <%= message %>
    </p>

    <a href="/table-login">Back To Home</a>
</body>
</html>
