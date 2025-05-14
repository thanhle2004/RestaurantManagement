<%--<%@ page session="true" %>
<% 
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("chef")) {
        response.sendRedirect(request.getContextPath() + "/restaurant-login.jsp");
        return;
    }
%>--%>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !"chef".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>