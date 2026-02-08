/* 
game_team.dart

purpose: Hold data for a team of a game (sub team)

Notes:
1) a GameTeam is a team of players from a team which are playing in a game.
   For example a Team of 4 players may be playing a doubles tournement. This class 
   would represent the players 2 players playing in that game along with other related 
   infromation.

2) A GameTeam with 1 player is valid as all Game Objects will be made of two GameTeams

3) allPlayerStats was moved from Game class to this class as it feels like a better 
   fit. But the problem arises when initalizing allPlayerStats. The Game class 
   must call initAllPlayerStats. This has a wierd smell to it.
*/

import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/team/team.dart';
import 'package:pool_shark/model/stats/game_stats.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';

final class GameTeam {
  final List<Player> players;
  final Team team;
  final Map<Player, GameStats> allPlayerStats = {};

  GameTeam(this.players, this.team) {
    _checkInvariants(); 
  }

  @override
  String toString() =>
    'GameTeam(team: ${team.name}, '
    'players: ${players.map((p) => p.firstName).toList()}, '
    'allPlayerStats: ${allPlayerStats.keys.map((p) => p.firstName).toList()})';

  // _initAllPlayerStats
  void initAllPlayerStats(GameType gameType, TeamBreaking teamBreaking) {
    for (Player p in players) {
      GameStats gameStats = GameStats(gameType, teamBreaking);
      allPlayerStats[p] = gameStats;
    }
  }

  // class Invariant 
  void _checkInvariants() {
    assert(players.length == 1 || players.length == 2); 
  }

  // Get a Players games stats
  GameStats? playerStats(Player p) => allPlayerStats[p];

}
