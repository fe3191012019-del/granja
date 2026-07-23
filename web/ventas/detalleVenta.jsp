<%-- 
    Document   : detalleVenta.jsp
    Created on : 17 jul. 2026, 00:29:55
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

<%
SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy HH:mm");
DecimalFormat moneda = new DecimalFormat("#,##0.00");

int idVenta = Integer.parseInt(request.getParameter("id"));

PreparedStatement psVenta = conexion.prepareStatement(

"SELECT " +
"v.id, " +
"v.numero_documento, " +
"v.fecha, " +
"v.tipo_documento, " +
"v.subtotal, " +
"v.iva, " +
"v.total, " +

"c.nombres, " +
"c.apellidos, " +
"c.telefono, " +
"c.correo, " +
"c.direccion, " +
"c.tipo_cliente, " +
"c.nit, " +
"c.nrc, " +
"c.giro, " +

"CONCAT(c.nombres,' ',c.apellidos) AS cliente " +

"FROM ventas v " +
"INNER JOIN clientes c ON v.id_cliente=c.id " +
"WHERE v.id=?"

);

psVenta.setInt(1,idVenta);

ResultSet venta = psVenta.executeQuery();

if(venta.next()){
String tipoDocumento = venta.getString("tipo_documento");
%>

<div class="container mt-4">

    <div class="text-center mb-3">

    <h2><b>GRANJAPRO ERP</b></h2>

    <h4>Granja Avícola Los Pinos</h4>

    <p>
        San Salvador, El Salvador<br>
        Tel: 2222-2222<br>
        Correo: ventas@granjapro.com
    </p>

</div>
    
<div class="card">

<div class="card-header bg-primary text-white">

<h3 class="text-center">

<%

if(tipoDocumento.equals("FCF")){

%>

FACTURA CONSUMIDOR FINAL

<%

}else{

%>

COMPROBANTE DE CRÉDITO FISCAL

<%

}

%>

</h3>

</div>

<div class="card-body">

<div class="row">

<div class="col-md-4">
    <b>No. Factura</b><br>
    <%=venta.getString("numero_documento")%>
</div>

<div class="col-md-4">
<b>Cliente</b><br>
<%=venta.getString("cliente")%>
</div>

<div class="col-md-4">
<b>Fecha</b><br>
<%=fecha.format(venta.getTimestamp("fecha"))%>
</div>
</div>

<hr>
<% if(tipoDocumento.equals("CCF")){ %>

<hr>

<br>

<div class="row">

    <div class="col-md-4">

        <b>Tipo Cliente</b><br>

        <%=venta.getString("tipo_cliente")%>

    </div>

    <div class="col-md-4">

        <b>NIT</b><br>

        <%=venta.getString("nit")==null?"":venta.getString("nit")%>

    </div>

    <div class="col-md-4">

        <b>NRC</b><br>

        <%=venta.getString("nrc")==null?"":venta.getString("nrc")%>

    </div>

</div>

<br>

<div class="row">

    <div class="col-md-6">

        <b>Giro</b><br>

        <%=venta.getString("giro")==null?"":venta.getString("giro")%>

    </div>

    <div class="col-md-6">

        <b>Dirección</b><br>

        <%=venta.getString("direccion")==null?"":venta.getString("direccion")%>

    </div>

</div>

<hr>

<% } %>
</div>

<br>

<table class="table table-bordered table-striped">

<thead class="table-dark">

<tr>

<th>Producto</th>
<th>Cantidad</th>
<th>Precio</th>
<th>Subtotal</th>

</tr>

</thead>

<tbody>

<%

PreparedStatement psDetalle = conexion.prepareStatement(

"SELECT p.nombre,d.cantidad,d.precio,d.subtotal " +
"FROM detalle_venta d " +
"INNER JOIN productos p ON d.id_producto=p.id " +
"WHERE d.id_venta=?"

);

psDetalle.setInt(1,idVenta);

ResultSet detalle = psDetalle.executeQuery();

while(detalle.next()){

%>

<tr>

<td><%=detalle.getString("nombre")%></td>

<td><%=detalle.getInt("cantidad")%></td>

<td>$ <%=moneda.format(detalle.getDouble("precio"))%></td>

<td>$ <%=moneda.format(detalle.getDouble("subtotal"))%></td>

</tr>

<%

}

%>

</tbody>

</table>
<% if(tipoDocumento.equals("FCF")){ %>

<div class="row">
    <div class="col-md-8 text-end">
        <h3><b>TOTAL:</b></h3>
    </div>

    <div class="col-md-4">
        <h3><b>$ <%=moneda.format(venta.getDouble("total"))%></b></h3>
    </div>
</div>

<% } else { %>

<div class="row">

    <div class="col-md-8 text-end">
        <h5>Subtotal:</h5>
        <h5>IVA:</h5>
        <h4><b>Total:</b></h4>
    </div>

    <div class="col-md-4">
        <h5>$ <%=moneda.format(venta.getDouble("subtotal"))%></h5>
        <h5>$ <%=moneda.format(venta.getDouble("iva"))%></h5>
        <h4><b>$ <%=moneda.format(venta.getDouble("total"))%></b></h4>
    </div>

</div>

<% } %>
<br>

<div class="mt-4">

    <button onclick="window.print()"
            class="btn btn-primary">

        🖨 Imprimir

    </button>

    <a href="listarVentas.jsp"
       class="btn btn-secondary">

        ← Regresar

    </a>

</div>

</div>

</div>

<%

detalle.close();
psDetalle.close();

}

venta.close();
psVenta.close();

%>
<style>

@media print{

    .btn{
        display:none;
    }

    .navbar{
        display:none;
    }

    nav{
        display:none;
    }

    .card{

        border:none;

        box-shadow:none;

    }

}

</style>