<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chilling Restaurant</title>
</head>
<body>
    <h2>Verify OTP</h2>

    <% String phone = (String) session.getAttribute("phone"); %>
    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <label>OTP sent to phone <%= phone %>:</label><br>
        <input type="text" name="otp" required><br><br>
        <button type="submit">Verify</button>
    </form>

    <% String otp = (String) request.getAttribute("otp"); %>
</body>
</html>