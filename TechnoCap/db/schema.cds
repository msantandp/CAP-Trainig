using { cuid } from '@sap/cds/common';
namespace technoCap;

entity Client : cuid {
    name: String(30);
    lastName: String(30);
    email: String(40);
    gender: String(10);
    proyect: Association to Proyect;
}

entity Proyect : cuid {
    name: String(30);
    workers: Integer;
    salary: Integer;
    //------------------
    estimationCost: Integer;
    estimationTime: Integer;
    client: Association to Client;
    technology: Association to many Proyect_Technology on technology.proyect = $self;
}

entity Proyect_Technology: cuid {
    key proyect: Association to Proyect;
    key technology: Association to Technology;
    difficulty: Integer;
}

entity Technology : cuid {
    name: String;
    baseTime: Integer; //dia
    baseCost: Integer;
    proyect: Association to many Proyect_Technology on proyect.technology = $self;
}



