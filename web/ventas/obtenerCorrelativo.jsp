<%-- 
    Document   : obtenerCorrelativo
    Created on : 19 jul. 2026, 22:39:34
    Author     : Marvin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
String tipo = request.getParameter("tipo");

if(tipo == null || tipo.trim().equals("")){
    out.print("");
    return;
}

PreparedStatement ps = conexion.prepareStatement(
    "SELECT ultimo_numero FROM correlativos WHERE tipo_documento=?");

ps.setString(1, tipo);

ResultSet rsCorrelativo = ps.executeQuery();

String numero = tipo + "-000001";

if(rsCorrelativo.next()){

    int siguiente = rsCorrelativo.getInt("ultimo_numero") + 1;

    numero = tipo + "-" + String.format("%06d", siguiente);

}

out.print(numero);

rsCorrelativo.close();
ps.close();
%>