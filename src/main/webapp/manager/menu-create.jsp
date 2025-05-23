<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Menu</title>
    <link rel="stylesheet" href="../assets/menu-create-style/styles4.css"/>
</head>
<body>
    <header class="manager-header">
    <a href="menu-management" class="back-button header-back">← Back</a>
</header>

    <h2 class="form-title">Add Menu</h2>
    <div class="form-container">
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
</body>
</html>
