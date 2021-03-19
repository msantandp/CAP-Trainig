const cds = require("@sap/cds");
const { Stock } = cds.entities;

module.exports = cds.service.impl(async (srv) => {

    srv.on('modInv', async req => {
        try {
            console.log("Entrando en modificar el Inventory")
            const {book, amount } = req.data
            const aBooks = await cds.run(SELECT.from(Stock).where({ book_ID: book}))

            if (!aBooks) {
                console.log("Antes del Update")
                await cds.run(update(Stock).with({ amountBooks: { '+=': amount} }).where({ book_ID: book}));
                console.log("Se ha actualizado correctamente");
                return "Todo ha salido bien"
            } else {
                console.log("No esta registrado en el Almacen");
                return "No se ha actualizado, ya que no hay con que."
            }
        } catch (error) {
            console.log(error);
            console.log("Hubo un error a la hora de actualizar");
        }
    });

    srv.on('insertOrder', async req => {
        try {
            console.log("Entrando en insertar en el Inventory");
            const { book } = req.data;

            if (await cds.run(INSERT.into(Stock).entries(req.data.book))) {
                return "Todo ha salido bien"
            }
        } catch (error) {
            return "Hubo un error a la hora del insert"
        }
    })
})