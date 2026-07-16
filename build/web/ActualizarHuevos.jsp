<%-- 
    Document   : ActualizarHuevos
    Created on : 7 jul. 2026, 23:31:48
    Author     : Marvin
--%>

<%@page import="java.sql.*"%>

<%

Class.forName("com.mysql.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost/incubacion",
"root",
""
);

PreparedStatement ps=con.prepareStatement(

"UPDATE ingresohuevos SET lote=?,proveedor=?,tipo_huevo=?,cantidad=?,fecha_ingreso=?,observaciones=? WHERE id=?"

);

ps.setString(1,request.getParameter("lote"));
ps.setString(2,request.getParameter("proveedor"));
ps.setString(3,request.getParameter("tipo"));
ps.setInt(4,Integer.parseInt(request.getParameter("cantidad")));
ps.setString(5,request.getParameter("fecha"));
ps.setString(6,request.getParameter("observaciones"));
ps.setInt(7,Integer.parseInt(request.getParameter("id")));

ps.executeUpdate();

con.close();

response.sendRedirect("ListarHuevos.jsp");

%>