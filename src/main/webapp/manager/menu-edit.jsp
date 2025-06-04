<%@page import="com.chilling.restaurant.model.MenuItem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>

<%
   MenuItem item = (MenuItem) request.getAttribute("item");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chilling Restaurant - Edit Menu</title>
    <link rel="stylesheet" href="../assets/menu-edit-style/styles5.css"/>
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
<body>
  <div class="container">
    <aside class="sidebar">
        <a href="menu-management" class="sidebar-link-active"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M160-120q-33 0-56.5-23.5T80-200v-120h800v120q0 33-23.5 56.5T800-120H160Zm0-120v40h640v-40H160Zm320-180q-36 0-57 20t-77 20q-56 0-76-20t-56-20q-36 0-57 20t-77 20v-80q36 0 57-20t77-20q56 0 76 20t56 20q36 0 57-20t77-20q56 0 77 20t57 20q36 0 56-20t76-20q56 0 79 20t55 20v80q-56 0-75-20t-55-20q-36 0-58 20t-78 20q-56 0-77-20t-57-20ZM80-560v-40q0-115 108.5-177.5T480-840q183 0 291.5 62.5T880-600v40H80Zm400-200q-124 0-207.5 31T166-640h628q-23-58-106.5-89T480-760Zm0 520Zm0-400Z"/></svg>Back</a>
    </aside>

    <div class="form-container">
        <h2 class="form-title">Edit Menu</h2>
        <form method="post" action="<%= request.getContextPath() %>/manager/menu-update" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= item.getItemId() %>">

            <label><span>Name</span>
                <input type="text" name="name" value="<%= item.getItemName() %>" required>
            </label>

            <label><span>Price</span>
                <input type="number" step="0.01" name="price" value="<%= item.getItemPrice() %>" required>
            </label>

            <label><span>Time to cook</span>
                <input type="number" name="time" value="<%= item.getItemTimeCook() %>" required>
            </label>

            <label><span>Type</span>
                <select name="type">
                    <option value="food" <%= item.getItemType().equals("food") ? "selected" : "" %>>Food</option>
                    <option value="drink" <%= item.getItemType().equals("drink") ? "selected" : "" %>>Drink</option>
                    <option value="drink" <%= item.getItemType().equals("dessert") ? "selected" : "" %>>Dessert</option>
                </select>
            </label>

            <label class="img-preview">
                <span>Current Image</span>
                <img src="<%= item.getItemImgPath() %>" alt="Item Image">
            </label>

            <label><span>Change Image</span>
                <input type="file" name="image" accept="image/*">
            </label>

                <button type="submit" class="custom-button">Update</button>

            </div>
        </form>
    </div>
</div>
</body>
</html>