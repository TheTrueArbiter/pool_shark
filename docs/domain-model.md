```
classDiagram
  UserProfile *-- UserStats : Composition
  UserProfile *-- Match : Composition 
  UserProfile *-- HeadToHeadRecord : Composition 
  UserProfile *-- Ranking : Composition 
  UserProfile *-- History : Composition 

  Match *-- MatchStats : Composition
  Match *-- Game : Composition
  Match *-- MatchSettings : Composition

  MatchSettings --> MatchFormat : uses 
  MatchSettings --> MatchType: uses 
  MatchSettings --> MatchScoring : uses 
  MatchSettings --> GameType : uses 
  MatchSettings --> BreakingFormat : uses 

  Game o-- GameStats : Aggrigation
  Game --> MatchFormat : uses 
  Game --> GameType : uses 
  Game --> Breaking : uses 

  UserStats ..|> MultiGameShootingStats : Implements
  UserStats ..|> BreakingStats : Implements

  MatchStats ..|> MultiGameShootingStats : Implements
  MatchStats ..|> BreakingStats : Implements
  MatchStats *-- GameStats : Composition
  MatchStats --> Outcome : Uses

  GameStats --> BreakResult : Uses
  GameStats --> Outcome : Uses

  ShootingStats <.. GameStats : Implements

  MultiGameShootingStats --|> ShootingStats : Inherits 

  Tournment *-- TournementSettings : Composition
  Tournment *-- RoundRobinPhase : Composition
  Tournment *-- KnockOutPhase : Composition

  KnockOutPhase *-- Bracket : Composition

  RoundRobinPhase *-- Group : Composition
  RoundRobinPhase *-- ScoreBoard : Composition

    class UserProfile {
        String firstName
        String lastName
        String nickname 
        String username
        String email

        UserStats userStats
        Ranking ranking
        History history
        
        Map<UserProfile, HeadToHeadRecord> headToHeadRecords 
        List<UserProfile> friends
        
        getFirstName() String 
        getLastName() String 
        getNickName() String 
        getUserName() String
        getEmail() String

        getUserStats() UserStats

        setFirstName(String firstName) void 
        setLastName(String lastName) void 
        setNickname(String nickname) void
        setUsername(String username) void 
        setEmail(String email) void
    }

    note for UserProfile "Invariant properties:
        firstName != null
        firstName.length >= 1 && firstName.length <= 50
        lastName != null 
        lastName.length <= 50
        nickName != null 
        nickName.length <= 50
        userName != null
        userName.length >= 5 && username.length <= 50
        email != null
        userStats != null
        friends != null
        for each UserProfile in friends != null 
        history != null
    "

    class HeadToHeadRecord {
        int gamesWon 
        int gamesLost
        int matchesWon
        int matchesLost

        getGamesWon() int 
        getGamesLost() int
        getTotalGames() int

        getMatchesWon() int 
        getMatchesLost() int
        getMatchesPlayed() int

        updateRecord(Match match) 
    }

    note for HeadToHeadRecord "Invariant properties:
        gamesWon >= 0
        gamesLost>= 0
        matchesWons >= 0
        matchesLost >= 0
    "

    class Ranking {
        int fargoRating
        ApaNineBallRank apaNineBallRank
        ApaEightBallRank apaEightBallRank

        updateFargo(int opponentFargo, Outcome outcome) void
        setApaNineBallRank() void 
        setApaEightBallRank() void
    }

    note for Ranking "Invariant properties:
        fargoRating >= 200
    "

    class History {
        List<Match> matchHistory
        List<Tournment> tournmentHistory
        List<Leauge> leaugeHistory

        addToList(List<t> list, t object)
        
        getMatchHistory() List<Match>
        getTournmentHistory() List<Tournment>
        getLeaugeHistory() List<leaugeHistory>
    }

    note for History "Invariant properties:
        matchHistory != null 
        each Match in matchHistory != null
        tournmentHistory != null 
        each Tournment in tournmentHistory != null
        leaugeHistory != null 
        each Leauge in leaugeHistory != null
        headToHeadRecords != null
        for each HeadToHeadRecord in headToHeadRecords != null
    "

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

        GameType gameType
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

    class Outcome {
        <<Enum>>
        WIN 
        LOST 
    }

    class GameType {
        <<Enum>>
        EIGHT_BALL 
        NINE_BALL 
        TEN_BALL 
    }

    class Team {
        String teamName
        UserProfile captain 
        List<UserProfile> members
        List<UserProfile> subs

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


    class Game {
        MatchType matchType 
        GameType gameType
        Breaking teamBreaking 
        UserProfile playerBreaking

        List<UserProfile> team1
        List<UserProfile> team2
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

    class TournementSettings {
        GameType gameType
        MatchType matchType
        MatchScoring matchScoring
        BreakingFormat breakingFormat
        EliminationType eliminationType
        boolean isHandicap
        boolean isRoundRobin
        boolean isSeeded
        int numOfTables
        int teamLimit
        int teamSizeLimit
        int teamSizeMin
        int[] winsPerRound
        int prizeMoneyDollars
        
        getMatchType() MatchType 
        getMatchScoring() matchScoring
        getBreakingFormat() BreakingFormat 
        getEliminationType() EliminationType 
        getIsHandiCap() Boolean 
        getIsRoundRobin() Boolean 
        getIsSeeded() Boolean 
        getTeamLimit() int
        getTeamSizeLimit() int 
        getTeamSizeMin() int 
        getWinsPerRound() int[] 
        getWinsForRound(int round) int
        getPrizeMoneyDollars() double
    }

    note for TournementSettings "Invariant properties:
        gameType != null
        matchType != null 
        matchScoring != null
        breakingFormat != null 
        eliminationType != null 
        numOfTables >= 1
        teamLimit >= 4 OR teamLimit = -1    // -1 for no limit
        teamSizeLimit >= 1 && teamSizeLimit <= 10
        teamSizeMin >= 1 && teamSizeMin <= teamSizeLimit 
        winsPerRound != null 
        each element in winsPerRound >= 1 
        prizeMoneyDollars >= 0
    "

    class Tournment {
        String name
        List<Team> teams
        TournementSettings settings
        RoundRobinPhase roundRobin
        KnockOutPhase knockOut

        getWinner() Team 
    }

    note for Tournment "Invariant properties:
        name != null 
        name.length >= 1 
        teams != null 
        teams.size >= 3
        for each Team in teams != null
        settings != null 
        roundRobin != null 
        KnockOutPhase != null
    "


    class RoundRobinPhase {
        int numOfGroups
        int teamsToAdvace 
        int matchesPerTeam

        List<Group> groups

        boolean isComplete

        generateMatches() void

        getAdvancingTeams() Map<Team {Group, Rank}>
        getGroups() List<Group>
        getGroup(String groupName) Group 
        getGroup(int index) Group
        getMatchesForTeam(Team team) list<Match>
    } 

    note for RoundRobinPhase "Invariant properties:
        numOfGroups >= 1
        teamsToAdvace >= 1 
        matchesPerTeam >= 1 
        groups != null 
        each Group in groups != null 
        groups.size == numOfGroups
    "

    class KnockOutPhase {
        boolean isSeeded
        Bracket bracket 
        List<Team> teams
        List<Match> matches
        Map<Team, int> teamPlacement        // the round a team made it too
        
        generateBracket() void
        getActiveMatches() List<Match>
    }

    class Bracket { 
        List<Match> matches

        getActiveMatches() List<Match>
        getFirstRoundMatches() List<Match>
        getQuarterFinals() list<Match>
        getSemiFinals() list<Match>
    }

    class MatchNode {
        Match match 
        List<Edge> nextMatches 
        List<Edge> incomingEdges
        boolean isFinshed
    }

    class Edge {
        MatchNode target 
        boolean isWinnerEdge
    }

    class Group {
        String name 
        List<Team> teams 
        List<Match> matches
        Scoreboard scoreboard
        boolean isComplete
    
        getName() String 
        getTeams() List<Team>
        getScoreboard() ScoreBoard
    }

    note for Group "Invariant properties:
        name != null
        name.lenght >= 1 
        teams != null
        teams.size >= 2 
        for each Team in teams != null
        matches != null
        matches.size >= 1 
        for each Match in matches != null 
        scoreboard != null
    "


    class Scoreboard {
        Map<Team ScoreBoardEntry> entries 

        getStandings() List<ScoreBoardEntry>
        recordMatchResult(Match match) void 
        
    }

    note for Scoreboard "Invariant properties:
        entries != null
    "
 
    class ScoreboardEntry {
        Team team 

        int matchesPlayed   
        int matchesWon 
        int matchesLost
        int points
    
        boolean isDivisionWon
        boolean isInKnockOut

        getMatchesPlayed() int 
        getMatchesWon() int  
        getMatchesLost() int 
        getPoints() int 
        getTeam() Team
        getIsDivisionWon() boolean 
        getIsInKnockOut() boolean
    } 
    
    note for ScoreBoardEntry "Invariant properties:
        team != null 
        matchesPlayed >= 0
        matchesWon >= 0 
        matches Lost >= 0 
        matchesPlayed == matchesWon + matchesLost
        points >= 0
    "
 
    class EliminationType {
        SINGLE 
        DOUBLE 
    }

    class Breaking {
        <<Enum>>
        TEAM1 
        TEAM2
    }

    class BreakingFormat {
        <<Enum>>
        WINNER 
        LOSER
        ALTERNATE
    }

    class MatchContext {
        <<Enum>>
        TOURNAMENT
        LEAGUE
        CASUAL
        MONEY
    }

    class MatchScoring {
        <<Enums>>
        POINTS
        WINS
    }

    class MatchType {
        <<Enum>>
        SINGLES 
        DOUBLES 
        TEAM_SINGLES 
        TEAM_DOUBLES
    }

    class ApaEightBallRank {
        <<Enum>>
        2 
        3
        4
        5
        6
        7   
    }

    class ApaNineBallRank {
        <<Enum>>
        1
        2 
        3
        4
        5
        6
        7   
        8
    }

    class StatMode {
        DEFAULT
        OUTCOME 
        DETAILED
    }

  ``` 



