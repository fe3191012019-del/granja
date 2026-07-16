<%
    String usuario = "";
%>

<%
    if (session.getAttribute("login") == null || session.getAttribute("login") == " ") //check condition unauthorize user not direct access welcome.jsp page
    {
        //response.sendRedirect("index.jsp");
%>

<jsp:forward page="index.jsp">
    <jsp:param name="error" value="Es obligatorio identificarse"/>
</jsp:forward>
<%
    } else {

        usuario = (String) session.getAttribute("login");
    }
%>
