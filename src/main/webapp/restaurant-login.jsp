<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chilling Restaurant</title>
    </head>
    <body>
        <h2>Restaurant Login</h2>
        <form method="post" action="restaurant-login">
            Username: <input type="text" name="username" /><br><br>
            Password: <input type="password" name="password" /><br><br>
            <button type="submit">Login</button>
            <button type="button" onclick="window.location.href='index.jsp'">Back</button>
        </form>
        
    </body>
</html>
