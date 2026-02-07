/*

guest_player.dart

purpose: hold data of guest players, these are players who don't have a 
pool shark account.

*/
import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/user/rank.dart';
import 'package:pool_shark/model/match/team.dart';

final class GuestPlayer implements Player {
  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final String nickname;

  @override
  final String displayName;

  @override
  final Rank rank;

  @override
  final Team team;

  GuestPlayer({
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.displayName,
    required this.rank,
    required this.team,
  });
    
}
