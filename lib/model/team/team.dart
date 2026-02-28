/* 
team.dart 
Purpose: hold data for a team

Notes:
1) This team class a team of a match, league or tournement. This is the general
   thought of what a 'team' is in pool. This is NOT a sub team which would be the 
   GameTeam object. see GameTeam for more info

2) _initAllPlayerStats is no longer needed as MatchStats is now required to know 
   the opponen(Player object)

*/

import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/stats/match_stats.dart';
import 'package:pool_shark/model/user/user.dart';

final class Team {

  final String name;
  final User? captain = null;
  final Map<Player, MatchStats> allPlayerStats = {};
  final List<Player> players;
  final List<Player> subs = [];

  Team({
    required this.name,
    required this.players
  }) {
    _initAllPlayerStats();
    _checkInvariants();
  }

  @override
  String toString() {
    return '''
      Team(
      name: $name,
      captain: $captain,
      players: ${players.map((p) => p.firstName).toList()},
      subs: ${subs.map((p) => p.firstName).toList()},
      )
      ''';
  }

  // _initAllPlayerStats
  void _initAllPlayerStats() {
    for (Player p in players) {
      allPlayerStats[p] = MatchStats(p);
    }
  }

  void _checkInvariants() {

    assert(players.isNotEmpty, 'A team cannot have any players. Team must have players to be valid');

    for (Player p in [...players, ...subs]) {
      assert(
        allPlayerStats[p] != null,
        'Team: One of the players on the team is not a key for there coorispounding\n'
        'MatchStats. player name = ${p.firstName}'
      );
    }
  }

  MatchStats? matchStats(Player player) => allPlayerStats[player];

  // TODO: add way to remove and add subs

}
