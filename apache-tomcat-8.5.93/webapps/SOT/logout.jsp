<%
    HttpSession sso = request.getSession(true);
    sso.removeAttribute("username");
    response.sendRedirect("/SOT/index.jsp");
%>