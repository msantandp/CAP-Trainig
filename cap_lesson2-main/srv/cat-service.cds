using { sap.example2 as tablas } from '../db/schema';
service CatalogService @(path:'/myService') {

  entity Juegos as SELECT from tablas.Juegos {*,
    productora.nombre as Desarrolladora
  } excluding { createdBy, modifiedBy };

  entity Productora as SELECT from tablas.Productora {*
  } excluding { createdBy, modifiedBy };

  action editJuego ( juegoID:UUID, descr:String ) returns String;
  action insertJuego ( juegos: array of tablas.Juegos ) returns String;

}