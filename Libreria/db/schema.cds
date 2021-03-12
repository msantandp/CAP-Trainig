using { cuid, managed } from '@sap/cds/common';
namespace myBookShop;

// entity Libros: cuid {
//     name  : String(30);
//     author : Association to Autores;
// }

entity Books {
    key ID: Integer;
    name: String(30);
    author: Association to Authors;
    comments: String(300);
    // autor: Association to many Libros_Autor on autor.libro = $self;
}
entity Authors {
    key ID: Integer;
    name: String(30);
    countryBirth: String(30);
    book: Association to Books;
    // libro:  Association to many Libros_Autor on libro.autor = $self;
    // hijos: Composition of many Hijos on hijos.padre = $self;
}

entity Stock : cuid, managed{
    book: Association to Books;
    amountBooks: Integer;
    price: Decimal(3,2);
    comments: String(300);
}

entity Libros_Autor  {
    key libro: Association to Books;
    key autor: Association to Authors;
}

entity Hijos : cuid {
    name: String(30);
    key padre: Association to Authors;
}