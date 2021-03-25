using { axiosEx as my } from '../db/schema';
service api {
    entity Technology as projection on my.Technology;
    

}