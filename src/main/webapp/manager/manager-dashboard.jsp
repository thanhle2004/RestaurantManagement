<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chilling Restaurant</title>
    <link rel="stylesheet" href="../assets/manager-dashboard-style/styles2.css"/> 
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&display=swap" rel="stylesheet">
</head>
<header class="manager-header">
    <a href="/restaurant/restaurant-login.jsp" class="back-button header-back">← Back</a>
</header>
<body>
    <h1 class="title">Hello Manager</h1>

    <div class="button-container">
        <a href="chef-management" class="custom-button">Chefs</a>
        <a href="table-management" class="custom-button">Tables</a>
        <a href="menu-management" class="custom-button">Menu</a>
    </div>
</body>
</html>
