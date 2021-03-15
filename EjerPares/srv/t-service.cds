using { manageTrains as my } from '../db/schema';

service api {
    entity train as select from my.Train;
    entity driver as select from my.Driver;
    entity trip as select from my.Trip;

    entity trainDriver as select from my.Train_Driver;

    // entity Trenes as select from my.Train{
    //     ID,
    //     passenger,
    //     color,
    //     productionYear,
    //     driver.driver.name as NombreConductor,
    //     driver.driver.age as Edad,
    //     driver.driver.career as Antiguedad,
    //     driver.driver.address.street as calle,
    //     driver.driver.address.number as numero,
    //     driver.driver.address.town as ciudad,
    //     driver.driver.address.country as Pais
    // };

    // entity Conductores as select from my.Driver{
    //     *,
    //     train.train.ID as tren_ID,
    //     train.train.trip.origin,
    //     train.train.trip.destination
    // };

}