<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Your Password</h2>

    <form action="reset-password" method="post">
        <label for="newPassword">New Password:</label><br>
        <input type="password" id="newPassword" name="newPassword" required><br><br>
        <label for="confirmNewPassword">New Password:</label><br>
        <input type="password" id="confirmNewPassword" name="confirmNewPassword" required><br><br>

        <button type="submit">Reset Password</button>
    </form>
</body>
</html>
