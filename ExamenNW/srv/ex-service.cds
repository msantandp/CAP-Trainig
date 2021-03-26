using { examenNW as my } from '../db/schema';

service api {
    entity Products as projection on my.Product;
    entity Orders as projection on my.Order;
    entity Order_Detail as projection on my.Order_Detail;


    action validarOrders() returns String;
}