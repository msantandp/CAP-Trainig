using {managed, cuid } from '@sap/cds/common';
namespace sap.example2;

entity Juegos : managed, cuid {
  nombre  : String(111);
  descr  : String(1111);
  productora: Association to Productora;
}

entity Productora : managed, cuid {
  nombre  : String(111);
  descr  : String(1111);
  juegos : Association to many Juegos on juegos.productora = $self;
}

