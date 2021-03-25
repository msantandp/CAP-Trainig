const cds = require("@sap/cds");
const { Proyect, Proyect_Technology, Technology } = cds.entities;

module.exports = cds.service.impl(async (srv) => {
    srv.on('calculate', async req => {
        try {
            console.log("Entrando a calculate");
            proyects = await cds.run(SELECT.from(Proyect));            
            for (let proyect of proyects) {
                //Time
                let technologies = await cds.run(SELECT.from(Proyect_Technology).where({ proyect_ID: proyect.ID }));
                let workers = proyect.workers;
                let salary = proyect.salary;
                let estimateTime = 0;
                //Cost
                let proyectsCost = 0;
                for (let technology of technologies) {
                    //Time
                    let difficulty = technology.difficulty;
                    let techno = await cds.run(SELECT.from(Technology).where({ ID: technology.technology_ID }));
                    let baseTime = techno[0].baseTime;
                    estimateTime += difficulty*baseTime;
                    //Cost
                    proyectsCost += techno[0].baseCost;
                }
                estimateTime /= workers;
                let estimateCost = (workers * salary * estimateTime) + proyectsCost;
                await cds.run(UPDATE(Proyect).set({ estimationTime: Math.round(estimateTime), estimationCost: estimateCost }).where({ ID: proyect.ID }))
            }
        } catch (error) {
            console.log("Error: ");
            console.log(error);
        }
    })
})