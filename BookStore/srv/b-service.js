const cds = require("@sap/cds");
const { Book, Log } = cds.entities;

module.exports = cds.service. impl( async (srv) => {

    srv.after('CREATE', 'Book', async (data, req) => {
        postLog(data, req)
        
        // console.log("req.data")
        // console.log(req.data)
        // console.log("req.body")
        // console.log(req.body);
        // console.log("req._.req.query")
        // console.log(req._.req.query)
        // console.log("req.query")
        // console.log(req.query)
    })

    srv.after ('UPDATE','Book', async (data, req) => {
        postLog(data, req)

        // console.log("before UPDATE Book");
        // console.log(req.data);
        // console.log("req.query")
        // console.log(req.query)

    })



    srv.after('DELETE', 'Book', async (data, req) => {
        // console.log(data);
        postLog(req.data, req)

        // console.log("req.body")
        // console.log(req.body);
        // console.log("req._.req.query")
        // console.log(req._.req.query)
        // console.log("req.query")
        // console.log(req.query)
        // console.log("req._.req.query")
        // console.log(req._.req.query)
    })

    //POSTING LOG
    async function postLog(data, req) {
        const ID = data.ID
        const message = req.method + " on " + req.entity
        await INSERT.into(Log).columns(['crudFun','idTarget','entity','msg'])
        .values([req.method,ID,req.entity,message])
    }



    srv.on('manyBooks', async req => {
        try {
            console.log("Entrando a manyBooks");
            const { books }= req.data
            console.log(books);

            if (await cds.run(INSERT.into(Book).entries(books))) {
                return "Libros insertados"
            }
        } catch (error) {
            console.log("ERORRRRR");
            console.log(error);
        }
    })



})