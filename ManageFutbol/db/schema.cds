using { cuid, managed } from '@sap/cds/common';
namespace manageFutbol;


//Agregar managed
entity Match : cuid {
    people: Integer;
    referee: String(20);
    commentator: String(20);
    matchDate: Date;
    classic: Boolean;
    localTeam: Association to Team; 
    guestTeam: Association to Team; 
    score: Association to many Score on score.match = $self; 
    stadium: Association to Stadium; 
    result: Composition of Result; 
}

entity Result : cuid {
    localScore: Integer;
    guestScore: Integer;
    match: Association to Match; 
}

entity Team : cuid {
    name: String(50);
    rank: String(20);
    scoreTeam: Integer;
    players: Integer;
    budget: Integer;
    player: Composition of many Player on player.team = $self; 
    match: Association to many Match on match.localTeam = $self or match.guestTeam = $self; 
    stadium: Association to Stadium; 
}

entity Player : cuid {
    name: String(20);
    value: Integer;
    aka: String(20);
    position: String(20);
    country: String(10);
    number: Integer;
    score: Association to many Score on score.player = $self; 
    team: Association to Team; 
}

entity Stadium : cuid {
    name: String(30);
    address: String(20);
    capacity: Integer;
    match: Association to many Match on match.stadium = $self; 
    team: Association to many Team on team.stadium = $self; 
}

entity Score: cuid {
    key player: Association to Player;  
    key match: Association to Match; 
    goals: Integer default 0;
    assist: Integer default 0;
    saves: Integer default 0;
}
