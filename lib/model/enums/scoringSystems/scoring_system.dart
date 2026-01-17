import 'package:pool_shark/model/stats/game_stats.dart';

abstract class ScoringSystem {
  // String get displayName;
  int calculateGameScore(GameStats? gameStats, int opponentPotted);
}
