<%-- 
    Document   : EditarHuevos
    Created on : 7 jul. 2026, 23:23:15
    Author     : Marvin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="header.jsp"%>

<%

int id=Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost/incubacion",
"root",
""
);

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM ingresohuevos WHERE id=?"
);

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

rs.next();

%>

<div class="container">

<h2>Editar Registro de Huevos</h2>

<hr>

<form action="ActualizarHuevos.jsp" method="post">

<input type="hidden"
       name="id"
       value="<%=rs.getInt("id")%>">

<div class="form-group">

<label>Lote</label>

<input type="text"
       name="lote"
       class="form-control"
       value="<%=rs.getString("lote")%>">

</div>

<div class="form-group">

<label>Proveedor</label>

<input type="text"
       name="proveedor"
       class="form-control"
       value="<%=rs.getString("proveedor")%>">

</div>

<div class="form-group">

<label>Tipo de Huevo</label>

<input type="text"
       name="tipo"
       class="form-control"
       value="<%=rs.getString("tipo_huevo")%>">

</div>

<div class="form-group">

<label>Cantidad</label>

<input type="number"
       name="cantidad"
       class="form-control"
       value="<%=rs.getInt("cantidad")%>">

</div>

<div class="form-group">

<label>Fecha</label>

<input type="date"
       name="fecha"
       class="form-control"
       value="<%=rs.getDate("fecha_ingreso")%>">

</div>

<div class="form-group">

<label>Observaciones</label>

<textarea
name="observaciones"
class="form-control"><%=rs.getString("observaciones")%></textarea>

</div>

<br>

<input type="submit"
       value="Actualizar"
       class="btn btn-success">

<a href="ListarHuevos.jsp"
   class="btn btn-secondary">

Cancelar

</a>

</form>

</div>

<%@ include file="footer.jsp"%>