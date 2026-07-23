<%-- 
    Document   : guardarVenta
    Created on : 17 jul. 2026, 02:08:14
    Author     : Marvin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%@include file="../conexion.jsp"%>

<%
if(session.getAttribute("login")==null){
    response.sendRedirect("../index.jsp");
    return;
}

Connection cn = conexion;


PreparedStatement psVenta = null;
PreparedStatement psDetalle = null;
PreparedStatement psProducto = null;

ResultSet rsVenta = null;
ResultSet rsProducto = null;

try{

    cn.setAutoCommit(false);

    int idCliente = Integer.parseInt(request.getParameter("cliente"));
    int idUsuario = Integer.parseInt(session.getAttribute("id_usuario").toString());
    String tipoDocumento = request.getParameter("tipo_documento");
   
//===========================================
// GENERAR CORRELATIVO DESDE LA TABLA correlativos
//===========================================

String prefijo = tipoDocumento.toUpperCase();
String numeroDocumento = "";

PreparedStatement psCorrelativo = cn.prepareStatement(
    "SELECT ultimo_numero FROM correlativos WHERE tipo_documento=? FOR UPDATE");

psCorrelativo.setString(1, tipoDocumento);

ResultSet rsCorrelativo = psCorrelativo.executeQuery();

if(!rsCorrelativo.next()){
    throw new Exception("No existe configuración para el tipo de documento: " + tipoDocumento);
}

int ultimoNumero = rsCorrelativo.getInt("ultimo_numero");
int nuevoNumero = ultimoNumero + 1;

numeroDocumento = prefijo + "-" + String.format("%06d", nuevoNumero);

rsCorrelativo.close();
psCorrelativo.close();

PreparedStatement psActualizar = cn.prepareStatement(
    "UPDATE correlativos SET ultimo_numero=? WHERE tipo_documento=?");

psActualizar.setInt(1, nuevoNumero);
psActualizar.setString(2, tipoDocumento);

psActualizar.executeUpdate();
psActualizar.close();
   
    String[] productos = request.getParameterValues("producto[]");
    String[] cantidades = request.getParameterValues("cantidad[]");
    String[] precios = request.getParameterValues("precio[]");

    double subtotalGeneral = 0;

    if(productos==null || productos.length==0){
        throw new Exception("No existen productos en la venta.");
    }

    for(int i=0;i<productos.length;i++){

        if(productos[i]==null || productos[i].trim().equals(""))
            continue;

        double precio = Double.parseDouble(precios[i]);
        int cantidad = Integer.parseInt(cantidades[i]);

        subtotalGeneral += precio * cantidad;
    }

    // El precio de los productos ya incluye IVA
    double total = subtotalGeneral;

    // Calcular la base imponible
    double subtotal = total / 1.13;

    // Calcular el IVA incluido
    double iva = total - subtotal;
    
        

     String sqlVenta =
    "INSERT INTO ventas " +
    "(id_cliente,id_usuario,tipo_documento,numero_documento,fecha,subtotal,iva,total) " +
    "VALUES(?,?,?,?,?,?,?,?)";
    psVenta = cn.prepareStatement(sqlVenta,Statement.RETURN_GENERATED_KEYS);

    psVenta.setInt(1,idCliente);
psVenta.setInt(2,idUsuario);
psVenta.setString(3,tipoDocumento);
psVenta.setString(4,numeroDocumento);
psVenta.setTimestamp(5,new Timestamp(System.currentTimeMillis()));
psVenta.setDouble(6,subtotal);
psVenta.setDouble(7,iva);
psVenta.setDouble(8,total);

    psVenta.executeUpdate();

    rsVenta = psVenta.getGeneratedKeys();

    int idVenta = 0;

    if(rsVenta.next()){
        idVenta = rsVenta.getInt(1);
    }else{
        throw new Exception("No fue posible obtener el ID de la venta.");
    }

    String sqlProducto =
        "SELECT precio,stock FROM productos WHERE id=?";

    String sqlDetalle =
        "INSERT INTO detalle_venta " +
        "(id_venta,id_producto,cantidad,precio,subtotal) " +
        "VALUES(?,?,?,?,?)";

    String sqlStock =
        "UPDATE productos SET stock=stock-? WHERE id=?";
            for(int i=0;i<productos.length;i++){

        if(productos[i]==null || productos[i].trim().equals(""))
            continue;

        int idProducto = Integer.parseInt(productos[i]);
        int cantidad = Integer.parseInt(cantidades[i]);
        double precio = Double.parseDouble(precios[i]);
        double subtotalDetalle = precio * cantidad;

        psProducto = cn.prepareStatement(sqlProducto);
        psProducto.setInt(1,idProducto);

        rsProducto = psProducto.executeQuery();

        if(!rsProducto.next()){
            throw new Exception("Producto no encontrado.");
        }

        int stockActual = rsProducto.getInt("stock");

        if(cantidad > stockActual){
            throw new Exception("Stock insuficiente.");
        }

        psDetalle = cn.prepareStatement(sqlDetalle);

        psDetalle.setInt(1,idVenta);
        psDetalle.setInt(2,idProducto);
        psDetalle.setInt(3,cantidad);
        psDetalle.setDouble(4,precio);
        psDetalle.setDouble(5,subtotalDetalle);

        psDetalle.executeUpdate();

        PreparedStatement psStock = cn.prepareStatement(sqlStock);

        psStock.setInt(1,cantidad);
        psStock.setInt(2,idProducto);

        psStock.executeUpdate();

        psStock.close();

        rsProducto.close();
        psProducto.close();
        psDetalle.close();

    }
      // Confirmar la transacción
    cn.commit();

    response.sendRedirect("listarVentas.jsp?ok=1");
    return;

}catch(Exception e){

    try{
        if(cn!=null){
            cn.rollback();
        }
    }catch(Exception ex){}

    out.println("<div class='alert alert-danger'>");
    out.println("<h3>Error al guardar la venta</h3>");
    out.println("<b>"+e.getMessage()+"</b>");
    out.println("</div>");

}finally{

    try{
        if(rsVenta!=null) rsVenta.close();
    }catch(Exception e){}

    try{
        if(rsProducto!=null) rsProducto.close();
    }catch(Exception e){}

    try{
        if(psVenta!=null) psVenta.close();
    }catch(Exception e){}

    try{
        if(psDetalle!=null) psDetalle.close();
    }catch(Exception e){}

    try{
        if(psProducto!=null) psProducto.close();
    }catch(Exception e){}

    try{
        if(cn!=null){
            cn.setAutoCommit(true);
            cn.close();
        }
    }catch(Exception e){}
}
%>