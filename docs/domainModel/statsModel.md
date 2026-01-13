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
        
        int wetBreaks 
        int dryBreaks 
        
        int gamesWon 
        int gamesLost
        
        Outcome matchResult

        updateMatchStats(GameStats gameStats) void
        
        getPotted() int 
        getMissed() int 
        getFouls() int 
        getSafeties() int
        
        getTotalBreaks() int 
        getWetBreaks() int 
        getDryBreaks() int 
        
        getGamesPlayed() int 
        getGamesWon() int 
        getGamesLost() int
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
        int totalShots

        final GameType gameType
        final TeamBreaking teamBreaking
        
        Outcome gameResult 
        BreakResult breakResult
        boolean isBnr

        maxPottable() int

        setBreakResult(BreakResult breakResult) void
        setGameResult(gameResult) void
        setPotted(int potted) void
        setMissed(int missed) void 
        setFouls(int fouls) void 
        setSafeties(int safeties) void

        getBreakResult() BreakResult 
        getGameResult() gameResult 
        getPotted() int 
        getMissed() int  
        getFouls() int  
        getSafeties() int  

    }

    note for GameStats "Invariant properties:
        potted, missed, fouls, safeties >= 0
        potted <= maxPottable();
        totalShots >= 0 
        totalShots = potted + missed + fouls + safeties
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



