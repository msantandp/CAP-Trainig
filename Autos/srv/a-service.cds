using { misAutos as my} from '../db/schema';

service api {

    entity Modelos as select from my.Modelo;
    entity Marcas as select from my.Marca;

    action insertMarca (marca: array of  my.Marca) returns String;
}
