/* 
eight_ball_scoring.dart 

purpose:
Enum class for eight ball scoring which has the ability to calculate 
eight ball scores
*/
import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';

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


  void _checkNegative(int value, String variableName) {
      assert(
        value >= 0, 
        'EightBallScoring: $variableName cannot be negative. value: $value'
      );
  } 

  @override 
  int calculateGameScore(Outcome outcome, int potted, int opponentPotted) {
    _checkNegative(potted, 'potted');
    _checkNegative(opponentPotted, 'opponentPotted');

    switch(this) {
      case EightBallScoring.tenPoint: 
        return _calculateTenPointScore(outcome, potted);
      case EightBallScoring.seventeenPoint: 
        return _calculateSevteenPointScore(outcome, potted, opponentPotted);
      case EightBallScoring.outcome: 
        return _calculateOutcomeScore(outcome);
    }
  }  

  int _calculateTenPointScore(Outcome outcome, int potted) {
    return (outcome == Outcome.win) 
      ? tenPointMaxScore
      : potted; 
  }

  int _calculateOutcomeScore(Outcome outcome) {
    return (outcome == Outcome.win) 
      ? outcomeWonScore 
      : outcomeLostScore;  
  }  

  int _calculateSevteenPointScore(Outcome outcome, int potted, int opponentPotted) {
    return (outcome == Outcome.win)
      ? seventeenPointMaxScore - opponentPotted
      : potted; 
  }

}
