<%-- 
    Document   : guardarClienteAjax
    Created on : 18 jul. 2026, 13:45:31
    Author     : Marvin
--%>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
response.setContentType("application/json");

Connection conexion = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

    Class.forName("com.mysql.jdbc.Driver");

    conexion = DriverManager.getConnection(
            "jdbc:mysql://localhost/incubacion",
            "root",
            "");

    String nombres = request.getParameter("nombres");
    String apellidos = request.getParameter("apellidos");
    String telefono = request.getParameter("telefono");
    String dui = request.getParameter("dui");
    String tipo = request.getParameter("tipo_cliente");
    String nit = request.getParameter("nit");
    String nrc = request.getParameter("nrc");
    String giro = request.getParameter("giro");

    if(nombres==null || nombres.trim().equals("")){

        out.print("{\"success\":false,\"mensaje\":\"Debe ingresar el nombre.\"}");
        return;

    }

    String sql = "INSERT INTO clientes "
            + "(nombres,apellidos,telefono,dui,tipo_cliente,nit,nrc,giro)"
            + " VALUES(?,?,?,?,?,?,?,?)";

    ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

    ps.setString(1, nombres);
    ps.setString(2, apellidos);
    ps.setString(3, telefono);
    ps.setString(4, dui);
    ps.setString(5, tipo);
    ps.setString(6, nit);
    ps.setString(7, nrc);
    ps.setString(8, giro);

    int guardar = ps.executeUpdate();

    if(guardar>0){

        rs = ps.getGeneratedKeys();

        int id=0;

        if(rs.next()){

            id = rs.getInt(1);

        }

        String nombreCompleto = nombres;

        if(apellidos!=null && !apellidos.trim().equals("")){

            nombreCompleto += " " + apellidos;

        }

        out.print("{");
        out.print("\"success\":true,");
        out.print("\"id\":"+id+",");
        out.print("\"nombre\":\""+nombreCompleto+"\"");
        out.print("}");

    }else{

        out.print("{\"success\":false,\"mensaje\":\"No fue posible guardar el cliente.\"}");

    }

}catch(Exception e){

    out.print("{\"success\":false,\"mensaje\":\""+e.getMessage().replace("\"","")+"\"}");

}finally{

    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(conexion!=null) conexion.close();

}
%>
