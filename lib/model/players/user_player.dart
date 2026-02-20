/* 
user_player.dart 

purpose: hold data for userPlayers, these are players who have a pool shark 
account wheter it be an online one or a local one.

*/
import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/user/user.dart';
import 'package:pool_shark/model/user/records/rank.dart';
import 'package:pool_shark/model/team/team.dart';

final class UserPlayer implements Player {

  final Team? _team = null;

  final User user;

  UserPlayer(this.user);

  @override 
  String get firstName => user.firstName;  

  @override
  String get lastName => user.lastName;

  @override 
  String get nickname => user.nickname;

  @override 
  String get displayName => user.displayName;

  @override 
  Rank get rank => user.rank; 

  @override 
  get team => _team;

  set team(Team team) {
    
  }
}
