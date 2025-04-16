<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    List<Integer> tableList = (List<Integer>) request.getAttribute("tables");
%>
<html>
<head>
    <title>Chilling Restaurant</title>
</head>
<body>
    <h2>Tables</h2>
    <form method="post" action="table-login">
        <%
            for (Integer tableNum : tableList) {
        %>
            <button type="submit" name="tableNumber" value="<%=tableNum%>">Table <%=tableNum%></button>
        <%
            }
        %>
    </form>
</body>
</html>
