const cds = require('@sap/cds');
const { Marca} = cds.entities;

module.exports = cds.service.impl(async (srv) => {

    srv.on('insertMarca', async req => {
        try {
            console.log("Entando a insertar Marca");
            const {marca} = req.data;

            if(await cds.run(INSERT.into(Marca).entries(marca))){
                return "Todo ha salido bien"; 
            }
        } catch (error) {
            return "Hubo un error a la hora de la insercion";
        }
    })
})