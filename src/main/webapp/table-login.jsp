<%@page import="com.chilling.restaurant.model.Table"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    List<Table> tableTypeTwoList = (List<Table>) request.getAttribute("tableTypeTwoList");
    List<Table> tableTypeFourList = (List<Table>) request.getAttribute("tableTypeFourList");
    List<Table> tableTypeEightList = (List<Table>) request.getAttribute("tableTypeEightList");
%>
<html>
<head>
    <title>Chilling Restaurant</title>
    <script>
        function selectTable(tableId, tableNumber) {
            document.getElementById("selectedTableId").value = tableId;
            document.getElementById("selectedTableNumber").innerText = "Selected Table: " + tableNumber;
            document.getElementById("loginSection").style.display = "block";
        }
    </script>
</head>
<body>
    <h2>Tables</h2>
    <form method="post" action="table-login">
        <h3>Two seats</h3>
        <%
            for (Table tableTypeTwo : tableTypeTwoList) {
        %>
            <button type="button" onclick="selectTable('<%= tableTypeTwo.getTable_id() %>', '<%= tableTypeTwo.getTable_number() %>')">
                Table <%= tableTypeTwo.getTable_number() %>
            </button>
        <%
            }
        %>
        <h3>Four seats</h3>
        <%
            for (Table tableTypeFour : tableTypeFourList) {
        %>
            <button type="button" onclick="selectTable('<%= tableTypeFour.getTable_id() %>', '<%= tableTypeFour.getTable_number() %>')">
                Table <%= tableTypeFour.getTable_number() %>
            </button>
        <%
            }
        %>
        <h3>Eight seats</h3>
        <%
            for (Table tableTypeEight : tableTypeEightList) {
        %>
            <button type="button" onclick="selectTable('<%= tableTypeEight.getTable_id() %>', '<%= tableTypeEight.getTable_number() %>')">
                Table <%= tableTypeEight.getTable_number() %>
            </button>
        <%
            }
        %>

        <!-- Hidden field to store selected table id -->
        <input type="hidden" name="id" id="selectedTableId" />

        <div id="loginSection" style="display: none;">
            <p id="selectedTableNumber"></p>
            <input type="password" name="password" placeholder="Enter password" required /><br>
            <button type="submit">Login</button>
        </div>
    </form>
</body>
</html>

