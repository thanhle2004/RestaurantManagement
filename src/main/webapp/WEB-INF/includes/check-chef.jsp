<%
    String role = (String) session.getAttribute("role");
    if(role == null || !"chef".equals(role)) {
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>