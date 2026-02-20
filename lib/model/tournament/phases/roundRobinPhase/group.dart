import 'package:pool_shark/model/constants/name_lengths.dart';
import 'package:pool_shark/model/tournament/phases/roundRobinPhase/scoreboard.dart';
import 'package:pool_shark/model/team/team.dart';

final class Group {
  final int numberOfTeamsMin = 2;
  final String name;
  final List<Team> teams;
  final List<Match> matches = [];
  final Scoreboard scoreboard;

  bool isAllMatchesPlayed = false;

  Group({
    required this.name, 
    required this.teams, 
    required this.scoreboard

  }) {
    _checkInvariants();
  }

  // Class invariants

  void _checkInvariants() {
    assert(name.isNotEmpty, 'Name of tournament group must be at least 1 character long');
    
    assert(
      name.length <= NameLengths.groupNameMax,
      'Name of tournament group must be have less than or equal to ${NameLengths.groupNameMax}'
      '\n characters long. name = $name, length = ${name.length}'
    );

    assert(
      teams.length >= numberOfTeamsMin,
      'A minimum of 2 teams per gourp is needed. There curently ${teams.length} teams'
    );
  }


  void generateMatches() {
    // TODO: implement this  
  }

}
