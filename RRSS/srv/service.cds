using { rrss as my } from '../db/schema';

service api {
    entity User as projection on my.User;
    entity User_Human as projection on my.User_human;
    entity Message as projection on my.Message;
    entity Profile as projection on my.Profile;
    entity Post as projection on my.Post;
    entity Comment as projection on my.Comment;

    entity view1 as select from Profile{
        *,
        user.username as username,
    };

    entity view2 as select * from User where country = 'ARG' and friends > 200;

    entity view3 as select from Post {
        *,
        profile.user.username as username
    }where shared > 100 ;
}