/* 
match_stats.dart

purpose: Hold stats of a pool match

*/

import 'package:pool_shark/model/enums/game/break_result.dart';
import 'package:pool_shark/model/stats/breaking_stats.dart';
import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/stats/shooting_stats.dart';
import 'package:pool_shark/utils/stats_calculator.dart';
import 'package:pool_shark/model/stats/game_stats.dart';

final class MatchStats {

  final ShootingStats shootingStats = ShootingStats();
  final BreakingStats breakingStats = BreakingStats();

  // Outcome variables 
  int _gamesLost = 0;
  int _gamesWon = 0;
  Outcome matchOutcome = Outcome.undecided;

  int _breakAndRuns = 0;

  MatchStats() {
    checkInvariants();
  }

  // class invariants 
  void checkInvariants() {
    _checkNotNegative(_gamesLost, 'gamesLost');
    _checkNotNegative(_gamesWon, 'gamesWon');
    _checkNotNegative(_breakAndRuns, 'breakAndRuns');
  }


  void _checkNotNegative(int value, String variableName) {
      assert(
        value > 0,
        'MatchStats: $variableName cannot be negative. Value: $value'
      );
  }
  
  // Getters 

  // Game getters
  int get gamesPlayed => gamesWon + gamesLost;
  int get gamesWon => _gamesWon;
  int get gamesLost => _gamesLost;

  // Shooting average getters
  double get pottingAverage =>  StatsCalculator.getAverage(shootingStats.potted, gamesPlayed);
  double get missedAverage => StatsCalculator.getAverage(shootingStats.missed, gamesPlayed);
  double get foulAverage => StatsCalculator.getAverage(shootingStats.fouls, gamesPlayed);
  double get safetyAverage => StatsCalculator.getAverage(shootingStats.safeties, gamesPlayed);

  // BreakAndRuns getter 
  int get breakAndRuns => _breakAndRuns;
  double get breakAndRunRate => StatsCalculator.getRate(_breakAndRuns, gamesPlayed); 

  // Update match stats
  // Meant for updateing 1 game at a time of match. This enables the ability 
  // to have stats be checked throughout the match
  void updateStats(GameStats gameStats) {
    ShootingStats gameShootngStats = gameStats.shootingStats;
    
    shootingStats.addPotted(gameShootngStats.potted); 
    shootingStats.addMissed(gameShootngStats.missed); 
    shootingStats.addFouls(gameShootngStats.fouls); 
    shootingStats.addSafeties(gameShootngStats.safeties); 

    if (gameStats.breakResult == BreakResult.wet) { breakingStats.addWetBreaks(1); }
    else if (gameStats.breakResult == BreakResult.dry) { breakingStats.addDryBreaks(1);} 
    else if (gameStats.breakResult == BreakResult.foul) { breakingStats.addFoulBreaks(1); } 

    if (gameStats.outcome == Outcome.win) { _gamesWon++; } 
    else if (gameStats.outcome == Outcome.loss) { _gamesLost++; }

    if (gameStats.isBreakAndRun) { _breakAndRuns++; }

    checkInvariants();

  } 
  
}
