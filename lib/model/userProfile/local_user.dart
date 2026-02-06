import 'package:pool_shark/model/constants/name_lengths.dart';
import 'package:pool_shark/model/players/user_player.dart';

import 'package:pool_shark/model/stats/user_stats.dart';
import 'package:pool_shark/model/userProfile/head_to_head_record.dart';
import 'package:pool_shark/model/userProfile/history.dart';
import 'package:pool_shark/model/userProfile/user.dart';
import 'package:pool_shark/model/userProfile/rank.dart';
import 'package:pool_shark/model/players/player.dart';

import 'package:pool_shark/model/stats/match_stats.dart';

final class LocalUser implements User {
  String _firstName;
  String _displayName;
  String _lastName = '';
  String _nickname = '';

  UserStats _userStats = UserStats();

  @override 
  final int id;

  @override
  final Rank rank = Rank();

  @override
  final History history = History();

  @override
  final Map<User, HeadToHeadRecord> headToHeadRecords = {}; 

  LocalUser(this.id, this._firstName, this._displayName) {
    _checkInvariants();
  }

  // Class invariants & pre conditions

  void _checkInvariants() {
    _checkFirstName(_firstName);
    _checkLastName(_lastName);
    _checkNickname(_nickname);
    _checkDisplayName(_displayName);
  }

  void _checkLength(String value, String varName, int min, int max) {
    value = value.trim();
    assert(
      firstName.length <= max && firstName.length >= min,

      'LocalUser: $varName length is not in valid range. Valid range is \n'
      '$min to $max, $varName = $value\n'
      ' and has length of ${value.length}'
    );
  }

  void _checkFirstName(String firstName) {
    _checkLength(firstName, 'firstname', NameLengths.firstNameMin, NameLengths.firstNameMax);
  }

  void _checkLastName(String lastName) {
    _checkLength(lastName, 'lastName', NameLengths.lastNameMin, NameLengths.lastNameMax);
  }

  void _checkNickname(String nickname) {
    _checkLength(nickname, 'nickname', NameLengths.nicknameMin, NameLengths.nicknameMax);
  }

  void _checkDisplayName(String displayName) {
    _checkLength(displayName, 'displayName', NameLengths.displayNameMin, NameLengths.displayNameMax);
  }

  // Precondition for updateHeadToHead 
  void _checkIsUserPlayer(Player player) {
    assert(
      player is UserPlayer, 
      'LocalUser, RecordSinglesHeadToHead, Can only update headToHeadRecord of \n'
      'non guest players'
    );
  }

  // Precondition for updateHeadToHead
  void _checkIsSameId(int idToCheck) {
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

  @override
  String get firstName => _firstName;

  @override
  String get lastName => _lastName; 

  @override
  String get nickname => _nickname; 

  @override 
  get displayName => _displayName;

  @override 
  UserStats get userStats => _userStats;


  // Setters

  @override
  set firstName(String fistName) {
    _checkFirstName(firstName);
    _firstName = firstName; 
    _checkInvariants();
  }

  @override 
  set lastName(String lastName) {
    _checkLastName(lastName);
    _lastName = lastName;
    _checkInvariants();
  }

  @override 
  set nickname(String nickname) {
    _checkNickname(nickname);
    _nickname = nickname;
    _checkInvariants();
  }

  @override 
  set displayName(String displayName) {
    _checkDisplayName(displayName); 
    _displayName = displayName;
    _checkInvariants();
  }

  // Logic 

  @override 
  void resetUserStats() {
    _userStats = UserStats();
  }

  @override 
  void updateHeadToHeadRecord(MatchStats matchStats) {

    _checkIsUserPlayer(matchStats.statsOf);
    User user = (matchStats.statsOf as UserPlayer).user; 
    _checkIsSameId(user.id);

    _checkIsUserPlayer(matchStats.opponent);
    User opponent = (matchStats.opponent as UserPlayer).user;

    HeadToHeadRecord? record = headToHeadRecords[opponent];
    _checkHeadToHeadRecord(record);
  }

  @override 
  void resetHeadToHeadRecord(User user) {
    _checkRecordReturn(user);
    headToHeadRecords[user] = HeadToHeadRecord(this, user);
  }

    
}
