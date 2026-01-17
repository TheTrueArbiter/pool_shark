import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';
import 'package:pool_shark/model/stats/game_stats.dart';

enum NineBallScoring implements ScoringSystem {
  apaSystem('Apa 9 ball scoring'),
  outcome('Outcome scoring');

  final String displayName;
  final int apaNineBallPocketBonus = 1;
  final int outcomeWinPoint = 1;
  final int outcomeLossPoint = 0;

  const NineBallScoring(this.displayName);

  void _checkGameStats(GameStats? gameStats) {
    assert(gameStats == null, 'NineBallScoring: gameStats cannot be null');
  }


  @override 
  int calculateGameScore(GameStats? gameStats, int opponentPotted) {
    _checkGameStats(gameStats);

    switch(this) {
      case NineBallScoring.apaSystem: 
        return _calculateApaSystem(gameStats);
      case NineBallScoring.outcome:
        return _calculateOutcomeScore(gameStats); 
    }
  }  

  int _calculateApaSystem(GameStats? gameStats) {
    if (gameStats == null) {
      throw ArgumentError('GameStats cannot be null');
    }

    return (gameStats.outcome == Outcome.win)
      ? gameStats.shootingStats.potted + apaNineBallPocketBonus 
      : gameStats.shootingStats.potted;
  }

  int _calculateOutcomeScore(GameStats? gameStats) {
    if (gameStats == null) {
      throw ArgumentError('GameStats cannot be null');
    }

    return (gameStats.outcome == Outcome.win) 
      ? outcomeWinPoint 
      : outcomeLossPoint;
  } 
}
