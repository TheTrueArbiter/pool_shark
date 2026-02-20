/* 
ShootingStats.dart 
Purpose: Hold Shooting stats 
*/

import 'package:pool_shark/utils/stats_calculator.dart';

final class ShootingStats {

  // Shooting variables
  int _potted = 0; 
  int _missed = 0;
  int _fouls = 0; 
  int _safeties = 0;

  ShootingStats() {
    _checkInvariants();
  }

  // Class invariants
  void _checkInvariants() {
    _checkNotNegative(_potted, 'potted');
    _checkNotNegative(_missed, 'missed');
    _checkNotNegative(_fouls, 'fouls');
    _checkNotNegative(_safeties, 'safeties');

  } 

  
  void _checkNotNegative(int value, String variableName) {
      assert(
        value >= 0,
        'ShootinStats: $variableName cannot be negative. Value: $value'
      );
  }

  void _checkAddedValue(int value, String methodName) {
    assert(  
        value > 0,
        'ShootingStats: Cannot add a negative value for $methodName. value: $value'
      );
  }

  // Getters 
  int get potted => _potted;
  int get missed => _missed;
  int get fouls => _fouls;
  int get safeties => _safeties;
  int get totalShots => _potted + _missed + _fouls + _safeties;

  // Shooting rate getters
  double get pottingRate => StatsCalculator.getRate(potted, totalShots);
  double get foulRate => StatsCalculator.getRate(fouls, totalShots);
  double get safetyRate => StatsCalculator.getRate(safeties, totalShots);
  double get missedRate => StatsCalculator.getRate(missed, totalShots);

  void addPotted(int value) {
    _checkAddedValue(value, 'addPotted');
    _potted += value;
    _checkInvariants();
  }

  void addMissed(int value) {
    _checkAddedValue(value, 'addMissed');
    _missed+= value;
    _checkInvariants();
  }

  void addFouls(int value) {
    _checkAddedValue(value, 'addFouls');
    _fouls+= value;
    _checkInvariants();
  }

  void addSafeties(int value) {
    _checkAddedValue(value, 'addSafeties');
    _safeties += value;
    _checkInvariants();
  }
}
