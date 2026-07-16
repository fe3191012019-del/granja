<%-- 
    Document   : IngresoHuevos
    Created on : 7 jul. 2026, 22:29:39
    Author     : Marvin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>

<div class="container">

<h2>Ingreso de Huevos</h2>

<form action="GuardarHuevos.jsp" method="post">

<div class="form-group">
<label>Lote</label>
<input type="text" name="lote" class="form-control" required>
</div>

<div class="form-group">
<label>Proveedor</label>
<input type="text" name="proveedor" class="form-control" required>
</div>

<div class="form-group">
<label>Tipo de Huevo</label>
<input type="text" name="tipo" class="form-control" required>
</div>

<div class="form-group">
<label>Cantidad</label>
<input type="number" name="cantidad" class="form-control" required>
</div>

<div class="form-group">
<label>Fecha de Ingreso</label>
<input type="date" name="fecha" class="form-control" required>
</div>

<div class="form-group">
<label>Observaciones</label>
<textarea name="observaciones" class="form-control"></textarea>
</div>

<br>

<input type="submit" value="Guardar" class="btn btn-success">

<a href="Menu.jsp" class="btn btn-secondary">
Cancelar
</a>

</form>

</div>

<%@include file="footer.jsp"%>