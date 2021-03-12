using { cuid } from '@sap/cds/common';
namespace misAutos;

entity Marca : cuid {
    nombre: String(30);
    paisOrigen: String(30);
    comentario: String(50);
    modelos: Composition of many Modelo on modelos.marca = $self;
}

entity Modelo: cuid {
    key marca: Association to Marca;
    nombre: String(30);
    tipo: String(30);
}