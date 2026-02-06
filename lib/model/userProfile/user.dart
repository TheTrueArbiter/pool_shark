/* 
user.dart
purpose: interface class for users
*/

import 'package:pool_shark/model/stats/user_stats.dart';
import 'package:pool_shark/model/userProfile/head_to_head_record.dart';
import 'package:pool_shark/model/userProfile/history.dart';
import 'package:pool_shark/model/userProfile/rank.dart';
import 'package:pool_shark/model/stats/match_stats.dart';

abstract class User {
  int get id;

  String get firstName; 
  String get lastName; 
  String get nickname;
  String get displayName;

  Rank get rank;
  Map<User, HeadToHeadRecord> get headToHeadRecords;
  History get history;
  UserStats get userStats;

  set firstName(String firstName);
  set lastName(String lastName);
  set nickname(String nickName); 
  set displayName(String displayName);

  void resetHeadToHeadRecord(User user);
  void updateHeadToHeadRecord(MatchStats matchStats);
  void resetUserStats();
}
