<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Menu</title>
    <link rel="stylesheet" href="../assets/menu-create-style/styles4.css"/>
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
            <h2 class="form-title">Add Menu</h2>

        <form method="post" action="menu-item-create" enctype="multipart/form-data">
            <label>
                <span>Item Name</span>
                <input type="text" name="name" placeholder="Item Name" required>
            </label>

            <label>
                <span>Price</span>
                <input type="number" step="0.01" name="price" placeholder="Price" required>
            </label>

            <label>
                <span>Time to cook</span>
                <input type="number" name="time" placeholder="Time to cook" required>
            </label>

            <label>
                <span>Type</span>
                <select name="type">
                    <option value="food">Food</option>
                    <option value="drink">Drink</option>
                    <option value="desseart">Dessert</option>
                </select>
            </label>

            <label>
                <span>Image</span>
                <input type="file" name="image" accept="image/*" required>
            </label>

            <div class="button-container">
                <button type="submit" class="custom-button">Add Item</button>
            </div>
        </form>
    </div>
        </div>

</body>
</html>
