import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';
import 'package:pool_shark/model/stats/game_stats.dart';

enum EightBallScoring implements ScoringSystem {
  tenPoint('10 point system'),
  seventeenPoint('17 point system'),
  outcome('Outcome System');

  final String displayName;

  final int tenPointMaxScore = 10; 
  final int seventeenPointMaxScore = 17; 
  final int outcomeLostScore = 0;
  final int outcomeWonScore = 1;

  const EightBallScoring(this.displayName);

  void _checkGameStats(GameStats? gameStats) {
    assert(gameStats == null, 'EightBallScoring: gameStats cannot be null');
  }


  @override 
  int calculateGameScore(GameStats? gameStats, int opponentPotted) {
    _checkGameStats(gameStats);

    switch(this) {
      case EightBallScoring.tenPoint: 
        return _calculateTenPointScore(gameStats);
      case EightBallScoring.seventeenPoint: 
        return _calculateSevteenPointScore(gameStats, opponentPotted);
      case EightBallScoring.outcome: 
        return _calculateOutcomeScore(gameStats);
    }
  }  

  int _calculateTenPointScore(GameStats? gameStats) {
    if (gameStats == null) {
      throw ArgumentError('GameStats cannot be null');
    }

    return (gameStats.outcome == Outcome.win) 
      ? tenPointMaxScore
      : gameStats.shootingStats.potted;
  }

  int _calculateOutcomeScore(GameStats? gameStats) {
    if (gameStats == null) {
      throw ArgumentError('GameStats cannot be nulll');
    }

    return (gameStats.outcome == Outcome.win) 
      ? outcomeWonScore 
      : outcomeLostScore;  
  }  

  int _calculateSevteenPointScore(GameStats? gameStats, int opponentPotted) {
    if (gameStats == null) {
      throw ArgumentError('GameStats cannot be null');
    }

    return (gameStats.outcome == Outcome.win)
      ? seventeenPointMaxScore - opponentPotted
      : gameStats.shootingStats.potted;
    
  }

}
