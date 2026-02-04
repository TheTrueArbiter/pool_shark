/* 
user.dart
purpose: interface class for users
*/

import 'package:pool_shark/model/stats/user_stats.dart';
import 'package:pool_shark/model/userProfile/head_to_head_record.dart';
import 'package:pool_shark/model/userProfile/history.dart';
import 'package:pool_shark/model/userProfile/rank.dart';
import 'package:pool_shark/model/userProfile/user_profile.dart';

abstract class User {
  String get firstName; 
  String get lastName; 
  String get nickname;
  String get displayName;

  Rank get rank;
  HeadToHeadRecord get headToHeadRecord;
  History get history;
  UserStats get userStats;

  set firstName(String firstName);
  set lastName(String lastName);
  set nickName(String nickName); 
  set displayName(String displayName);

  void resetSingleHeadToHead(User user);
  void resetAllHeadToHead();
  void resetUserStats();

  void updateHeadToHeadRecord(User user);
}
