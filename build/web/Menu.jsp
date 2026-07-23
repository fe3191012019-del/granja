<%--
    Document   : Menu
    Created on : 7-07-2022, 10:25:36 PM
    Author     : MarvinFernandez
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
    String usuario = "";
%>

<%
    if (session.getAttribute("login") == null || session.getAttribute("login") == " ") //check condition unauthorize user not direct access welcome.jsp page
    {
        //response.sendRedirect("index.jsp");
%>

<jsp:forward page="index.jsp">
    <jsp:param name="error" value="Es obligatorio identificarse"/>
</jsp:forward>
<%
    } else {

        usuario = (String) session.getAttribute("login");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu principal</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed"
                            data-toggle="collapse" data-target="#navbar"
                            aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Desplegar navegación</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Centro de Incubación</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">

    <li class="active">
        <a href="Menu.jsp">Inicio</a>
    </li>

    <!-- Módulo de Ingreso -->
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            Módulo de Ingreso de Información <span class="caret"></span>
        </a>

        <ul class="dropdown-menu">

            <li><a href="IngresoHuevos.jsp">Ingreso de Huevos</a></li>

            <li><a href="IngresoIncubadora.jsp">Ingreso a Incubadora</a></li>

            <li><a href="IngresoNacedora.jsp">Ingreso a Nacedora</a></li>

            <li><a href="IngresoNacimiento.jsp">Nacimiento de Pollitos</a></li>

            <li><a href="IngresoMortalidad.jsp">Registro de Mortalidad</a></li>

        </ul>

    </li>
        <!-- Ventas -->

        <li class="dropdown">

            <a href="#" class="dropdown-toggle" data-toggle="dropdown">

                Ventas

                <span class="caret"></span>

            </a>

            <ul class="dropdown-menu">

                <li>
                    <a href="ventas/nuevaVenta.jsp">
                        Facturar
                    </a>
                </li>

                <li>
                    <a href="ventas/listarVentas.jsp">
                        Listado de Ventas
                    </a>
                </li>

            </ul>

        </li>           
    <!-- Consultas -->

    <li class="dropdown">

        <a href="#" class="dropdown-toggle" data-toggle="dropdown">

            Consultas

            <span class="caret"></span>

        </a>

        <ul class="dropdown-menu">

            <li><a href="ListarHuevos.jsp">Lista de Huevos Ingresados</a></li>

            <li><a href="huevosincubados.jsp">Huevos Incubados</a></li>

            <li><a href="huevonacedora.jsp">Huevos en Nacedora</a></li>

            <li><a href="Pollitosvivos.jsp">Pollitos Nacidos</a></li>

        </ul>

    </li>

    <!-- Reportes -->

    <li class="dropdown">

        <a href="#" class="dropdown-toggle" data-toggle="dropdown">

            Reportes

            <span class="caret"></span>

        </a>

        <ul class="dropdown-menu">

            <li><a href="ReporteHuevos.jsp">Reporte de Huevos</a></li>

            <li><a href="ReporteIncubacion.jsp">Reporte de Incubación</a></li>

            <li><a href="ReporteNacimiento.jsp">Reporte de Nacimientos</a></li>

        </ul>

    </li>

</ul>
                    
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="logout.jsp">
                                <%=usuario%> (cerrar sesión)</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <h3>PROCESO DE IDENTIFICACIÓN</h3>
            <p>
            <h5>Menú de administración</h5>
            <b>Usuario activo:</b> <%=usuario%>
        </p>
    </div>
</body>
</html>