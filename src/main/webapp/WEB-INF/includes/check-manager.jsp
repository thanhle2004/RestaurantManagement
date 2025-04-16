<% 
    String role = (String) session.getAttribute("role");
    if (role == null || !"manager".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/restaurant-login.jsp");
        return;
    }
%>