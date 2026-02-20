import 'package:pool_shark/model/tournament/phases/roundRobinPhase/scoreboard_entry.dart';
import 'package:pool_shark/model/team/team.dart';
import 'package:pool_shark/model/enums/outcome.dart';

final class Scoreboard {
  final Map<Team, ScoreboardEntry> entries = {};
  final List<Team> teams; 

  Scoreboard({
    required this.teams
  }) {

    initEntries(teams);
    _checkInvariants();
  }

  void initEntries(List<Team> teams) {
    for (Team t in teams) {
      entries[t] = ScoreboardEntry(team: t);
    } 
  }

  // Class invariants

  void _checkInvariants() {
    assert(teams.length >= 2, 'Must have at least 2 teams, current is ${teams.length}');
  }

  // Logic 
  List<ScoreboardEntry> get standings {
    List<ScoreboardEntry> standings = [];

    for (Team t in teams) {
      ScoreboardEntry? entry = entries[t];

      if (entry == null) { 
        throw StateError('Entry was null for team: $t'); 
      }

     standings.add(entry); 
    }

    standings.sort((a, b) => a.matchesWon.compareTo(b.matchesWon));

    return standings;
  }

  void recordResult(Team team, Outcome outcome) {
    ScoreboardEntry? entry = entries[team];

    if (entry == null) {
      throw StateError('entry was null for team $team'); 
    } 

    if (outcome == Outcome.win) {
      entry.matchesWon += 1;
    }
    else if (outcome == Outcome.loss) {
      entry.matchesLost += 1;
    }

  }

}
