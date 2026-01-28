import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/userProfile/user.dart';
import 'package:pool_shark/model/userProfile/rank.dart';
import 'package:pool_shark/model/match/team.dart';

final class UserPlayer implements Player {
  final User user;
  final Team team;

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
