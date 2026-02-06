```
classDiagram
   Player <-- UserParticipant : Implements 
   Player <-- GuestParticipant : Implements 
   Player o-- User : Aggrigation

class Player {
    <<interface>>
    String get firstName;
    String get lastName;
    String get nickName;
    String get displayName;

    Rank get rank;
    Team get team;
}

class UserPlayer {
    final User user
    final Team team
}

class GuestPlayer {
    final String firstName;
    final String lastName;
    final String nickname;
    final String displayName;

    final Rank rank;
    final Team team;
}

class User {}
    note for User "See userModel.md for more details"





