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
            <h2>Consulta de huevos ingresados por fecha</h2>
            <div>
                <div class="row col-md-7">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                               <th>tipohuevo</th> 
                                <th>cantidad</th>                                 
                                <th>Fecha</th>
                                <th>Nota</th>
                                       
                               
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            st = conexion.prepareStatement("SELECT * FROM inhuevo" );
                                                  
                        
                            rs = st.executeQuery();

                            while (rs.next()) {
                            %>
                            <tr>
                                <td><%=rs.getString("id")%></td>
                                <td><%=rs.getString("tipohuevo")%></td>
                                <td><%=rs.getString("cantidad")%></td>
                                <td><%=rs.getString("fecha")%></td>
                                <td><%=rs.getString("nota")%></td>
                         
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