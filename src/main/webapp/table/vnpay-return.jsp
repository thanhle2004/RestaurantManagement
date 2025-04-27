<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String> fields = new HashMap<>();
    for (Enumeration<?> params = request.getParameterNames(); params.hasMoreElements();) {
        String fieldName = (String) params.nextElement();
        String fieldValue = request.getParameter(fieldName);
        if ((fieldValue != null) && (fieldValue.length() > 0)) {
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

    String signValue = com.chilling.restaurant.config.VNPayConfig.hmacSHA512(com.chilling.restaurant.config.VNPayConfig.vnp_HashSecret, 
        fields.entrySet().stream()
            .sorted(Map.Entry.comparingByKey())
            .map(e -> e.getKey() + "=" + e.getValue())
            .reduce((a, b) -> a + "&" + b)
            .orElse("")
    );
%>

<html>
<head>
    <title>VNPAY Return</title>
</head>
<body>
    <h1>Payment Result</h1>

    <%
    if (signValue.equals(vnp_SecureHash)) {
        if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
    %>
        <p style="color:green;">Giao dịch thành công!</p>
    <%  } else { %>
        <p style="color:red;">Giao dịch không thành công. Mã lỗi: <%= request.getParameter("vnp_ResponseCode") %></p>
    <%  }
    } else { %>
        <p style="color:red;">Xác thực không hợp lệ!</p>
    <% } %>

    <a href="/your-project/table-menu">Quay lại Menu</a>
</body>
</html>
