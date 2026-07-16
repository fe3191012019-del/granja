<%--
Document : ConsultaAvanzada
Created on : 06-10-2022, 10:19:59 PM
Author : user
--%>
<%--
Document : Consultax
Created on : 06-08-2022, 08:54:13 PM
Author : user
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="conexion.jsp"%>
<%@ include file="header.jsp"%>
<%@ include file="sesion.jsp"%>
<html>
    <head>
        <title>Consulta X</title>
    </head>
        <div class="container">
            <h2>Consulta de huevos ingresado a la nacedora</h2>
            <div>
                <div class="row col-md-7">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                               <th>Id Salida de Incubadora</th> 
                               <th>Id tipo huevo</th>
                               <th>Numero de nacedora</th>
                                 <th>Fecha de ingreso</th>
                               <th>cantidad</th>     
                         
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            st = conexion.prepareStatement("SELECT * FROM ingresonacedora" );
                                                  
                        
                            rs = st.executeQuery();

                            while (rs.next()) {
                            %>
                            <tr>
                                <td><%=rs.getString("id")%></td>
                                <td><%=rs.getString("id_salidain")%></td>
                                <td><%=rs.getString("id_tipohuevo")%></td>
                                <td><%=rs.getString("n_nacedora")%></td>
                                 <td><%=rs.getString("fecha")%></td>
                                <td><%=rs.getString("cantidad")%></td>
                               
                                
                         
                            </tr>
                            <%
                            }
                            conexion.close();
                            %>
                        </tbody>
                    </table>
                    <%@ include file="footer.jsp"%>
                </div>
                <a href="Menu.jsp" class="form-log-in-with-existing">Regresar a <b> Menú
                        Principal </b></a>
            </div>
    </body>
</html>