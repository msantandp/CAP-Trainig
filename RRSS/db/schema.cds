using { cuid, managed } from '@sap/cds/common';
namespace rrss;



//debe ser aspect
aspect Human {
    name: String(20);
    lastname: String(20);
    country: String(3);
    gender: Integer enum {
        Femenino = 1;
        Masculino = 2;
        NoBinario = 3; 
    };
    phone: String(9);
    birthDate: Date;
    email: array of {
        user: String(15);
        domain: String(15);
        full: String(30);
    }
}

entity User : cuid, Human {
    username: String(20);
    password: String(20);
    friends: Integer;
    status: Boolean;
    human: Composition of one Human;
    message: Composition of many Message on message.user = $self;
    profile: Association to Profile;
}

entity Message : cuid {
    sender: String(20);
    content: String(50);
    read: Boolean;
    multimedia: array of {
        typeM: String(10);
        size: Decimal(7,3);
    };
    user: Association to User;
}

entity Profile : cuid {
    title: String(20);
    desc: String(50);
    views: Integer;
    rank: Integer enum {
        carbon = 0;
        bronze = 1;
        plata = 2;
        oro = 3;
        diamante = 4;
    };
    user: Association to User;
    post: Association to many Post on post.profile = $self;
}

entity Post : cuid, managed {
    title: String(30) default'titulo';
    shared: Integer;
    typePost: Integer enum {
        texto = 1;
        foto = 2;
        video = 3;
        url = 5;
    };
    preview: Boolean;
    likes: Integer;
    profile: Association to Profile;
    comment: Association to many Comment on comment.post = $self;
}

entity Comment : cuid, managed {
    content: String(100);
    post: Association to Post;
}


