<%-- 
    Document   : listarVentas
    Created on : 16 jul. 2026, 23:29:30
    Author     : Marvin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>

<%
    if(session.getAttribute("id_usuario")==null){
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<%@include file="../conexion.jsp"%>
<%@include file="../header.jsp"%>
<link rel="stylesheet" href="../css/bootstrap.min.css">

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Listado de Ventas</title>
    
    
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    

</head>

<body>

<div class="container">

    <div class="panel panel-primary">

        <div class="panel-heading">

            <h3 class="panel-title">

                Listado de Ventas

            </h3>
            <div class="row" style="margin-bottom:15px;">

                    <div class="col-md-6">

                        <a href="../Menu.jsp" class="btn btn-default">
                            ← Menú Principal
                        </a>

                    </div>

                    <div class="col-md-6 text-right">

                        <a href="nuevaVenta.jsp" class="btn btn-success">
                            + Nueva Venta
                        </a>

                    </div>

                </div>
        </div>

        <div class="panel-body">

<table class="table table-bordered table-hover">

    <thead>

        <tr>

            <th>ID</th>
            <th>Cliente</th>
            <th>Documento</th>
            <th>Fecha</th>
            <th>Subtotal</th>
            <th>IVA</th>
            <th>Total</th>
            <th>Acciones</th>

        </tr>

    </thead>
    <%
    SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:mm");
DecimalFormat moneda = new DecimalFormat("#,##0.00");
%>

<%

PreparedStatement ps = conexion.prepareStatement(

"SELECT "
+ "v.id,"
+ "v.numero_documento,"
+ "CONCAT(c.nombres,' ',c.apellidos) AS cliente,"
+ "v.tipo_documento,"
+ "v.fecha,"
+ "v.subtotal,"
+ "v.iva,"
+ "v.total "
+ "FROM ventas v "
+ "INNER JOIN clientes c "
+ "ON v.id_cliente=c.id "
+ "ORDER BY v.id DESC"

);

ResultSet rsVentas = ps.executeQuery();

while(rsVentas.next()){
%>
<tr>
    <td><%=rsVentas.getInt("id")%></td>

    <td><%=rsVentas.getString("cliente")%></td>
    
    <td>
    <span class="label label-primary">
        <%=rsVentas.getString("numero_documento")%>
    </td>

    <td><%=formato.format(rsVentas.getTimestamp("fecha"))%></td>

    <td>$ <%=moneda.format(rsVentas.getDouble("subtotal"))%></td>
    
    <td>$ <%=moneda.format(rsVentas.getDouble("iva"))%></td>
    
    <td>$ <%=moneda.format(rsVentas.getDouble("total"))%></td>

    <td>
        <a href="detalleVenta.jsp?id=<%=rsVentas.getInt("id")%>"
           class="btn btn-info btn-sm">
            Ver
        </a>
    </td>
</tr>

<%

}

rsVentas.close();
ps.close();

%>

    

</table>