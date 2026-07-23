<%-- 
    Document   : modalCliente
    Created on : 18 jul. 2026, 13:28:28
    Author     : Marvin
--%>
<!-- Modal Nuevo Cliente -->
<div class="modal fade" id="modalCliente" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">
                    <i class="fa fa-user-plus"></i> Nuevo Cliente
                </h5>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <form id="formCliente">

                    <div class="row">

                        <div class="col-md-6 mb-3">
                            <label>Nombres *</label>
                            <input
                                type="text"
                                class="form-control"
                                name="nombres"
                                required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label>Apellidos</label>
                            <input
                                type="text"
                                class="form-control"
                                name="apellidos">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label>Teléfono</label>
                            <input
                                type="text"
                                class="form-control"
                                name="telefono">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label>Tipo de Cliente</label>

                            <select
                                class="form-select"
                                id="tipo_cliente"
                                name="tipo_cliente">

                                <option value="CONSUMIDOR">
                                    Consumidor Final
                                </option>

                                <option value="CONTRIBUYENTE">
                                    Contribuyente
                                </option>

                            </select>

                        </div>

                    </div>

                    <!-- CAMPOS CONSUMIDOR -->

                    <div id="divDui">

                        <div class="mb-3">

                            <label>DUI</label>

                            <input
                                type="text"
                                class="form-control"
                                name="dui"
                                placeholder="00000000-0">

                        </div>

                    </div>

                    <!-- CAMPOS CONTRIBUYENTE -->

                    <div id="datosContribuyente" style="display:none;">

                        <div class="row">

                            <div class="col-md-4 mb-3">

                                <label>NIT</label>

                                <input
                                    type="text"
                                    class="form-control"
                                    name="nit">

                            </div>

                            <div class="col-md-4 mb-3">

                                <label>NRC</label>

                                <input
                                    type="text"
                                    class="form-control"
                                    name="nrc">

                            </div>

                            <div class="col-md-4 mb-3">

                                <label>Giro</label>

                                <input
                                    type="text"
                                    class="form-control"
                                    name="giro">

                            </div>

                        </div>

                    </div>

                </form>

            </div>

            <div class="modal-footer">

                <button
                    type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal">

                    Cancelar

                </button>

                <button
                    type="button"
                    id="btnGuardarCliente"
                    class="btn btn-success">

                    <i class="fa fa-save"></i> Guardar Cliente

                </button>

            </div>

        </div>
    </div>
</div>

<script>

document.getElementById("tipo_cliente").addEventListener("change", function(){

    if(this.value==="CONTRIBUYENTE"){

        document.getElementById("datosContribuyente").style.display="block";
        document.getElementById("divDui").style.display="none";

    }else{

        document.getElementById("datosContribuyente").style.display="none";
        document.getElementById("divDui").style.display="block";

    }

});

</script>