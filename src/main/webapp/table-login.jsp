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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/table-login-style/styles10.css"/>
    <script>
        function selectTable(tableId, tableNumber) {
            document.getElementById("selectedTableId").value = tableId;
            document.getElementById("selectedTableNumber").innerText = "Selected Table: " + tableNumber;
            document.getElementById("selectedTableOverlay").style.display = "flex";
        }

        function closeOverlay() {
            document.getElementById("selectedTableOverlay").style.display = "none";
        }
    </script>
    <script>
        function enterFullScreen() {
            const elem = document.documentElement; 

            if (elem.requestFullscreen) {
              elem.requestFullscreen();
            } else if (elem.webkitRequestFullscreen) { 
              elem.webkitRequestFullscreen();
            } else if (elem.msRequestFullscreen) { 
              elem.msRequestFullscreen();
            }
        }

        function exitFullScreen() {
            if (document.exitFullscreen) {
              document.exitFullscreen();
            } else if (document.webkitExitFullscreen) { 
              document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) { 
              document.msExitFullscreen();
            }
        }
    </script>
</head>
<body>
    <header class="manager-header">
        <a href="index.jsp" class="back-button header-back">← Back</a>
    </header>

    <h2 class="form-title">Tables</h2>

    <div class="form-container">
        <form method="post" action="table-login">
            <div class="total_seat">
                <div class="seat">
                    <h3>Two seats</h3>
                    <div class="button-group">
                        <%
                            for (Table table : tableTypeTwoList) {
                        %>
                            <button type="button" class="table-button"
                                    onclick="selectTable('<%= table.getTable_id() %>', '<%= table.getTable_number() %>')">
                                Table <%= table.getTable_number() %>
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
                            for (Table table : tableTypeFourList) {
                        %>
                            <button type="button" class="table-button"
                                    onclick="selectTable('<%= table.getTable_id() %>', '<%= table.getTable_number() %>')">
                                Table <%= table.getTable_number() %>
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
                            for (Table table : tableTypeEightList) {
                        %>
                            <button type="button" class="table-button"
                                    onclick="selectTable('<%= table.getTable_id() %>', '<%= table.getTable_number() %>')">
                                Table <%= table.getTable_number() %>
                            </button>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>

            <input type="hidden" name="id" id="selectedTableId" />

            <div id="selectedTableOverlay" class="modal">
                <div class="modal-content">
                    <span class="close-button" onclick="closeOverlay()">×</span>
                    <h3 class="modal-title" id="selectedTableNumber"></h3>
                    <div class="login-inputs">
                        <label>
                            <span>Password</span>
                            <input type="password" name="password" placeholder="Enter password" required />
                        </label>
                        <div class="button-container">
                            <button type="submit" class="custom-button">Login</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
