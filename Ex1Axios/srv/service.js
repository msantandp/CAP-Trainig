const cds = require('@sap/cds');
const axios = require('axios');
const https = require('https');
const schedule = require('node-schedule');
const { Technology } = cds.entities;
const agent = new https.Agent({
    rejectUnauthorized: false,
});


const job = schedule.scheduleJob('1 * * * * *', function () {
    console.log("Entrando a schedule");

    axios.get('https://discovery-center.cloud.sap/platformx/Services', {
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        httpsAgent: agent,
        rejectUnauthorized: false
    }).then(async function (response) {
        // console.log("response.data: ");
        // console.log(response.data.d.results);
        console.log("--------");
        
        
        const data = response.data.d.results;
        let entries = []
        for (let i in data) {
            // await cds.run(INSERT.into(Technology).columns(['ShortDesc','ShortName']).values([data[i].ShortDesc,data[i].ShortName]));
            entries.push({
                ShortDesc: data[i].ShortDesc,
                ShortName: data[i].ShortName
            })
        }
        await cds.run(DELETE.from(Technology));
        await cds.run(INSERT.into(Technology).entries(entries))
        console.log("Data insertada!");
        
        
        

    }).catch(function (error) {
        console.log("Error: ");
        console.log(error);
        console.log("Error: ");
    }).then(function () {
        //always executed
    })
})