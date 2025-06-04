<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"chef".equals(role)) {
        response.sendRedirect("/restaurant/access-denied.jsp");
        return;
    }
%>