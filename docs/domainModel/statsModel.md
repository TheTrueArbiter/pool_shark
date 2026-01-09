```
classDiagram
  UserStats ..|> MultiGameShootingStats : Implements
  UserStats ..|> BreakingStats : Implements

  Match *-- MatchStats : Composition
  Game *-- GameStats : Composition
  UserProfile *-- UserStats : Composition

  MatchStats ..|> MultiGameShootingStats : Implements
  MatchStats ..|> BreakingStats : Implements
  MatchStats --> Outcome : Uses

  GameStats --> BreakResult : Uses

  ShootingStats <.. GameStats : Implements

  MultiGameShootingStats --|> ShootingStats : Inherits 



      class ShootingStats {
        <<interface>>

        getPotted() int 
        getMissed() int 
        getFouls() int 
        getSafeties() int
        
        getPottingRate() double  
        getMissdedRate() double  
        getFouldRate() double  
        getSafetyRate() double 
    }

    class MultiGameShootingStats {
        <<interface>>
        getPottingAverage() double 
        getMissedAverage() double 
        getFoulAverage() double 
        getSafeAverage() double
        getBreakAndRuns() int
    }

    class BreakingStats {
        <<interface>>
        getTotalBreaks() int 
        getWetBreaks() int 
        getDryBreaks() int 
        getFoulBreaks() int

        getWetBreakPercent() double
        getDryBreakPercent() double 
        getFoulBreakPercent() double 
        getPottedOnBreakAverage() double
    } 

    class UserStats {
        int potted 
        int missed 
        int fouls 
        int safeties 
        
        int totalBreaks 
        int wetBreaks 
        int dryBreaks 
        int breakAndRuns
        
        int gamesPlayed
        int gamesWon 
        int gamesLost

        int matchesPlayed 
        int matchesWon
        int matchesLost

        double moneyWon

        updateStats(MatchStats matchstats) void 

        getGamesPlayed() int 
        getGameWon() int 
        getGamesLost() int 
        getMatchesPlayed() int
        getMatchesWon() int
        getMatchesLost() int
        
        getMoneyWon() double 
        addMoneyWon(double winnings) void
    }

    note for UserStats "Invariant properties:
        potted, missed, fouls, safeties >= 0
        totalBreaks, wetBreaks, dryBreaks >= 0
        gamesPlayed, gamesWons, gamesLost >= 0
        matchesPlayed, matchesWon, matchesLost >= 0
        breakAndRuns >= 0
        moneyWon >= 0
        gamesPlayed = gamesWon + gamesLost 
        matchesPlayed = matchesWon + matchesLost
    "

    class MatchStats {
        int potted 
        int missed 
        int fouls 
        int safeties 
        
        int totalBreaks 
        int wetBreaks 
        int dryBreaks 
        
        int gamesPlayed
        int gamesWon 
        int gamesLost
        
        Outcome matchResult

        updateMatchStats(GameStats gameStats) void
        updateMatchStats() void
    }

    note for MatchStats "Invariant properties:
        potted, missed, fouls, safeties >= 0
        totalBreaks, wetBreaks, dryBreaks >= 0
        gamesPlayed, gamesWons, gamesLost >= 0
        gamesPlayed = gamesWon + gamesLost 
        matchResult != null
    "

    class GameStats {
        int potted 
        int missed 
        int fouls 
        int safeties 

        const GameType gameType
        Outcome gameResult 
        BreakResult breakResult
        boolean isBnr

        updateBreakResult(BreakResult breakResult)
        updateGameResult(gameResult)
        updatePotted(int potted) void
        updateMissed(int missed) void 
        updateFouls(int fouls) void 
        updateSafeties(int safeties) void
    }

    note for GameStats "Invariant properties:
        potted, missed, fouls, safeties >= 0
        breakResult != null
        gameResult != null
        potted <= maxPossibleToPot
        if isBrn then potted = maxPossibleToPot && missed, fouls, safeties == 0
    "

    class BreakResult {
        <<Enum>>
        WET 
        DRY 
        FOUL
        NOT_BREAKING
    }

    class Match {}
    note for Match "See matchModel.md for more details"

    class Game {}
    note for Game "See matchModel.md for more details"

    class UserProfile{}
    note for UserProfile "See userProfile.md for more details"

  ``` 



