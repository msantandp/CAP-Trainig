using { bookStore as my } from '../db/schema';

service api {
    entity Book as projection on my.Book;
    entity client as projection on my.Client;
    entity user as projection on my.User;
    entity author as projection on my.Author;
    entity editorial as projection on my.Editorial;
    entity Log as projection on my.Log excluding {createdBy,modifiedBy,modifiedAt};

    action manyBooks(books: array of my.Book) returns String;
}
