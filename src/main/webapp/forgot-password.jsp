<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chilling Restaurant</title>
</head>
<body>
    <h2>Forgot Password</h2>
    
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <label for="phone">Enter your phone number:</label><br>
        <input type="text" id="phone" name="phone" required><br><br>
        <button type="submit">Send Verification Code</button>
    </form>
</body>
</html>