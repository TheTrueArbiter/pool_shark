```
classDiagram
    UserStats *-- BreakingStats : Composition 
    UserStats *-- ShootingStats : Composition 

    Match *-- MatchStats : Composition
    Game *-- GameStats : Composition
    User *-- UserStats : Composition

    MatchStats *-- BreakingStats : Composition 
    MatchStats *-- ShootingStats: Composition 
    MatchStats o-- User: Aggrigation
    MatchStats --> Outcome : Uses

    GameStats *-- ShootingStats : Composition
    GameStats --> BreakResult : Uses
    GameStats --> Outcome: Uses
    GameStats --> GameType: Uses





    class ShootingStats {
        int _potted 
        int _missed 
        int _fouls 
        int _safeties

        get potted() int 
        get missed() int 
        get fouls() int 
        get safeties() int
        get totalShots() int
        
        get pottingRate() double  
        get missdedRate() double  
        get fouldRate() double  
        get safetyRate() double 

        addPotted() void 
        addMissed() void 
        addFouls() void 
        addSafeties() void
    }

    note for ShootingStats "Invariant properties:
        _potted, _missed, _fouls, _safeties >= 0
    "

    class BreakingStats {
        int _wetBreaks 
        int _dryBreaks 
        int _foulBreaks

        get totalBreaks() int 
        get wetBreaks() int 
        get dryBreaks() int 
        get foulBreaks() int

        get wetBreakRate() double
        get dryBreakRate() double 
        get foulBreakRate() double 
        
        addWetBreaks() void 
        addDryBreaks() void 
        addFoulBreaks() void 
    } 

    note for BreakingStats "Invariant properties:
       _wetBreaks, _dryBreaks, _foulBreaks >= 0 
    "

    class UserStats {
        final ShootingStats shootingStats
        final breakingStats breakingStats

        int _gamesWon 
        int _gamesLost

        int _matchesWon
        int _matchesLost

        int _breakAndRuns

        get gamesPlayed() int 
        get gameWon() int 
        get gamesLost() int 
        get gameWinRate() double

        get matchesPlayed() int
        get matchesWon() int
        get matchesLost() int
        get matchWinRate() double

        updateStats(MatchStats matchstats) void 
        
        
    }

    note for UserStats "Invariant properties:
        gamesWons, gamesLost >= 0
        matchesWon, matchesLost >= 0
        _breakAndRuns >= 0
    "

    class MatchStats {
        final Player statsOf
        final Player opponent
        final ShootingStats shootingStats
        final BreakingStats breakingStats
    
        int _breakAndRuns
        int _gamesWon
        int _gamesLost
    
        Outcome matchResult

        updateMatchStats(GameStats gameStats) void
       
        get gamesPlayed() int 
        get gamesWon() int 
        get gamesLost() int

        get pottingAverage() double 
        get missedAverage() double 
        get foulAverage() double
        get safetyAverage() double 

        get breakAndRuns() int 
        get breakAndRunRate() double
        
        updateStats(GameStats gameStats)
    }

    note for MatchStats "Invariant properties:
        _gamesWons, _gamesLost >= 0
        _breakAndRuns >= 0
    "

    class GameStats {
        final GameType gameType
        final TeamBreaking teamBreaking

        final ShootingStats shootingStats
        final BreakingStats breakingStats
        
        Outcome gameResult 
        BreakResult breakResult
        boolean isBnr
    }

    note for GameStats "Invariant properties:
        None
       "

    class BreakResult { <<Enum>> }
    note for BreakResult "See commoneEnums.md for more details"

    class GameType { <<Enum>> }
    note for GameType "See commoneEnums.md for more details"

    class Outcome { <<Enum>> }
    note for Outcome "See commoneEnums.md for more details"

    class Match {}
    note for Match "See matchModel.md for more details"

    class Game {}
    note for Game "See matchModel.md for more details"

    class User{}
    note for UserProfile "See userProfile.md for more details"

  ``` 



