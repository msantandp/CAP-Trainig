const cds = require ('@sap/cds')
const {Juegos, Productora} = cds.entities;


module.exports = async (srv) =>{
    
    srv.on('editJuego',async (req,res)=>{        
        const result = await UPDATE(Juegos).set({'descr':req.data.descr}).where({'ID':req.data.juegoID})
        console.log(result);
        return 'Update success';
    })
    srv.on('insertJuego',async (req,res)=>{   
        console.log(req.data.juegos);  
        const data=[];
        for(let i in req.data.juegos){
            data.push([req.data.juegos[i].nombre,req.data.juegos[i].descr])
            console.log(req.data.juegos[i].nombre,req.data.juegos[i].descr);
        }
        const result = await 
            INSERT.into(Juegos).columns(['nombre', 'descr'])
            .rows (data)    
        return 'Insert success';
    })
}