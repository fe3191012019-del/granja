/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package modelo;

import java.sql.Timestamp;

public class Venta {

    private int id;
    private int idCliente;
    private int idUsuario;
    private Timestamp fecha;
    private double subtotal;
    private double iva;
    private double total;

    public Venta() {
    }

    public Venta(int id, int idCliente, int idUsuario, Timestamp fecha,
            double subtotal, double iva, double total) {

        this.id = id;
        this.idCliente = idCliente;
        this.idUsuario = idUsuario;
        this.fecha = fecha;
        this.subtotal = subtotal;
        this.iva = iva;
        this.total = total;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getIva() {
        return iva;
    }

    public void setIva(double iva) {
        this.iva = iva;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

}