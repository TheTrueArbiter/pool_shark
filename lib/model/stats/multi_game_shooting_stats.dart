/* 
multi_game_shooting_stats.dart
purpose: Interface for multi game shooting stats

*/
import 'package:pool_shark/model/stats/shooting_stats.dart';

abstract class MultiGameShootingStats extends ShootingStats {

  // Shooting 
  double get pottingAverage; 
  double get missedAverage;
  double get foulAverage; 
  double get safetyAverage;

}
