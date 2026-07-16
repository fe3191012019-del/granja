<%-- 
    Document   : ListarHuevos
    Created on : 7 jul. 2026, 22:33:28
    Author     : Marvin
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="header.jsp" %>
<meta charset="UTF-8">
<div class="container">

    <h2 class="text-center">Listado de Huevos Ingresados</h2>

    <hr>

    <table class="table table-bordered table-hover table-striped">

        <tr>
            <th>ID</th>
            <th>Lote</th>
            <th>Proveedor</th>
            <th>Tipo</th>
            <th>Cantidad</th>
            <th>Fecha</th>
            <th>Observaciones</th>
            <th>Acciones</th>
        </tr>
        
         
        <%
            Class.forName("com.mysql.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost/incubacion",
                    "root",
                    "");

            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM ingresohuevos");

            while (rs.next()) {
        %>
<tr>

    <td><%=rs.getInt("id")%></td>
    <td><%=rs.getString("lote")%></td>
    <td><%=rs.getString("proveedor")%></td>
    <td><%=rs.getString("tipo_huevo")%></td>
    <td><%=rs.getInt("cantidad")%></td>
    <td><%=rs.getDate("fecha_ingreso")%></td>
    <td><%=rs.getString("observaciones")%></td>

    <td>

          
    <a href="EditarHuevos.jsp?id=<%=rs.getInt("id")%>"
       class="btn btn-warning btn-sm">
        Editar
    </a>

    <a href="EliminarHuevos.jsp?id=<%=rs.getInt("id")%>"
       class="btn btn-danger btn-sm"
       onclick="return confirm('¿Está seguro de eliminar este registro?');">
        Eliminar
    </a>
</td>

        <%
            }

            rs.close();
            st.close();
            con.close();
        %>

    </table>

    <br>

    <div class="text-center">

        <a href="IngresoHuevos.jsp" class="btn btn-success">
            Nuevo Registro
        </a>

        <a href="Menu.jsp" class="btn btn-primary">
            Menú Principal
        </a>

    </div>

</div>

<%@ include file="footer.jsp" %>