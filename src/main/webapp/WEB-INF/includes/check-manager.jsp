<% 
    String role = (String) session.getAttribute("role");
    if (role == null || !"manager".equals(role)) {
        response.sendRedirect("/restaurant/access-denied.jsp");
        return;
    }
%>