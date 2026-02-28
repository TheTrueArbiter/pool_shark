/* 
user.dart
purpose: interface class for users
*/

import 'package:pool_shark/model/stats/user_stats.dart';
import 'package:pool_shark/model/user/records/head_to_head_record.dart';
import 'package:pool_shark/model/user/records/history.dart';
import 'package:pool_shark/model/user/records/rank.dart';
import 'package:pool_shark/model/stats/match_stats.dart';
import 'package:pool_shark/model/players/user_player.dart';
import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/utils/check_length.dart';
import 'package:pool_shark/model/constants/name_lengths.dart';

class User {
  String _firstName;
  String _displayName;
  String _lastName;
  String _nickname;

  UserStats _userStats = UserStats();

  final String id;
  final Rank rank = Rank();
  final History history = History();
  final Map<User, HeadToHeadRecord> headToHeadRecords = {}; 

  User({
    required this.id,
    required String firstName,
    required String displayName,
    String lastName = '',
    String nickname = ''
  }) :  
    _firstName = firstName,
    _displayName = displayName,
    _lastName = lastName,
    _nickname = nickname {

    _checkUser();

      }

  // Class invariants 

  void _checkUser() {
    _checkFirstName(_firstName);
    _checkLastName(_lastName);
    _checkNickname(_nickname);
    _checkDisplayName(_displayName);
  }

  void _checkFirstName(String firstName) =>
      CheckLength.checkLength(firstName, 'firstName', NameLengths.firstNameMin, NameLengths.firstNameMax);

  void _checkLastName(String lastName) =>
      CheckLength.checkLength(lastName, 'lastName', NameLengths.lastNameMin, NameLengths.lastNameMax);

  void _checkNickname(String nickname) =>
      CheckLength.checkLength(nickname, 'nickname', NameLengths.nicknameMin, NameLengths.nicknameMax);

  void _checkDisplayName(String displayName) =>
      CheckLength.checkLength(displayName, 'displayName', NameLengths.displayNameMin, NameLengths.displayNameMax);

  void checkId(String id) {
    // TODO: add ID invariants once a method has been chosen for ID's 
  }


  // Pre conditions

  // Precondition for updateHeadToHead 
  void _checkIsUserPlayer(Player player) {
    assert(
      player is UserPlayer, 
      'LocalUser, RecordSinglesHeadToHead, Can only update headToHeadRecord of \n'
      'non guest players'
    );
  }

  // Precondition for updateHeadToHead
  void _checkIsSameId(String idToCheck) {
    assert( 
      idToCheck == id,
      'LocalUser, RecordSinglesHeadToHead : user id of match stats must match user\n'
      'of the user your are tring to update their headToHeadRecord of'
    );
  } 

  // Precondition for updateHeadToHead 
  void _checkHeadToHeadRecord(HeadToHeadRecord? record) {
    assert(record != null, 'LocalUser: HeadToHeadRecord cannot be null');
  } 

  // Precondition for resetHeadToHeadRecord 
  void _checkRecordReturn(User user) {
    assert(
      headToHeadRecords[user] != null,
      'Cannot reset a headToHead record of a record that doesnt exist. null was returned'
    );
  }

  // Getters

  String get firstName => _firstName;
  String get lastName => _lastName; 
  String get nickname => _nickname; 
  String get displayName => _displayName;
  UserStats get userStats => _userStats;


  // Setters
  
  set firstName(String fistName) {
    _checkFirstName(firstName);
    _firstName = firstName; 
  }

  set lastName(String lastName) {
    _checkLastName(lastName);
    _lastName = lastName;
  }

  set nickname(String nickname) {
    _checkNickname(nickname);
    _nickname = nickname;
  }

  set displayName(String displayName) {
    _checkDisplayName(displayName); 
    _displayName = displayName;
  }

  // Logic 

  void resetUserStats() {
    _userStats = UserStats();
  }

  void updateHeadToHeadRecord(MatchStats matchStats) {

    _checkIsUserPlayer(matchStats.statsOf);
    User user = (matchStats.statsOf as UserPlayer).user; 
    _checkIsSameId(user.id);


    for(Player p in matchStats.opponent) {
      _checkIsUserPlayer(p);
    }

    User opponent = (matchStats.opponent as UserPlayer).user;

    HeadToHeadRecord? record = headToHeadRecords[opponent];
    _checkHeadToHeadRecord(record);
  }

  void resetHeadToHeadRecord(User user) {
    _checkRecordReturn(user);
    headToHeadRecords[user] = HeadToHeadRecord(this, user);
  }
}
