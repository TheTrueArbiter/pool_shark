```
classDiagram
  User *-- UserStats : Composition
  User *-- HeadToHeadRecord : Composition 
  User *-- Ranking : Composition 
  User *-- History : Composition 

  User <|-- LocalUser : inheritence
  User <|-- OnlineUser : inheritence

  History o-- Match : Aggriation 
  History o-- Tournment : Aggriation 
  History o-- Leauge : Aggriation 

    class User {
        String firstName 
        String lastName 
        String nickName

        final int id 
        final Rank rank 
        final History history 
        final Map<User, HeadToHeadRecord> headToHeadRecords

        int get id;

        String get firstName 
        String get lastName 
        String get nickname
        String get displayName 

        Rank get rank
        HeadToHeadRecord get headToHeadRecord
        History get history
        UserStats get userStats

        set firstName(String firstName) void
        set lastName(String lastName) void
        set nickName(String nickName) void
        set displayName(String displayName) void 

        resetHeadToHeadRecord(User user) void 
        updateHeadToHeadRecord(MatchStats matchStats)
        resetUserStats() void 
    }
    note for User "Invariant properties:
            1 <= firstName.length <= 32
            0 <= lastName.length <= 32
            0 <= nickname.length <= 32
            1 <= displayName.length <= firstName.length + lastName.length + nickname.length

        "

    class LocalUser {} 
    note for LocalUser "This class is not unique from User class yet"

    class OnlineUser {
        String email 
        String username 
        String passwordHash
        
        get username() String 
        get passwordHash() String 
        get email() String 

        set username(String username) void 
        set email(Stirng email) void
        set passwordHash(String passwordHash) void
    }
    note for OnlineUser "Invariant properties:
            3 <= username.length <= 20
            * Need to add passwordHash invariants
            email contains only 1 '@' 
            email has a domain and username which is not empty
            domain of email has a '.' and a tld
        "

    class HeadToHeadRecord {
        User user 
        User opponent

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
        user != opponent
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
    }

    note for Ranking "Invariant properties:
        fargoRating >= 200 && fargoRating <= 1000
    "

    class History {
        List<Match> matchHistory
        List<Tournment> tournmentHistory
        List<Leauge> leaugeHistory

        addToList(List<t> list, t object)
    }

    note for History "Invariant properties:
    "

    class UserStats {}
    note for UserStats "View statsModel.md for details"

    class Match {}
    note for Match "View matchModel.md for details"

    class Tournment {}
    note for Tournment "View tournment.md for details"



