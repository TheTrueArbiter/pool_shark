import 'package:pool_shark/model/team/team.dart';

final class ScoreboardEntry {
  
  final Team team;

  int matchesWon = 0;
  int matchesLost = 0;

  ScoreboardEntry({
    required this.team
  });

  int get gamesPlayed => matchesWon + matchesLost;

}
