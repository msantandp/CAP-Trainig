using { manageFutbol as my } from '../db/schema';

service api {
    entity Stadium as projection on my.Stadium;
    entity Team as projection on my.Team;
    entity Player as projection on my.Player;
    entity Result as projection on my.Result;
    entity Match as projection on my.Match;
    entity Score as projection on my.Score;

    entity view1 as select from Player{
        *,
        score.match.ID as match_ID,
        score.goals as goles
    } where score.goals >= 3;

    entity view2 as select from Result{
        match.ID,
        match.localTeam.name as local,
        localScore,
        match.guestTeam.name as guest,
        guestScore,

    } where ABS(localScore-guestScore) > 3;

    //http://localhost:4004/api/view3?$orderby=salvadas&$top=1
    entity view3 as select  from Player{
        *,
        score.saves as salvadas,
    } where position = 'Arquero';

    //delantero goleador
    entity view4 as select from Player{
        *,
        score.goals as goles
    } where position = 'Delantero' order by goles limit 1;

    entity view5 as select from Player{
        *,
        avg(score.goals) as golProm : Decimal(6, 3)
    }group by ID, name order by golProm desc;


    // entity view6 as select from Team{
    //     sum(player.score.goals) as sumaGoles : Integer64
    // };
    // entity view6 as select from Team{
        
    //     sum(match.result.localScore) as sumaGoles : Integer64
    // }where match.localTeam.ID = ID;
    entity view6 as select from Team{
        
        sum(match.result.guestScore) as sumaGoles : Integer64
    }where match.guestTeam.ID = ID;

}