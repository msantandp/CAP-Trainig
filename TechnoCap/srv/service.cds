using { technoCap as my } from '../db/schema';

service api {
    entity Client as projection on my.Client;
    entity Proyect as projection on my.Proyect;
    entity Proyect_Technology as projection on my.Proyect_Technology;
    entity Technology as projection on my.Technology;


    action calculate() returns String;

}