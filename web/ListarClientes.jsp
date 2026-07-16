<%-- 
    Document   : ListarClientes
    Created on : 05-23-2022, 04:28:42 PM
    Author     : user


--%>


<%@ include file="conexion.jsp"%>
<%@ include file="header.jsp"%>
<%@ include file="sesion.jsp"%>
<html>
    <head>
        <title>Consulta de Catalogo de Cuentas</title>
    </head>
    <body>

        <div class="container">
            <h2>Listado de Clientes</h2>
            <hr>
            <div class="row col-md-7">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Telefono</th>
                            <th>Movil</th>
                            <th>Eliminar</th>
                            <th>Ver</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  st = conexion.prepareStatement("select * from clientes");
                            rs = st.executeQuery();
                            while (rs.next()) {
                        %>
                        <tr>
                            <td><%=rs.getString("idcliente")%></td>
                            <td><%=rs.getString("nombres")%></td>
                            <td><%=rs.getString("apellidos")%></td>
                            <td><%=rs.getString("telefono")%></td>
                            <td><%=rs.getString("celular")%></td>
                            <td><a class="btn btn-warning" href='eliminar.jsp?id=<%=rs.getString("idcliente")%>'>Eliminar</a></td>
                            <td><a class="btn btn-success" href='consultar.jsp?id=<%=rs.getString("idcliente")%>'>Consultar</a></td>
                        </tr>
                        <%
                            }
                            conexion.close();
                        %>
                    </tbody>
                </table>
                <%@ include file="footer.jsp"%>
            </div>
        <a href="Menu.jsp" class="form-log-in-with-existing">Regresar a <b> Menú Principal </b></a>
        </div>
    </body>
</html>