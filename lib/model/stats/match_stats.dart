/* 
match_stats.dart

purpose: Hold stats of a pool match

*/

import 'package:pool_shark/model/enums/break_result.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/stats/breaking_stats.dart';
import 'package:pool_shark/model/stats/multi_game_shooting_stats.dart';
import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/utils/stats_calculator.dart';
import 'package:pool_shark/model/stats/game_stats.dart';
import 'package:pool_shark/model/constants/max_pottable.dart';

final class MatchStats implements MultiGameShootingStats, BreakingStats {
  final GameType gameType;
  // Shooting variables
  int _potted = 0; 
  int _missed = 0;
  int _fouls = 0; 
  int _safeties = 0;

  // Breaking variables
  int _wetBreaks = 0;
  int _dryBreaks = 0;
  int _foulBreaks = 0;

  // Outcome variables 
  int _gamesLost = 0;
  int _gamesWon = 0;
  Outcome matchOutcome = Outcome.undecided;
  

  MatchStats(this.gameType) {
    checkInvariants();
  }

  // class invariants 

  void checkInvariants() {
    checkPotted(_potted);
    checkMissed(_missed);
    checkFouls(_fouls);
    checkSafeties(_safeties);
    checkWetBreaks(_wetBreaks);
    checkDryBreaks(_dryBreaks);
    checkGamesWon(_gamesWon);
    checkGamesLost(_gamesLost);
  }

  void checkPotted(int potted) {
    if (potted < 0) { throw ArgumentError('MatchStats: Potted cannot be negative'); } 

    if (potted > _maxPottable()) {
      throw ArgumentError(
        'MatchStats: potted cannot be greater than the max pottable number of balls\n'
        'potted = $potted, maxPotable = ${_maxPottable()}'
      );
    }
  } 

  void checkMissed(int missed) {
    if (missed < 0) throw ArgumentError('MatchStats: Missed cannot be negative');
  }

  void checkFouls(int fouls) {
    if (fouls < 0) throw ArgumentError('MatchStats: Fouls cannot be negative');
  }

  void checkSafeties(int safeties) {
    if (safeties < 0) throw ArgumentError('MatchStats: safeties cannot be negative');
  }

  void checkWetBreaks(int wetBreaks) {
    if (wetBreaks < 0) throw ArgumentError('MatchStats: wetBreaks cannot be negative');
  }

  void checkDryBreaks(int dryBreaks) {
    if (dryBreaks < 0) throw ArgumentError('MatchStats: dryBreaks cannot be negative');
  }

  void checkFoulBreaks(int foulBreaks) {
    if (foulBreaks < 0) throw ArgumentError('MatchStats: foulBreaks cannot be negative');
  }

  void checkGamesWon (int gamesWon) {
    if (gamesWon < 0) throw ArgumentError('MatchStats: gamesWon cannot be negative');
  }

  void checkGamesLost (int gamesLost) {
    if (gamesLost < 0) throw ArgumentError('MatchStats: gamesWon cannot be negative');
  }
  
  int _maxPottable() {
    switch (gameType) {
      case GameType.eightBall:
        return  gamesPlayed * MaxPottable.eightBall;
      case GameType.nineBall:
        return gamesPlayed * MaxPottable.nineBall;
      case GameType.tenBall:
        return gamesPlayed * MaxPottable.tenBall;
    }
  }

  // Getters 

  // Shooting getters
  @override
  int get potted => _potted;

  @override
  int get missed => _missed;

  @override
  int get fouls => _fouls;

  @override
  int get safeties => _safeties;

  @override 
  int get totalShots => _potted + _missed + _fouls + _safeties;

  // Breaking getters
  @override 
  int get wetBreaks => _wetBreaks;

  @override 
  int get dryBreaks => _dryBreaks;

  @override 
  int get foulBreaks => _foulBreaks;

  @override 
  int get totalBreaks => wetBreaks + dryBreaks + foulBreaks;

  // Game getters
  int get gamesPlayed => gamesWon + gamesLost;
  int get gamesWon => _gamesWon;
  int get gamesLost => _gamesLost;

  // Breaking rate getters
  @override 
  double get wetBreakRate => StatsCalculator.getRate(wetBreaks, totalBreaks);

  @override 
  double get dryBreakRate => StatsCalculator.getRate(dryBreaks, totalBreaks);

  @override 
  double get foulBreakRate => StatsCalculator.getRate(foulBreaks, totalBreaks);

  // Shooting rate getters
  @override
  double get pottingRate => StatsCalculator.getRate(potted, totalShots);

  @override
  double get foulRate => StatsCalculator.getRate(fouls, totalShots);

  @override
  double get safetyRate => StatsCalculator.getRate(safeties, totalShots);

  @override
  double get missedRate => StatsCalculator.getRate(missed, totalShots);

  // Shooting average getters
  @override 
  double get pottingAverage =>  StatsCalculator.getAverage(potted, gamesPlayed);

  @override 
  double get missedAverage => StatsCalculator.getAverage(missed, gamesPlayed);

  @override 
  double get foulAverage => StatsCalculator.getAverage(fouls, gamesPlayed);

  @override 
  double get safetyAverage => StatsCalculator.getAverage(safeties, gamesPlayed);

  // Update match stats
  void updateStats(GameStats gameStats) {
    _potted += gameStats.potted;
    _missed += gameStats.missed;
    _fouls += gameStats.fouls;
    _safeties += gameStats.safeties;

    if (gameStats.breakResult == BreakResult.wet) { _wetBreaks++; }
    else if (gameStats.breakResult == BreakResult.dry) { _dryBreaks++; } 
    else if (gameStats.breakResult == BreakResult.foul) { _foulBreaks++; } 

    if (gameStats.gameResult == Outcome.win) { _gamesWon++; } 
    else if (gameStats.gameResult == Outcome.loss) { _gamesLost++; }

    checkInvariants();

  } 
  
}
