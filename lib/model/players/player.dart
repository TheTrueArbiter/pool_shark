/* 
player.dart

purpose: interface for player classes. Player classes will represent 
players in games, matches, tournements, and leagues.
*/

import 'package:pool_shark/model/user/records/rank.dart';
import 'package:pool_shark/model/team/team.dart';

abstract class Player {
  String get displayName;
  String get firstName;
  String get lastName;
  String get nickname;

  Rank get rank;
  Team? get team;
}

