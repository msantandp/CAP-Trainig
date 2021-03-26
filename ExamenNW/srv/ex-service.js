const cds = require('@sap/cds');
const axios = require('axios');
const https = require('https');
const { Product, Order, Order_Detail } = cds.entities;
const agent = new https.Agent({
    rejectUnauthorized: false,
});


module.exports = cds.service.impl(async (srv) => {

    srv.before('READ', 'Order_Detail', async req => {
        //OrderDetail INSERTS
        await axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Order_Details?$filter=ProductID lt 20 and OrderID lt 10447', {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json;IEEE754Compatible=true'
            },
            httpsAgent: agent,
            rejectUnauthorized: false
        }).then(async function (response) {
            console.log("---- Get OrderDetail ----");
            const orderDetail = response.data.value;
            let orderDetailEntries = [];
            orderDetail.forEach(reg => {
                orderDetailEntries.push({
                    order_ID: reg.OrderID,
                    product_ID: reg.ProductID,
                    UnitPrice: reg.UnitPrice,
                    Quantity: reg.Quantity,
                    Discount: reg.Discount
                })
            });

            console.log(orderDetailEntries);
            await cds.run(INSERT.into(Order_Detail).entries(orderDetailEntries));
            
        }).catch(function (error) {
            console.log("Error: ");
            console.log(error);
        }).then(function () {
            //always executed
        });
    })

    srv.on('validarOrders', async req => {
        const orders = await cds.run(SELECT.from(Order));
        let deleteOrders = [];
        for (let order of orders) {
            let flag = false;
            let details = await cds.run(SELECT.from(Order_Detail).where({ order_ID: order.ID }))
            for (let detail of details) {
                let aStock = await cds.run(SELECT.from(Product).where({ ID: detail.product_ID}))
                let stock = aStock[0].UnitsInStock - aStock[0].UnitsOnOrder
                console.log(detail);
                if (stock<detail.Quantity) {
                    console.log("Stock muy bajo, orden no valida");
                    //Eliminar Order_Details de Order no validas
                    await cds.run(DELETE.from(Order_Detail).where({ order_ID: detail.order_ID }));
                    flag = true;
                }
            }
            //Eliminar Ordenes no validas
            if (flag) {
                console.log(await cds.run(DELETE.from(Order).where({ ID: order.ID })));
                
            }
        }
        return "Ordenes validadas correctamente"
    })
})


//Product INSERTS
axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Products', {
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json;IEEE754Compatible=true'
    },
    httpsAgent: agent,
    rejectUnauthorized: false
}).then(async function (response) {
    console.log("---- Get Products ----");
    const products = response.data.value;
    let productEntries = [];
    products.forEach(product => {
        productEntries.push({
            ID: product.ProductID,
            ProductName: product.ProductName,
            QuantityPerUnit: product.QuantityPerUnit,
            UnitPrice: product.UnitPrice,
            UnitsInStock: (product.UnitsOnOrder>=product.UnitsInStock)? 10 : product.UnitsInStock,
            UnitsOnOrder: (product.UnitsOnOrder>=product.UnitsInStock)? 0 : product.UnitsOnOrder,
            ReorderLevel: product.ReorderLevel,
            Discontinued: product.Discontinued
        })
    });
    await cds.run(INSERT.into(Product).entries(productEntries));
    console.log("Data Product insertada");
}).catch(function (error) {
    console.log("Error: ");
    console.log(error);
}).then(function () {
    //always executed
});


// //Order INSERTS
axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Orders?$orderby=OrderID', {
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json;IEEE754Compatible=true'
    },
    httpsAgent: agent,
    rejectUnauthorized: false
}).then(async function (response) {
    console.log("---- Get Orders ----");
    const orders = response.data.value;
    let orderEntries = [];

    orders.forEach(order => {
        orderEntries.push({
            ID: order.OrderID,
            OrderInfo: (order.ShipRegion) ? order.ShipRegion + '|' + order.OrderDate : 'NN' + '/' + order.OrderDate,
            RequiredDate: order.RequiredDate,
            ShippedDate: order.ShippedDate,
            ShipVia: order.ShipVia,
            Freight: order.Freight,
            ShipName: order.ShipName,
            ShipPostalCode: order.ShipPostalCode,
            OrderDate: order.OrderDate,
            ShipCountry: order.ShipCountry,
            ShipCity: order.ShipCity,
            ShipRegion: (order.ShipRegion) ? order.ShipRegion : 'NN',
            ShipAddress: order.ShipAddress
        })
    });
    await cds.run(INSERT.into(Order).entries(orderEntries))

    console.log("Data Orders Insertada");
}).catch(function (error) {
    console.log("Error: ");
    console.log(error);
}).then(function () {
    //always executed
});


