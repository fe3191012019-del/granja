<%-- 
    Document   : GuardarHuevos
    Created on : 7 jul. 2026, 22:32:33
    Author     : Marvin
--%>

<%@page import="java.sql.*"%>

<%
Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost/incubacion",
"root",
""
);

PreparedStatement ps = con.prepareStatement(
"INSERT INTO ingresohuevos(lote,proveedor,tipo_huevo,cantidad,fecha_ingreso,observaciones) VALUES(?,?,?,?,?,?)"
);

ps.setString(1,request.getParameter("lote"));
ps.setString(2,request.getParameter("proveedor"));
ps.setString(3,request.getParameter("tipo"));
ps.setInt(4,Integer.parseInt(request.getParameter("cantidad")));
ps.setString(5,request.getParameter("fecha"));
ps.setString(6,request.getParameter("observaciones"));

ps.executeUpdate();

con.close();

response.sendRedirect("ListarHuevos.jsp");
%>