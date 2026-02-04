import 'package:flutter/material.dart';
import 'package:pool_shark/model/constants/name_lengths.dart';
import 'package:pool_shark/model/stats/user_stats.dart';
import 'package:pool_shark/model/userProfile/head_to_head_record.dart';
import 'package:pool_shark/model/userProfile/history.dart';
import 'package:pool_shark/model/userProfile/user.dart';
import 'package:pool_shark/model/userProfile/rank.dart';

final class LocalUser implements User {
  String _firstName;
  String _displayName;
  String _lastName = '';
  String _nickname = '';

  @override
  final UserStats userStats = UserStats();

  @override
  final Rank rank = Rank();

  @override
  final History history = History();

  final Map<User, HeadToHeadRecord> headToHeadRecords = {}; 

  LocalUser(this._firstName, this._displayName) {
    _checkInvariants();
  }

  // Class invariants

  void _checkInvariants() {

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

  void checkFirstName(String firstName) {
    _checkLength(firstName, 'firstname', NameLengths.firstNameMin, NameLengths.firstNameMax);
  }

  void checkLastName(String lastName) {
    _checkLength(lastName, 'lastName', NameLengths.lastNameMin, NameLengths.lastNameMax);
  }

  void checkNickname(String nickname) {
    _checkLength(nickname, 'nickname', NameLengths.nicknameMin, NameLengths.nicknameMax);
  }

  void checkDisplayName(String displayName) {
    _checkLength(displayName, 'displayName', NameLengths.displayNameMin, NameLengths.displayNameMax);
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

  // Setters

}
