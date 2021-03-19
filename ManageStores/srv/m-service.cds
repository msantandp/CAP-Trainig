using { manageStore as my } from '../db/schema';

service api {
    entity Store as projection on my.Store;

    entity Product as projection on my.Product;

    entity Owner as projection on my.Owner;

    entity Price as projection on my.Price;

    entity Brand as projection on my.Brand;

    entity eType as projection on my.eType;

    entity SubType as projection on my.SubType;

    entity Store_Product as projection on my.Store_Product ;
    entity Owner_Store as projection on my.Owner_Store ;

    @readonly entity view1 as select from Store {
        name as nombreTienda,
        product.product.name as nombreProduct,
        product.product.price.value as precioProducto,
        owner.owner.name as duenio
    };

    entity view2 as projection on Product {
        ID,
        name,
        subtype.type.name as tipo,
        subtype.name as subTipe,
        brand.name as marca,
        price.value
    } where brand.name = 'Marca 1';

    entity view3 as select from Product{
        ID,
        name,
        price.value
        } where price.value > 70 and price.value < 200;


    action alterStock(product: Product: ID, amount: Integer) returns String;

    action updatePrice(products: array of Product) returns String
}