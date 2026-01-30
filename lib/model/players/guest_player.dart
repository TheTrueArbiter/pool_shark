import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/userProfile/rank.dart';
import 'package:pool_shark/model/match/team.dart';

final class GuestPlayer implements Player {
  final String firstName;
  final String lastName;
  final String nickname;
  final String displayName;

  final Rank rank;
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
