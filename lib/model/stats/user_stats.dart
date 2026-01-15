/* 
user_stats.dart

purpose hold accumulated pool stats of a user 
*/

import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/stats/breaking_stats.dart';
import 'package:pool_shark/model/stats/match_stats.dart';
import 'package:pool_shark/model/stats/shooting_stats.dart';
import 'package:pool_shark/utils/stats_calculator.dart';

final class UserStats {

  final ShootingStats shootingStats = ShootingStats(); 
  final BreakingStats breakingStats = BreakingStats();

  // Outcome variables 
  int _gamesLost = 0;
  int _gamesWon = 0;

  int _matchesWon = 0;
  int _matchesLost = 0;

  // Other
  int _breakAndRuns = 0;
  double moneyWon = 0;

  UserStats() {
    checkInvariants();
  }

  void checkInvariants() {
    _checkNotNegative(_gamesWon, 'gamesWon');
    _checkNotNegative(_gamesLost, 'gamesLost');
    _checkNotNegative(_matchesWon, 'matchesLost');
    _checkNotNegative(_matchesLost, 'matchesLost');
    _checkNotNegative(_breakAndRuns, 'breakAndRuns');
    _checkMoneyWon();
  }

  void _checkNotNegative(int value, String variableName) {
    assert(
      value > 0,
      'UserStats: $variableName cannot be negative. Value: $value'
    );
  }

  void _checkMoneyWon() {
    assert(
      moneyWon > 0,
      'ShootinStats: moneyWon cannot be negative. Value: $moneyWon'
    );
  }

  // Game getters
  int get gamesPlayed => gamesWon + gamesLost;
  int get gamesWon => _gamesWon;
  int get gamesLost => _gamesLost;

  double get gameWinRate => StatsCalculator.getRate(_gamesWon, gamesPlayed);

  // Match getters 
  int get matchesLost => _matchesLost; 
  int get matchesWon => _matchesWon; 
  int get matchesPLayed => _matchesWon + _matchesLost;

  double get matchWinRate => StatsCalculator.getRate(_matchesWon, matchesPLayed);

  // Update stats 
  void updateStats(MatchStats matchStats) {
    ShootingStats matchShooting = matchStats.shootingStats;
    BreakingStats matchBreaking = matchStats.breakingStats;

    shootingStats.addPotted(matchShooting.potted);
    shootingStats.addMissed(matchShooting.missed);
    shootingStats.addFouls(matchShooting.fouls);
    shootingStats.addSafeties(matchShooting.safeties);

    breakingStats.addWetBreaks(matchBreaking.wetBreaks);
    breakingStats.addDryBreaks(matchBreaking.dryBreaks);
    breakingStats.addFoulBreaks(matchBreaking.foulBreaks);

    _gamesWon += matchStats.gamesWon;
    _gamesLost += matchStats.gamesLost;

    _breakAndRuns += matchStats.breakAndRuns;

    if (matchStats.matchOutcome == Outcome.win) { _matchesWon++ ;}
    else if (matchStats.matchOutcome == Outcome.loss) { _matchesLost++; }
  }
}
