import 'package:flutter_test/flutter_test.dart';
import 'package:pool_shark/model/players/user_player.dart';
import 'package:pool_shark/model/team/team.dart';
import 'package:pool_shark/model/tournament/phases/roundRobinPhase/round_robin_phase.dart';
import 'package:pool_shark/model/tournament/phases/roundRobinPhase/scoreboard.dart';
import 'package:pool_shark/model/tournament/phases/roundRobinPhase/group.dart';
import 'package:pool_shark/model/user/local_user.dart';
import 'package:pool_shark/model/players/player.dart';

void main() {

  // Users
  // TODO: ids will need to be changed once id method is made
  LocalUser user1 = LocalUser(id: 'test', firstName: 'andy', displayName: 'andy');
  LocalUser user2 = LocalUser(id: 'test', firstName: 'rob', displayName: 'andy');
  LocalUser user3 = LocalUser(id: 'test', firstName: 'joe', displayName: 'andy');
  LocalUser user4 = LocalUser(id: 'test', firstName: 'steave', displayName: 'andy');

  // Players
  UserPlayer p1 = UserPlayer(user1);
  UserPlayer p2 = UserPlayer(user2);
  UserPlayer p3 = UserPlayer(user3);
  UserPlayer p4 = UserPlayer(user4);

  // list of players 
  List<Player> players1 = [p1];
  List<Player> players2 = [p2];
  List<Player> players3 = [p3];
  List<Player> players4 = [p4];

  // Teams
  Team t1 = Team(name: 't1', players: players1);
  Team t2 = Team(name: 't2', players:  players2);
  Team t3 = Team(name: 't3', players:  players3);
  Team t4 = Team(name: 't4', players: players4);

  group('Roundrobin', () {

    setUp( () {
      // Add code that will run before testing
    });

    test('initializes groups', () {

      List<Team> teams = [t1, t2, t3, t4];
      const int numOfGroups = 2;

      RoundRobinPhase r = RoundRobinPhase(
        numOfGroups: numOfGroups,
        advancingPerGroup: 2,
        matchesPerTeam: 2,
        teams: teams,
        scoreboard: Scoreboard(teams: teams)
      );

      // Check number of groups given was the number of groups created
      expect(r.numOfGroups, numOfGroups);
      
      int minTeamsPerGroup = (r.teams.length / r.numOfGroups).toInt();
      int maxTeamsPerGroup = minTeamsPerGroup + 1;
      List<Team> allTeams = [];

      for (Group g in r.groups) {

        // checks the number of teams per group is the correct amount
        expect(
          g.teams.length,
          anyOf(equals(minTeamsPerGroup), equals(maxTeamsPerGroup)));

        for (Team t in g.teams) {
          allTeams.add(t);
        }
      }

      // Check all teams have a group 
      for (Team t in r.teams) {
        assert(allTeams.contains(t), isTrue);
      }

      // Check for duplicates
      expect(allTeams.length, equals(r.teams.length));
      expect(allTeams.toSet().length, equals(r.teams.length)); 

      
    });


  });


}
