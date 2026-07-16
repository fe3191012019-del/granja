<%-- 
    Document   : EliminarHuevos
    Created on : 7 jul. 2026, 23:53:24
    Author     : Marvin
--%>
<%@page import="java.sql.*"%>

<%
int id = Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost/incubacion",
"root",
""
);

PreparedStatement ps = con.prepareStatement(
"DELETE FROM ingresohuevos WHERE id=?"
);

ps.setInt(1, id);

ps.executeUpdate();

con.close();

response.sendRedirect("ListarHuevos.jsp");
%>