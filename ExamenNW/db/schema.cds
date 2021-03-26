using { cuid } from '@sap/cds/common';
namespace examenNW;

entity Product {
    key ID: Integer;
    ProductName: String;
    QuantityPerUnit: String;
    UnitPrice: Decimal(12, 5);
    UnitsInStock: Integer;
    UnitsOnOrder: Integer;
    ReorderLevel: Integer;
    Discontinued: Boolean;
    order: Association to many Order_Detail on order.product = $self;
}

entity Order {
    key ID: Integer;
    OrderInfo: String;
    RequiredDate: DateTime;
    ShippedDate: DateTime;
    ShipVia: Integer;
    Freight: Decimal(12, 5);
    ShipName: String;
    ShipPostalCode: String;
    OrderDate: DateTime;
    ShipCountry: String;
    ShipCity: String;
    ShipRegion: String;
    ShipAddress: String;
    product: Association to many Order_Detail on product.order = $self;
}


entity Order_Detail: cuid {
    key order: Association to Order;
    key product: Association to Product;
    UnitPrice: Decimal(12, 5);
    Quantity: Integer;
    Discount: Decimal(12, 5);
}

