/* 

tournament_settings.dart 

purpose: hold data for tournament settings 

notes:
1) Class is very 'dumb' in the sense that it only holds data and will preform 
   no logic.

2) _numOfTables will be the only instance variable that can chanage throughout 
   a tournament. As tables more or less tables may become availble as a tournnment 
   goes on.
*/

import 'package:pool_shark/model/enums/tournament/elimination_type.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/match/breaking_format.dart';
import 'package:pool_shark/model/enums/match/match_scoring.dart';
import 'package:pool_shark/model/enums/match/match_type.dart';
import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';
import 'package:pool_shark/model/tournament/prize_money.dart';

final class TournamentSettings {
  final GameType gametype;
  final MatchType matchType;

  final MatchScoring matchScoring;
  final ScoringSystem? scoringSystem;

  final BreakingFormat breakingFormat;
  final EliminationType eliminationType;
  final PrizeMoney prizeMoney;
  
  final bool isHandicap; 
  final bool isRoundRobin; 
  final bool isSeeded;

  final int numberOfTeams;
  final int teamSizeLimit;
  final int subLimit;

  final List<int> raceLimitPerRound;

  int _numOfTables;

  TournamentSettings({
    required this.gametype,
    required this.matchType, 

    required this.matchScoring, 
    required this.scoringSystem,

    required this.breakingFormat,
    required this.eliminationType,
    required this.prizeMoney,

    required this.isHandicap,
    required this.isRoundRobin,
    required this.isSeeded,
    
    required this.numberOfTeams,
    required this.teamSizeLimit,
    required this.subLimit,

    required this.raceLimitPerRound,

    required int numOfTables 

  }) : _numOfTables = numOfTables {

    _checkInvariants();
  } 

  // Class invariants

  void _checkInvariants() {
    _checkNumOfTables(_numOfTables);

  }

  void _checkNumOfTables(int numOfTables) {
    assert(numOfTables >= 1, 'numOfTables must be 1 or greater, numOfTables = $numOfTables');

  }

  // Getters 

  int get numOfTables => _numOfTables;

  // Setters 

  set numOfTables(int numOfTables) {
    _checkNumOfTables(numOfTables);
    _numOfTables = numOfTables;
  }

}
