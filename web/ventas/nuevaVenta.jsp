<%-- 
    Document   : nuevaVenta
    Created on : 16 jul. 2026, 20:45:23
    Author     : Marvin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>
<%@include file="../header.jsp"%>

<%
    if (session.getAttribute("login") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Nueva Venta</title>

   <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>

    <style>
        body{
            background:#f5f5f5;
        }

        .panel{
            margin-top:20px;
        }

        table th{
            text-align:center;
        }

        table td{
            vertical-align:middle !important;
        }

        .total{
            font-size:22px;
            font-weight:bold;
        }
    </style>

</head>

<body>



<div class="container">

<div class="panel panel-primary">

<div class="panel-heading">

<h3 class="panel-title">
Nueva Venta
</h3>

    <div class="panel-body">

    <div class="row" style="margin-bottom:20px;">

        <div class="col-md-6">

            <a href="../Menu.jsp" class="btn btn-default">
                <span class="glyphicon glyphicon-home"></span>
                Menú Principal
            </a>

        </div>

        <div class="col-md-6 text-right">

            <a href="listarVentas.jsp" class="btn btn-info">
                <span class="glyphicon glyphicon-list"></span>
                Ver Ventas
            </a>

        </div>

    </div>
</div>

<div class="panel-body">

<form method="post" action="guardarVenta.jsp" id="frmVenta">
<div class="row">

    <div class="col-md-4">

        <label><strong>Tipo de Documento</strong></label>

            <select id="tipo_documento"
            name="tipo_documento"
            class="form-control"
            required>

            <option value="" selected disabled>
                -- Seleccione --
            </option>

            <option value="FCF">
                Factura Consumidor Final
            </option>

            <option value="CCF">
                Comprobante de Crédito Fiscal
            </option>

        </select>
<div class="col-md-6">

    <label><strong>No. Documento</strong></label>

    <input type="text"
           id="numero_documento"
           class="form-control"
           readonly>

</div>
    </div>

</div>

<hr>
<div class="row">

    <div class="col-md-5">

        <label>Cliente</label>

              <select
                    class="form-control"
                    id="cliente"
                    name="cliente"
                    required>

            <option value="" selected disabled>
                 -- Seleccione un cliente --
             </option>

            <%
            st = conexion.prepareStatement(
            "SELECT id,nombres,apellidos FROM clientes WHERE estado='ACTIVO' ORDER BY nombres");
            rs = st.executeQuery();

            while(rs.next()){
            %>

            <option value="<%=rs.getInt("id")%>">
                <%=rs.getString("nombres")%> <%=rs.getString("apellidos")%>
            </option>

            <%
            }
            %>

        </select>
        <button
    type="button"
    class="btn btn-primary"
    data-toggle="modal"
    data-target="#modalCliente">

    <span class="glyphicon glyphicon-plus"></span>
    Nuevo Cliente
</button>
    </div>
        <div class="col-md-3">

         
           
        </div>
    <div class="col-md-4">

        <label>Fecha</label>

        <input type="date"
               name="fecha"
               class="form-control"
               accept=""required>

    </div>

    
    

</div>

<hr>
<div class="row">
    <div class="col-md-12">

        <table class="table table-bordered table-striped" id="tablaProductos">

            <thead class="bg-primary">

                <tr>

                    <th width="35%">Producto</th>
                    <th width="15%">Precio</th>
                    <th width="15%">Cantidad</th>
                    <th width="15%">Subtotal</th>
                    <th width="10%">Acción</th>

                </tr>

            </thead>

            <tbody id="detalleVenta">

                <tr>

                    <td>

                        <select class="form-control producto" name="producto[]">

                            <option value="">Seleccione...</option>

                            <%
                                PreparedStatement psProducto = conexion.prepareStatement(
                                    "SELECT id,nombre,precio,stock FROM productos WHERE estado='ACTIVO' ORDER BY nombre");
                                ResultSet rsProducto = psProducto.executeQuery();

                                while(rsProducto.next()){
                            %>

                            <option
                                value="<%=rsProducto.getInt("id")%>"
                                data-precio="<%=rsProducto.getDouble("precio")%>"
                                data-stock="<%=rsProducto.getInt("stock")%>">

                                <%=rsProducto.getString("nombre")%>

                            </option>

                            <%
                                }
                            %>

                        </select>

                    </td>

                    <td>

                        <input
                            type="number"
                            class="form-control precio"
                            name="precio[]"
                            readonly>

                    </td>

                    <td>

                        <input
                            type="number"
                            class="form-control cantidad"
                            name="cantidad[]"
                            value="1"
                            min="1">

                    </td>

                    <td>

                        <input
                            type="number"
                            class="form-control subtotal"
                            name="subtotal[]"
                            readonly>

                    </td>

                    <td align="center">

                        <button
                            type="button"
                            class="btn btn-danger eliminar">

                            X

                        </button>

                    </td>

                </tr>
             
            </tbody>

        </table>

        <button
            type="button"
            class="btn btn-success"
            id="agregar">

            + Agregar Producto

        </button>

    </div>
</div>

<hr>

<div class="row">

    <div class="col-md-8"></div>

    <div class="col-md-4">

        <table class="table">

            <tr>

                <th>Total</th>

                <td>

                    <input
                        type="text"
                        id="total"
                        name="total"
                        class="form-control total"
                        value="0.00"
                        readonly>

                </td>

            </tr>

        </table>

    </div>

</div> 
        <div class="row mt-3">
    <div class="col-md-4 offset-md-8">
        <label><strong>Método de Pago</strong></label>
        <select name="metodo_pago" class="form-control" required>
            <option value="" selected disabled>
            -- Seleccione un método de pago --
        </option>
        <option value="EFECTIVO">Efectivo</option>
        <option value="TARJETA">Tarjeta</option>
        <option value="TRANSFERENCIA">Transferencia</option>
        </select>
    </div>
</div>





<div class="text-right mt-3">
    <button type="submit" class="btn btn-success">
        💾 Guardar Venta
    </button>
</div>

</form>
<%@ include file="modalCliente.jsp" %>
</div>

</div>

</div>





                  
<script>
$(document).ready(function(){

function cargarCorrelativo(){

    var tipo = $("#tipo_documento").val();

    if(tipo=="")
        return;

    $.get("obtenerCorrelativo.jsp",
    {
        tipo:tipo
    },
    function(respuesta){

        $("#numero_documento").val(respuesta);

    });

}

$("#tipo_documento").change(function(){

    cargarCorrelativo();

});

function recalcularTotal(){

    var total = 0;

    $("#tablaProductos tbody tr").each(function(){

        var subtotal = parseFloat($(this).find(".subtotal").val());

        if(!isNaN(subtotal)){
            total += subtotal;
        }

    });

    $("#total").val(total.toFixed(2));

}


    //============ GUARDAR CLIENTE =================

    $("#btnGuardarCliente").click(function(){

        $.ajax({

            url:"guardarClienteAjax.jsp",
            type:"POST",
            data:$("#formCliente").serialize(),
            dataType:"json",

            success:function(respuesta){

                if(respuesta.success){

                    $("#cliente").append(
                        $("<option>",{
                            value:respuesta.id,
                            text:respuesta.nombre,
                            selected:true
                        })
                    );

                    $("#modalCliente").modal("hide");

                    $("#formCliente")[0].reset();

                    alert("Cliente registrado correctamente.");

                }else{

                    alert(respuesta.mensaje);

                }

            },

            error:function(){

                alert("Error al guardar cliente");

            }

        });

    });

    

       
//-----------------------------------------------------

$(document).on("change",".producto",function(){

    var opcion = $(this).find(":selected");

    var precio = parseFloat(opcion.data("precio"));

    if(isNaN(precio))
        precio = 0;

    var fila = $(this).closest("tr");

    fila.find(".precio").val(precio.toFixed(2));

    var cantidad = parseFloat(fila.find(".cantidad").val());

    if(isNaN(cantidad))
        cantidad = 1;

    fila.find(".subtotal").val((precio*cantidad).toFixed(2));

    recalcularTotal();

});

//-----------------------------------------------------

$(document).on("keyup change",".cantidad",function(){

    var fila = $(this).closest("tr");

    var precio = parseFloat(fila.find(".precio").val());

    var cantidad = parseFloat($(this).val());

    if(isNaN(precio))
        precio = 0;

    if(isNaN(cantidad))
        cantidad = 1;

    fila.find(".subtotal").val((precio*cantidad).toFixed(2));

    recalcularTotal();

});

//-----------------------------------------------------

$("#agregar").click(function(){

    var fila = $("#detalleVenta tr:first").clone();

    fila.find("select").val("");

    fila.find(".precio").val("");

    fila.find(".cantidad").val(1);

    fila.find(".subtotal").val("");

    $("#detalleVenta").append(fila);

});

//-----------------------------------------------------

$(document).on("click",".eliminar",function(){

    if($("#detalleVenta tr").length>1){

        $(this).closest("tr").remove();

        recalcularTotal();

    }else{

        alert("Debe existir al menos un producto.");

    }

});


    
});      
</script>

</body>
</html>