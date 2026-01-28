/* 
team.dart 
Purpose: hold data for a team

Notes:
1) This team class a team of a match, league or tournement. This is the general
   thought of what a 'team' is in pool. This is NOT a sub team which would be the 
   GameTeam object. see GameTeam for more info

*/
import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/userProfile/user_profile.dart';
final class Team {

  final String name;
  final UserProfile captain;
  final List<Player> team = [];
  final List<Player> subs = [];

  Team(this.name, this.captain) {
    // _checkInvariants();
  }

  // void _checkInvariants() {}

}
