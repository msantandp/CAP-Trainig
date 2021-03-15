using { cuid, Currency } from '@sap/cds/common';
namespace manageStore;

entity Store : cuid {
    name: String(20);
    owner: Association to many Owner_Store on owner.store = $self;
    product: Association to many Store_Product on product.store = $self;
}

entity Product : cuid {
    name: String(20);
    store: Association to many Store_Product on store.product = $self;
    price: Association to Price;
}

entity Owner : cuid {
    name: String(20);
    store: Association to many Owner_Store on store.owner = $self;
}

entity Price : cuid {
    value: Decimal(10, 2);
    product: Association to many Product on product.price = $self;
}

entity Owner_Store {
    key owner: Association to Owner;
    key store: Association to Store;
}

entity Store_Product {
    key store: Association to Store;
    key product: Association to Product;
}

