/* 

game_stats.dart 

purpose: Hold stats for a single game of pool

Notes: 
  1) (Dart newbie) non private instance variables will automatically have getters and 
     setters. final non private instance variables will only have getter
*/
import 'package:pool_shark/model/enums/game/break_result.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/enums/team_breaking.dart';
import 'package:pool_shark/model/stats/shooting_stats.dart';
import 'package:pool_shark/utils/stats_calculator.dart';


final class GameStats implements ShootingStats {
  final int eightBallMaxPottable = 8;
  final int nineBallMaxPottable = 9;
  final int tenBallMaxPottable = 10;

  int _potted = 0;
  int _missed = 0; 
  int _fouls = 0;
  int _safeties = 0;

  final GameType gameType;
  final TeamBreaking teamBreakin;

  Outcome gameResult = Outcome.undecided;
  BreakResult breakResult = BreakResult.notTaken;

  bool isBreakAndRun = false;

  GameStats(this.gameType, this.teamBreakin) {
    checkInvariants(); 
  }
  
  // Getters
  
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

  @override
  double get pottingRate => StatsCalculator.getRate(potted, totalShots);

  @override
  double get foulRate => StatsCalculator.getRate(fouls, totalShots);

  @override
  double get safetyRate => StatsCalculator.getRate(safeties, totalShots);

  @override
  double get missedRate => StatsCalculator.getRate(missed, totalShots);

  int _maxPottable() {
    switch (gameType) {
      case GameType.eightBall:
        return eightBallMaxPottable;
      case GameType.nineBall:
        return nineBallMaxPottable;
      case GameType.tenBall:
        return tenBallMaxPottable;
    }
  }

  // Class invariant methods

  void checkInvariants() {
    checkPotted(potted);
    checkMissed(missed); 
    checkFouls(fouls);
    checkSafeties(safeties);
  }

  void checkPotted(int potted) {
    if (potted < 0) { throw ArgumentError('GameStats: Potted cannot be negative'); } 

    if (potted > _maxPottable()) {
      throw ArgumentError(
        'GameStats: potted cannot be greater than the max pottable number of balls\n'
        'potted = $potted, maxPotable = ${_maxPottable()}'
      );
    }
  } 

  void checkMissed(int missed) {
    if (missed < 0) throw ArgumentError('GameStats: Missed cannot be negative');
  }

  void checkFouls(int fouls) {
    if (fouls < 0) throw ArgumentError('GameStats: Fouls cannot be negative');
  }

  void checkSafeties(int safeties) {
    if (safeties < 0) throw ArgumentError('GameStats: safeties cannot be negative');
  }

  // Setters

  set potted(int potted) {
    checkPotted(potted);
    _potted = potted;
  }

  set missed(int missed) {
    checkMissed(missed);
    _missed = missed;
  }

  set fouls(int fouls) {
    checkFouls(fouls);
    _fouls = fouls;
  }

  set safeties(int safeties) {
    checkSafeties(safeties);
    _safeties = safeties;
  }

}


