/* 
user.dart
purpose: interface class for users
*/

import 'package:pool_shark/model/userProfile/rank.dart';

abstract class User {
  String get firstName; 
  String get lastName; 
  String get nickname;
  String get displayName;

  Rank get rank;
  
}
