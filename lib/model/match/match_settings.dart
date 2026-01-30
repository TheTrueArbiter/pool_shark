import 'package:pool_shark/model/enums/match/match_context.dart';
import 'package:pool_shark/model/enums/match/match_scoring.dart';
import 'package:pool_shark/model/enums/match/match_type.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/match/breaking_format.dart';
import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';

const noWinTargetFlag = -1; 
final class MatchSettings {

  final MatchContext matchContext;
  final MatchType matchType;
  final MatchScoring matchScoring;
  final GameType gameType;
  final BreakingFormat breakingFormat;
  final bool isHandicap;
  
  final int team1WinTarget;
  final int team2WinTarget; 

  final ScoringSystem? scoringSystem;

   MatchSettings({
    required this.matchContext,
    required this.matchType,
    required this.matchScoring,
    required this.gameType,
    required this.breakingFormat,
    required this.team1WinTarget,
    required this.team2WinTarget, 
    required this.isHandicap,
    required this.scoringSystem
  }) {
    _checkInvariants();
  }  

  @override
  String toString() {
  return '''
  MatchSettings(
    matchContext: $matchContext,
    matchType: $matchType,
    matchScoring: $matchScoring,
    gameType: $gameType,
    breakingFormat: $breakingFormat,
    isHandicap: $isHandicap,
    team1WinTarget: $team1WinTarget,
    team2WinTarget: $team2WinTarget,
    scoringSystem: ${scoringSystem ?? 'none'}
  )
  ''';
  }


  void _checkInvariants() {
    _checkTeamWinTarget(team1WinTarget, 1);
    _checkTeamWinTarget(team1WinTarget, 2);
    _checkScoringSystem();
  }

  void _checkTeamWinTarget(int winTarget, int teamNumber) {
    assert( 
      winTarget == noWinTargetFlag || winTarget >= 1,
      'MatchSettings: team $teamNumber has a win target that is not greater than 1\n'
      'or is not the value of noWinTargetFlag ($noWinTargetFlag). winTarget = $winTarget'
    );
  }

  void _checkScoringSystem() {
    assert(
      matchScoring == MatchScoring.scoring && scoringSystem != null,
      'MatchSettings: MatchScoring is set to scoring and scoring system is null when it shoudld not be'
    );

    assert(
      matchScoring == MatchScoring.wins && scoringSystem == null,
      'MatchSettings: Matchscoing is set to wins so scoring system should be null, but isnt'
    );
  }

  bool get isWinTarget => team1WinTarget == -1 && team2WinTarget == -1;

  
}
