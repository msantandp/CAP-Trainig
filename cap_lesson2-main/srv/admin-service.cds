using { sap.example2 as tablas} from '../db/schema';
service AdminService @(_requires:'authenticated-user') {
  entity Juegos as projection on tablas.Juegos;
  entity Productora as projection on tablas.Productora;
}