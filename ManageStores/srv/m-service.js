const cds = require("@sap/cds");
const { Product, Owner_Store } = cds.entities;

module.exports = cds.service.impl(async (srv) => {
    srv.on('alterStock', async req => {
        try {
            console.log("Entrando a alterStock");

            const { product, amount } = req.data
            //verify product
            const vProduct = await cds.run(SELECT.from(Product).where({ ID: product }))

            if(vProduct) {
                console.log("Product existe!");
                await cds.run(UPDATE(Product).set({ stock: { '+=': amount } }).where({ ID: product }))
                console.log("Stock actualizado");

                console.log("Verificar max min");
                const stock = await cds.run(SELECT.from(Product).where({ ID: product }))

                if(stock[0].stock < 30) {
                    console.log("Stock demasiado bajo");
                } else if (stock[0].stock > 300) {
                    console.log("Stock demasiado alto");
                } else {
                    console.log("Todo ok!");
                }
                return "Stock actualizado";
            }
 
        } catch (error) {
            console.log(error);
        }
    })


    //arreglar solo un INSERT
    srv.after('CREATE', 'Owner', async (data, req) => {
        try {
            console.log("stores: ");
            const { stores } = req._.req.query

            if (stores) {
                let arrayStores = []
                arrayStores = stores.split(',')
                for(let i in arrayStores){
                    await INSERT.into(Owner_Store).columns(['owner_ID','store_ID']).values([req.data.ID,arrayStores[i]])
                }
            }
        } catch (error) {
            console.log(error);
        }
    })

    srv.on('updatePrice', async req => {
        try {
            console.log("Entrando a updatePrice");
            console.log(req.data);
            const { products } = req.data;
            for(let i in products){
                await cds.run(UPDATE(Product).set({ price_ID: products[i].price_ID }).where({ ID: products[i].ID}))
            }
            
        } catch (error) {
            console.log(error);
        }
    })


})