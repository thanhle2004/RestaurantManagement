<%@ page import="java.util.*, com.chilling.restaurant.model.MenuItem" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<%
    List<MenuItem> foods = (List<MenuItem>) request.getAttribute("foodList");
    List<MenuItem> drinks = (List<MenuItem>) request.getAttribute("drinkList");
    List<MenuItem> desserts = (List<MenuItem>) request.getAttribute("dessertList");
%>

<html>
<head>
    <title>Chilling Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/menu-management-style/styles3.css"/> 
    <style>
    html, body {
      height: 100%;
      overflow: auto;
      scrollbar-width: none; /* Firefox */
    }

    html::-webkit-scrollbar,
    body::-webkit-scrollbar {
      display: none; /* Chrome, Safari, Edge */
    }
    </style>
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
<header class="manager-header">
    <a href="manager-dashboard.jsp" class="back-button header-back">← Back</a>
</header>
<body>
    <h2>Menu</h2>
    <a href="<%= request.getContextPath() %>/manager/menu-create.jsp">➕ Add menu</a>
    
    <h3>Food</h3>
    <table border="1" cellpadding="5">
        <tr>
            <th>N.0</th>
            <th>Image</th>
            <th>Name</th>
            <th>Price</th>
            <th>Time Cook</th>
            <th>Action</th>
        </tr>
        <%
            int foodCount = 0;
            for (MenuItem food : foods) {
                foodCount++;
        %>
        <tr>
            <td><%= foodCount %></td>
            <td>
                <img src="<%= food.getItemImgPath() %>" width="100">
            </td>
            <td><%= food.getItemName() %></td>
            <td><%= food.getItemPrice() %></td>
            <td><%= food.getItemTimeCook() %></td>
            <td>
                <a href="menu-edit?id=<%= food.getItemId() %>">Edit</a>
                <a href="menu-delete?id=<%= food.getItemId() %>" onclick="return confirm('Delete this food?')">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <h3>Drink</h3>
    <table border="1" cellpadding="5">
        <tr>
            <th>N.0</th>
            <th>Image</th>
            <th>Name</th>
            <th>Price</th>
            <th>Time Cook</th>
            <th>Action</th>
        </tr>
        <%
            int drinkCount = 0;
            for (MenuItem drink : drinks) {
                drinkCount++;
        %>
        <tr>
            <td><%= drinkCount %></td>
            <td>
                <img src="<%= drink.getItemImgPath() %>" width="100">
            </td>
            <td><%= drink.getItemName() %></td>
            <td><%= drink.getItemPrice() %></td>
            <td><%= drink.getItemTimeCook() %></td>
            <td>
                <a href="menu-edit?id=<%= drink.getItemId() %>">Edit</a>
                <a href="menu-delete?id=<%= drink.getItemId() %>" onclick="return confirm('Delete this drink?')">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    
    <h3>Dessert</h3>
    <table border="1" cellpadding="5">
        <tr>
            <th>N.0</th>
            <th>Image</th>
            <th>Name</th>
            <th>Price</th>
            <th>Time Cook</th>
            <th>Action</th>
        </tr>
        <%
            int dessertCount = 0;
            for (MenuItem dessert : desserts) {
                dessertCount++;
        %>
        <tr>
            <td><%= dessertCount %></td>
            <td>
                <img src="<%= dessert.getItemImgPath() %>" width="100">
            </td>
            <td><%= dessert.getItemName() %></td>
            <td><%= dessert.getItemPrice() %></td>
            <td><%= dessert.getItemTimeCook() %></td>
            <td>
                <a href="menu-edit?id=<%= dessert.getItemId() %>">Edit</a>
                <a href="menu-delete?id=<%= dessert.getItemId() %>" onclick="return confirm('Delete this dessert?')">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>