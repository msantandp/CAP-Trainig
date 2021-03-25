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
                const query = await cds.run(SELECT.from(Product).where({ ID: product }))
                const { min, max, stock } = query[0]

                if(stock < min) {
                    console.log("Stock demasiado bajo");
                } else if (stock > max) {
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

    srv.after('CREATE', 'Owner', async (data, req) => {
        try {
            const { ID } = data
            console.log("Agregando tiendas a Owners");
            const { stores } = req._.req.query
            if (stores) {
                console.log("Entrando al if");

                arrayStores = stores.split(',')

                arrayData = []
                
                for(let i in arrayStores){
                    arrayData.push({
                        owner_ID: ID,
                        store_ID: arrayStores[i]
                    }) 
                };

                
                await INSERT.into(Owner_Store).entries(arrayData)
                
            }
        } catch (error) {
            console.log(error);
        }
    })


    srv.on('updatePrice', async req => {
        try {
            console.log("Entrando a updatePrice");
            const { products } = req.data;
            if (products) {
                for(let i in products){
                    await cds.run(UPDATE(Product).set({ price_ID: products[i].price_ID }).where({ ID: products[i].ID}))
                }
                console.log("Precios updateados!");
                return "Precios updateados!"
            } else {
                console.log("JSON vacio");
                return "JSON vacio"
            }
            
            
        } catch (error) {
            console.log(error);
            return error
        }
    })


})