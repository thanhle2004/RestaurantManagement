<%@page import="com.chilling.restaurant.model.Table"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Table table = (Table) session.getAttribute("table");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thank You</title>
    <script type="text/javascript">
        window.onload = function() {
            setTimeout(function() {
                document.getElementById("auto-submit-form").submit();
            }, 10000);
        };
    </script>
</head>
<body>
    <h2>Thank you for your feedback!</h2>
    <p>Your rating and comment have been successfully submitted.</p>
    <form id="auto-submit-form" action="/restaurant/table-login" method="post">
        <input type="hidden" name="id" value="<%= table.getTable_id()%>">
        <input type="hidden" name="password" value="<%= table.getTable_password()%>">
    </form>
</body>
</html>
