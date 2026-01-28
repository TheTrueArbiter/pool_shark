import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';

enum NineBallScoring implements ScoringSystem {
  apaSystem('Apa 9 ball scoring'),
  outcome('Outcome scoring');

  final String displayName;
  final int apaNineBallPocketBonus = 1;
  final int outcomeWinPoint = 1;
  final int outcomeLossPoint = 0;

  const NineBallScoring(this.displayName);

   void _checkNegative(int value, String variableName) {
      assert(
        value >= 0, 
        'NineBallScoring: $variableName cannot be negative. value: $value'
      );
  }

  @override 
  int calculateGameScore(Outcome outcome, int potted, int opponentPotted) {
    _checkNegative(potted, 'potted');
    _checkNegative(opponentPotted, 'opponentPotted');

    switch(this) {
      case NineBallScoring.apaSystem: 
        return _calculateApaSystem(outcome, potted);
      case NineBallScoring.outcome:
        return _calculateOutcomeScore(outcome); 
    }
  }  

  int _calculateApaSystem(Outcome outcome, int potted) {
    return (outcome == Outcome.win)
      ? potted + apaNineBallPocketBonus 
      : potted;
  }

  int _calculateOutcomeScore(Outcome outcome) {
    return (outcome == Outcome.win) 
      ? outcomeWinPoint 
      : outcomeLossPoint;
  } 
}
