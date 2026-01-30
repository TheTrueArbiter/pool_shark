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
       player.length == 1 || player.length = 2 
    "

    class Game {
        final GameType gameType
        final Map<Player, GameStats> playerStats 
        final GameTeam team1
        final GameTeam team2
        final ScoringSystem? scoringSystem
        final int gameId

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
        DateTime matchTimeUTC

        Team team1 
        Team team2 
        Team winner
        List<Games> games

        MatchSettings settings
        String matchId

        int team1Score 
        int team2Score
        int team1Wins
        int team2Wins

        int matchTimeSeconds
        boolean isBeingPlayed

        generateGames() void
        nextTeamBreaking() TeamBreaking

        addGame() void 
        removeGame() void 

        get gamesPlayed() int
        get matchTimeLocal() DateTime 
        get matchTimeUTC() DateTime
    }

    note for Match "Invariant properties:
        team1Score >= 0
        team2Score >= 0
        team1Wins >= 0
        team2Wins >= 0
        matchTimeSeconds >= 0
    "

    class MatchSettings {
        final MatchType matchType           
        final MatchContext matchContext      
        final MatchScoring scoring
        final GameType gameType 
        final BreakingFormat breakingFormat
        final int team1WinTarget 
        final int team2WinTarget 
        final bool isHandcap
        final ScoringSystem?

        get isWinTarget() bool
    }

    note for MatchSettings "Invariant properties:
        team1WinTarget >= 1 or team1WinTarget == -1
        team2WinTarget >= 1 or team2WinTarget == -1
    "
    
    class MatchStats {}
    note for MatchStats "See statsModel.md for more details"

    class GameStats {} 
    note for GameStats "See statsModel.md for more details"

```
