using { cuid, Country } from '@sap/cds/common';
namespace manageTrains;

entity Trip: cuid{
    price: Decimal(10,2);
    origin: String(30);
    destination: String(30);
    train: Association to Train;
}

entity Driver: cuid{
    name: String(30);
    age: Integer;
    career: Integer;
    // address: Composition of one Address;
    train: Association to many  Train_Driver on train.driver = $self;
}

aspect Address: cuid{
    street: String(30);
    number: Integer;
    town: String(30);
    country: String(30);
}

entity Train : cuid {
    passenger: Integer;
    //Falta cambiar esto
    color: Integer enum {
        rojo = 1;
        blanco = 2;
        negro=  3;
    };
    productionYear: Integer;
    trip: Association to Trip;
    driver: Association to many Train_Driver on driver.train = $self;
}

entity Train_Driver {
    key train: Association to Train;
    key driver: Association to Driver
}