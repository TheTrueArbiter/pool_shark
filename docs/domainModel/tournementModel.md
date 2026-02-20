```
classDiagram
  Tournment *-- TournementSettings : Composition
  Tournment *-- RoundRobinPhase : Composition
  Tournment *-- KnockOutPhase : Composition
  Tournment *-- Team : Composition

  Group *-- Scoreboard : Composition

  KnockOutPhase *-- Bracket : Composition

  Bracket *-- MatchNode : Composition(Inner Class)
  Bracket *-- Edge : Composition(Inner Class)
  Bracket *-- Match : Composition

  Scoreboard *-- ScoreboardEntry : Composition

  RoundRobinPhase *-- Group : Composition

  PrizeMoney *-- MoneyDistribution : Composition

  MoneyDistribution <|- RoundDistribution 
  MoneyDistribution <|- PodiumDistribution 

    class PrizeMoney {
        final double prizePoolDollars;
        final MoneyDistributionType moneyDistributionType;
        final MoneyDistribution moneyDistribution;

    }

    class MoneyDistribution {
        <<interface>>
        get winnersPay
        get runnerUpsPay
    }

    class PodiumDistribution {
          final double firstPlacePay;
          final double secondPlacePay;
          final double thirdPlacePay; 
    }
    note for PodiumDistribution "Invariant properties:
        firstPlacePay, secondPlacePay, thirdPlacePay >= 0
        firstPlacePay > secondPlacePay
        if (secondPlacePay != 0) secondPlacePay > thirdPlacePay
    "


    class RoundDistribution {
          final double firstPlacePay;
          final double secondPlacePay;
          final Map<int, double> roundPayouts;
    }

    note for RoundDistribution "Invariant properties:
        firstPlacePay, secondPlacePay >= 0
        firstPlacePay > secondPlacePay
    "


    class TournementSettings {
        final GameType gameType
        final MatchType matchType

        final MatchScoring matchScoring
        final ScoringSystem? scoringSystem

        final BreakingFormat breakingFormat
        final EliminationType eliminationType
        PrizeMoney prizeMoney


        final boolean isHandicap
        final boolean isRoundRobin
        final boolean isSeeded

        int numOfTables

        final int teamLimit
        final int teamSizeLimit
        final int subLimit

        int[] winsPerRound
        int prizeMoneyDollars
    }

    note for TournementSettings "Invariant properties:
    "

    class Tournment {
        String name
        UserProfile organizer
        List<Team> teams
        TournementSettings settings
        RoundRobinPhase roundRobin
        KnockOutPhase knockOut

        getName() String 
        getTeams() List<Team>
        getTeam(String name) Team 
        getSettings() TournementSettings
        getRoundRobinPhase() RoundRobinPhase
        getKnockOutPhase() KnockOutPhase

        getWinner() Team 
    }

    note for Tournment "Invariant properties:
        name != null 
        name.length >= 1 
        organizer != null 
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

        getAdvancingTeams() Map<Team <Group, Rank>>
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
        Map<Team, int> teamPlacement        // the round a team made it too
        boolean isFinshed
        
        generateBracket() void
        getActiveMatches() List<Match>
        getMatches() List<Match>
    }

    note for KnockOutPhase "Invariant properties:
        bracket != null
        teams != null
        for each Team in teams != null 
        teamPlacement != null 
        each Team in teams is a key in teamPlacement 
    "

    class Bracket { 
        List<Match> matches

        getActiveMatches() list<Match>
        getMatches() list<Match>
        getFirstRoundMatches() list<Match>
        getQuarterFinals() list<Match>
        getSemiFinals() list<Match>
    }

    note for Bracket "Invariant properties:
        matches != null 
        for each Match in matches != null 
    "

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
        final String name 
        final List<Team> teams 
        final List<Match> matches
        final Scoreboard scoreboard

        boolean isComplete
    
    }

    note for Group "Invariant properties:
        name.lenght >= 1 
        teams.size >= 2 
        matches.size >= 1 
    "


    class Scoreboard {
        Map<Team ScoreBoardEntry> entries 

        getStandings() List<ScoreBoardEntry>
        recordMatchResult(Team team, Outcome outcome) void 
        
    }

    note for Scoreboard "Invariant properties:
        entries != null
    "
 
    class ScoreboardEntry {
        Team team 

        int matchesPlayed   
        int matchesWon 
        int matchesLost
    
    } 
    
    note for ScoreboardEntry "Invariant properties:
        team != null 
        matchesPlayed >= 0
        matchesWon >= 0 
        matches Lost >= 0 
        matchesPlayed == matchesWon + matchesLost
        points >= 0
    "

    class Team {}
     note for Team "See matchModel.md for more details"

    class Match{}
     note for Team "See matchModel.md for more details"

  ``` 



