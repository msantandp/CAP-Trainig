using { myBookShop as my } from '../db/schema';

service api {

    entity Books as SELECT from my.Books {*,
    author.name as autor_nombre};
    entity Authors as SELECT from my.Authors {*};  

    entity Inventory as select from my.Stock {
        *,
        book.name,
        book.author.ID,
        book.author.name as author_name,
        book.author.countryBirth
    };
    // entity Libros_Autor as SELECT from my.Libros_Autor {*};
    // entity Hijos as select from my.Hijos {*};

    action modInv(book: Books: ID, amount: Integer) returns String;
    action insertOrder(book: array of  my.Stock) returns String;

}

