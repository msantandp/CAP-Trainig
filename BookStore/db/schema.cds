using { cuid, managed } from '@sap/cds/common';
namespace bookStore;

type Dates : String;
// type Names {
//     name: String(20);
//     lastName: String(20);
// } 

type Names : String(20);




entity Book : cuid {
    name: Names;
    publicationDate: Dates;
    score: Integer @assert.range: [0,5];
    critics: array of String(50);
    editorial: Association to Editorial;
    client: Association to Client;
    author: Association to Author;
}



entity Client : cuid {
    name: Names;
    birthDate: Dates;
    dni: Integer;
    user: Composition of many User on user.client = $self;
    book: Association to many Book on book.client = $self;

}

entity User : cuid {
    key client: Association to Client;
    username: String(20);
    password: String(20);
    email: array of String(30);
    points: Integer;
    condition: Integer enum {
        activo = 1;
        baja = 2;
        pendiente = 3;
    }
}

entity Author : cuid {
    name: Names;
    genre: String(15) default 'Novela';
    birthDate: Dates;
    nationality: String(20);
    quantityPublished: Integer;
    //venta directa
    editorial: Association to Editorial;
    book: Association to Book;
}

entity Editorial : cuid {
    name: String(30);
    nationality: String(20);
    autor: Association to many Author on autor.editorial = $self;
}

entity Log : cuid, managed {
    crudFun: String;
    idTarget: String;
    entity: String;
    msg: String;
    // date: DateTime;
}

