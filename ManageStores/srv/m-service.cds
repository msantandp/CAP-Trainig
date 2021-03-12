using { manageStore as my } from '../db/schema';

service api {
    entity Store as select from my.Store{*};

    @readonly entity Test as select from my.Store {
        *,
        name as nombreTienda,
        product.product.name as nombreProduct,
        product.product.price.value as precioProducto,
        owner.owner.name as duenio
    };

    entity Product as select from my.Product {*};

    entity Owner as select from my.Owner {*};

    entity Price as select from my.Price {*};

    entity Store_Product as select from my.Store_Product ;
    entity Owner_Store as select from my.Owner_Store ;


    
}