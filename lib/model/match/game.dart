/* 

*/

import 'package:pool_shark/model/userProfile/user_profile.dart';
import 'package:pool_shark/model/enums/game_type.dart';
// import 'package:pool_shark/model/enums/match/match_type.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';

final class Game {

    final GameType gameType;
    final List<UserProfiel> team2;
    final List<UserProfile> team1; 

    TeamBreaking teamBreaking;
    UserProfile playerBreaking;

    List<UserProfile> winner;
}
