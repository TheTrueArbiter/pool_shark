/* 
participant.dart
*/

import 'package:pool_shark/model/userProfile/rank.dart';
import 'package:pool_shark/model/match/team.dart';

abstract class Player {
  String get displayName;
  String get firstName;
  String get lastName;
  String get nickname;

  Rank get rank;
  Team get team;
}

