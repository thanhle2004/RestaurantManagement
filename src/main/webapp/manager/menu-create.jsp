<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chilling Restaurant</title>
    </head>
    <body>
        <h2>Add menu</h2>
        <form method="post" action="menu-item-create" enctype="multipart/form-data">
            <input type="text" name="name" placeholder="Item Name" required>
            <input type="number" step="0.01" name="price" placeholder="Price" required>
            <input type="number" name="time" placeholder="Time to cook" required>
            <select name="type">
                <option value="food">Food</option>
                <option value="drink">Drink</option>
            </select>
            <input type="file" name="image" accept="image/*" required>
            <button type="submit">Add Item</button>
        </form>

    </body>
</html>
