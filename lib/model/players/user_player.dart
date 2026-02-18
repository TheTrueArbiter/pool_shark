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

  @override
  final Team team;

  final User user;

  UserPlayer(this.user, this.team);

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
}
