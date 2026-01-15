/* 
team.dart 
Purpose hold data for a team
*/
import 'package:pool_shark/model/userProfile/user_profile.dart';
final class Team {

  final String name;
  final UserProfile captain;
  final List<UserProfile> team = [];
  final List<UserProfile> subs = [];

  Team(this.name, this.captain) {
    // _checkInvariants();
  }

  // void _checkInvariants() {}

}
