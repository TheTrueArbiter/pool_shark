```
    class BreakResult {
        <<Enum>>
        WET 
        DRY 
        FOUL
        NOT_BREAKING
        NOT_TAKEN
    }

    class Outcome {
        <<Enum>>
        WIN 
        LOST 
        DRAW
        UNDECIDED
    }

    class GameType {
        <<Enum>>
        EIGHT_BALL 
        NINE_BALL 
        TEN_BALL 
    }
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

``
