import 'package:pool_shark/model/tournament/phases/roundRobinPhase/scoreboard.dart';
import 'package:pool_shark/model/tournament/phases/roundRobinPhase/group.dart';
import 'package:pool_shark/model/team/team.dart';
import 'dart:math';

const maxGroupsAllowed = 8;

const maxTeamsAllowed = 128;
const minTeamsAllowed = 2;

final class RoundRobinPhase {
  final int numOfGroups;
  final int advancingPerGroup;
  final int matchesPerTeam;

  final List<Team> teams;
  final List<Group> groups = [];
  final Scoreboard scoreboard;

  bool isComplete = false;

  RoundRobinPhase({
    required this.numOfGroups,
    required this.advancingPerGroup,
    required this.matchesPerTeam,
    required this.teams,
    required this.scoreboard
  }) {
    _initGroups();
    _checkInvariants();
  }

  void _checkInvariants() {
    assert(numOfGroups >= 1, 'numOfGroups must be greater or equal to 1. numOfGroups = $numOfGroups');

    assert(
      advancingPerGroup >= 1,
      'adadvancingPerGroup must be greater or equal to 1. advancingPerGroup = $advancingPerGroup'
    ); 

    assert(
      numOfGroups <= maxGroupsAllowed,
      'maximum groups allowed is $maxGroupsAllowed, there is currently $numOfGroups'
    );

    assert(
      groups.length == numOfGroups, 
      'The number of groups in groups list is not the same as the number groups specified.'
      '\n gourps.length = ${groups.length}, numOfGroups = $numOfGroups'
    ); 

    assert(
      matchesPerTeam >= 1,
      'matchesPerTeam must be greater or equal to 1. matchesPerTeam: $matchesPerTeam'
    ); 

    assert (
      teams.length >= minTeamsAllowed,
      'There must be at least two teams in round robin phase. there is currently ${teams.length}'
    );

    assert(
      teams.length <= maxTeamsAllowed, 
      'At most there can be $maxTeamsAllowed teams, there is currently ${teams.length}'
    );
  }


  void _initGroups() {
    Random random = Random();
    List<String> defaultGroupNames = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    List<Team> notChosen = List.from(teams);

    int teamsPerGroup = (teams.length / numOfGroups).toInt();
    int teamsLeftOver = teams.length % numOfGroups;


    // Assign teams to random groups
    for (int i = 0; i < numOfGroups; i++) {
      List<Team> teamsInGroup = [];

      for (int j = 0; j < teamsPerGroup; j++) {
        int index = random.nextInt(notChosen.length);
        Team team = notChosen[index];
        teamsInGroup.add(team);
        notChosen.remove(team);
      }
        
      Scoreboard groupScoreBoard = Scoreboard(teams: teamsInGroup);

      Group group = Group(
        name: defaultGroupNames[i],
        teams: teamsInGroup,
        scoreboard: groupScoreBoard 
      );

      groups.add(group);

    }

    List<int> groupIndexs = List.generate(groups.length, (index) => index);

    // Add remaining groups to a random group
    for (int k = 0; k < teamsLeftOver; k++) {
      int randomGroupIndex = random.nextInt(groupIndexs.length);
      Group group = groups[randomGroupIndex];
      Team team = notChosen[k];
      group.teams.add(team);
      group.scoreboard.teams.add(team);
      groupIndexs.remove(groupIndexs[randomGroupIndex]);
    }

  }
}
