using { cuid } from '@sap/cds/common';
namespace pcFactory;

entity Producto : cuid {
    nombre: String(50);
    tamanio: String(30);
    peso: String(10);
    valor: String(30);
    proveedor: Association to Proveedor;
}

entity Proveedor : cuid {
    nombre: String(50);
    producto: Association to many Producto on producto.proveedor = $self;
}