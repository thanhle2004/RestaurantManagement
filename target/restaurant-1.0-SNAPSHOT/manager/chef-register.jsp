<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<html>
<head>
    <title>Chilling Restaurant</title>
</head>
<body>
    <h2>Add new chef</h2>
    <form method="post" action="chef-register">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        First Name: <input type="text" name="lname" required><br>
        Last Name: <input type="text" name="fname" required><br>
        Phone Number: <input type="text" name="phone"><br>
        <input type="hidden" name="role" value="chef">
        <button type="submit">Register new chef</button>
    </form>
</body>
</html>
