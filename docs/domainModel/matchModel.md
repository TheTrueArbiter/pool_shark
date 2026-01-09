 ```
classDiagram
  Match *-- MatchStats : Composition
  Match *-- Game : Composition
  Match *-- MatchSettings : Composition
  Match *-- Team : Composition : Read Team Note

  Game o-- GameStats : Aggrigation

    class Team {
        String teamName
        UserProfile captain 
        List<UserProfile> members
        List<UserProfile> subs
        boolean isTempTeam

        getTeamName() String 
        getCaptain() UserProfile 
        getMembers() List<UserProfile>
        getSubs() List<UserProfile> 
    } 

    note for Team "Invariant properties:
        teamName != null
        teamName.length >= 1
        members != null 
        members.size() >= 1
        subs != null
    "
    note for Team "Ownership of a team will belong to context of which
        the team is used for. For a casual match, Match will own Team.
        for Tournement, Tournement will own Team, and Match will have a
        reference of Team. For Leauge ....."


    class Game {
        MatchType matchType 
        GameType gameType
        Breaking teamBreaking 
        UserProfile playerBreaking

        List<UserProfile> team1     // list of UserProfile objects, NOT team object
        List<UserProfile> team2     // list of UserProfile objects, NOT team object

        List<UserProfile> winner

        Map<UserProfile, GameStats> gameStats 
        boolean isGameFinished

        String gameId
        int gameTimeSeconds
        int team1Score 
        int team2Score 

        getTeam1() List<UserProfile>
        getTeam2() List<UserProfile>
        getWinner() List<UserProfile>
        getIsGameFinished() boolean
        getGameId() int
        getTeam1Score() int
        getTeam2Score() int 
        
        getPlayerStats(UserProfile) GameStats
        calculateTeamScores() void
        
        setPlayerBreaking(UserProfile) void
    }

    note for Game "Invariant properties:
        matchType != null 
        gameType != null 
        teamBreaking != null 
        team1 != null 
        if matchType == SINGLES OR TEAM_SINGLES then playerBreaking != null 
        all UserProfile in team1 != null
        team2 != null 
        all UserProfile in team2 != null
        if isGameFinished then winner != null
        gameStats != null
        each user in team1 and team2 is key in gameStats 
        each GameStats in gameStats != null
        gameId != null *** ADD OTHER INVARIANT for gameId 
        gameTimeSeconds >= 0
        team1Score >= 0
        team2Score >= 0
        if matchType == SINGLES OR TEAM_SINGLES then team1.size() == 1 AND team2.size() == 1
        if matchType == DOUBLES OR TEAM_DOUBLES then team1.size() == 2 AND team2.size() == 2
    "
    note for Game "
        * Teams here are of UserProfile not Team objects
        * singles games will have teams with just 1 user
        "

    class Match {
        UserProfile admin

        Team team1 
        Team team2 
        Team winner
        List<Games> games

        Map<UserProfile, MatchStats> stats
        MatchSettings settings
        String matchId

        int team1Score 
        int team2Score
        int team1Wins
        int team2Wins

        int matchTimeSeconds
        boolean isBeingPlayed

        generateGames() void

        getTeam1() Team 
        getTeam2() Team
        getMatchStats(UserProfile user) MatchStats
        getTeam1Score() int
        getTeam2Score() int
        getTeam1Wins() int
        getTeam2Wins() int
        getGamesPlayed() int
        getMatchTime() int

        addGame() void 
        removeGame() void 
        editGame(Game game) void
    }

    note for Match "Invariant properties:
        admin != null
        team1 != null 
        all UserProfile in team1 != null    
        team2 != null
        all UserProfile in team2 != null 
        all UserProfile from team1 & team2 as keys in stats 
        each MatchStat in stats != null
        team1Score >= 0
        team2Score >= 0
        team1Wins >= 0
        team2Wins >= 0
        matchTimeSeconds >= 0
    "

    class MatchSettings {
        MatchType matchType           
        MatchContext matchContext      
        MatchScoring scoring
        GameType gameType 
        BreakingFormat breakingFormat
        int t1RaceLimit 
        int t2RaceLimit
        int t1ScoreLimit
        int t2ScoreLimit

        getMatchType() MatchType 
        getMatchContext() MatchContext 
        getMatchScoring() MatchScoring
        getGameType() GameTYpe
        getBreakType() BreakType 
        getT1RaceLimit() int 
        getT2RaceLimit() int 
        getT1ScoreLimit() int
        getT2ScoreLimit() int
        
    }

    note for MatchSettings "Invariant properties:
        matchType != null 
        matchContext != null
        scoring != null
        gameType != null
        breakingFormat != null
        t1RaceLimit >= 1 or t1RaceLimit == -1
        t2RaceLimit >= 1 or t2RaceLimit == -1
        t1ScorLimt>= 1 or t1ScorLimit == -1
        t2ScoreLimit>= 1 or t2ScoreLimit == -1
    "
    
    class MatchStats {}
    note for MatchStats "See statsModel.md for more details"

    class GameStats {} 
    note for GameStats "See statsModel.md for more details"

```
