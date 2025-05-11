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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/table-login-style/styles10.css"/>
</head>
<body>
    <header class="manager-header">
        <a href="manager-dashboard.jsp" class="back-button header-back">← Back</a>
    </header>
    <h2 class="form-title">Tables</h2>
    <div class="form-container">
        <form method="post" action="table-login">
            <div class="seat">
                <h3>Two seats</h3>
                <div class="button-group">
                    <%
                        for (Table tableTypeTwo : tableTypeTwoList) {
                    %>
                        <button type="button" class="table-button" onclick="selectTable('<%= tableTypeTwo.getTable_id() %>', '<%= tableTypeTwo.getTable_number() %>')">
                            Table <%= tableTypeTwo.getTable_number() %>
                        </button>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="seat">
                <h3>Four seats</h3>
                <div class="button-group">
                    <%
                        for (Table tableTypeFour : tableTypeFourList) {
                    %>
                        <button type="button" class="table-button" onclick="selectTable('<%= tableTypeFour.getTable_id() %>', '<%= tableTypeFour.getTable_number() %>')">
                            Table <%= tableTypeFour.getTable_number() %>
                        </button>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="seat">
                <h3>Eight seats</h3>
                <div class="button-group">
                    <%
                        for (Table tableTypeEight : tableTypeEightList) {
                    %>
                        <button type="button" class="table-button" onclick="selectTable('<%= tableTypeEight.getTable_id() %>', '<%= tableTypeEight.getTable_number() %>')">
                            Table <%= tableTypeEight.getTable_number() %>
                        </button>
                    <%
                        }
                    %>
                </div>
            </div>
            <div id="loginSection" style="display: none;">
                            <input type="hidden" name="id" id="selectedTableId" />

                <p id="selectedTableNumber"></p>
                <label>
                    <span>Password</span>
                    <input type="password" name="password" placeholder="Enter password" required />
                </label>
                <div class="button-container">
                    <button type="submit" class="custom-button">Login</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>