```
classDiagram
  UserProfile *-- UserStats : Composition
  UserProfile *-- HeadToHeadRecord : Composition 
  UserProfile *-- Ranking : Composition 
  UserProfile *-- History : Composition 

  History o-- Match : Aggriation 
  History o-- Tournment : Aggriation 
  History o-- Leauge : Aggriation 

    class User {
        <<interface>>
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

    class LocalUser {
        String firstName 
        String lastName 
        String nickName;

        final int id 
        final Rank rank 
        final History history 
        final Map<User, HeadToHeadRecord> headToHeadRecords

        resetHeadToHeadRecord(User user) void 
        updateHeadToHeadRecord(MatchStats matchStats) void
        resetUserStats() void 
    } 

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



