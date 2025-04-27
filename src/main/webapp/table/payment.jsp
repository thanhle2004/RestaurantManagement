<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String qrFileName = (String) request.getAttribute("qrFileName");
    String paymentUrl = (String) request.getAttribute("paymentUrl");
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Payment</title></head>
<body>
    <h2>Thanh toán qua mã QR</h2>
    <p>Quét mã QR dưới đây để thanh toán cho đơn hàng:</p>
    <img src="<%= request.getContextPath() %>/images/<%= qrFileName %>"
         alt="QR Code thanh toán" width="200" height="200"/>

    <p>Hoặc nhấn liên kết dưới đây để thanh toán trực tiếp:</p>
    <a href="<%= paymentUrl %>" target="_blank">Thanh toán trực tiếp qua VNPay</a>
</body>
</html>