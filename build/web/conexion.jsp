<%-- 
    Document   : conexion
    Created on : 05-23-2022, 04:30:22 PM
    Author     : Castingwebs.com | RECastillo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    Connection conexion = null;
    PreparedStatement st = null;
    ResultSet rs = null;

//Leemos el driver MySQL
    Class.forName("com.mysql.jdbc.Driver");

//Obtenemos la conexion con la base de datos
    conexion = DriverManager.getConnection("jdbc:mysql://localhost/incubacion", "root", "");

%>

