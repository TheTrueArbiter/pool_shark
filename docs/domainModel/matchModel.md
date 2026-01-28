 ```
classDiagram
    Match *-- MatchStats : Composition
    Match *-- Game : Composition
    Match *-- MatchSettings : Composition
    Match *-- Team : Composition 

    Game *-- GameTeam : Aggrigation

    GameTeam *-- GameStats : Composition
    

    class Team {
        String teamName
        UserProfile captain 
        List<Participant> members
        List<Participant> subs
    } 

    note for Team "Invariant properties:
       Undefined as of yet 
    "
    note for Team "Ownership of a team will belong to context of which
        the team is used for. For a casual match, Match will own Team.
        for Tournement, Tournement will own Team, and Match will have a
        reference of Team. For Leauge ....."

    class GameTeam {
        final List<Player> Players 
        final Team team 
        final Map<Player, GameStats> allPlayerStats

        initAllPlayerStats(GameType type, TeamBreaking team) void
        playerStats(player p) GameStats?
    } 
    note for GameTeam "Invariant properties:
       player.size >= 1 && <= 2 
    "

    class Game {
        final GameType gameType
        final Map<Player, GameStats> playerStats 
        final GameTeam team1
        final GameTeam team2

        TeamBreaking teamBreaking 

        Player? playerBreaking
        GameTeam? winner

        boolean isGameFinished

        int _gameTimeSeconds

        get team1FinalScore() int 
        get team2FinalScore() int

        _teamPotted(List<Player> team) int
        _score(Outcome outcome, int potted, int opponentPotted) int
        playerStats(UserProfile) GameStats
        
        setPlayerBreaking(UserProfile) void
    }

    note for Game "Invariant properties:
        if isGameFinished then winner != null
        if isGameFinished then winner != null
        gameTimeSeconds >= 0
        playerBreaking is in team1 or team2 
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
