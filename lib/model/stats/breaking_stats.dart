/*
breaking_stats.dart 
Purpose: Hold breaking stats

*/

import 'package:pool_shark/utils/stats_calculator.dart';

final class BreakingStats {

  int _wetBreaks = 0;
  int _dryBreaks = 0;
  int _foulBreaks = 0;

  BreakingStats() {
    _checkInvariants();
  }

  // Class invariants 

  void _checkInvariants() { 
    _checkNotNegative(_wetBreaks, 'wetBreaks');
    _checkNotNegative(_dryBreaks, 'dryBreaks');
    _checkNotNegative(_foulBreaks, 'foulBreaks');
  }
  
  void _checkNotNegative(int value, String variableName) {
     assert(
      value > 0,
      'ShootinStats: $variableName cannot be negative. Value: $value'
    );
  }

  // Pre conditions

  void _checkIncrement(int value, String type) {
    assert(
      value > 0,
      'BreakingStats: Cannot increment $type by negative amount'
    ); 
  }

  // Getters

  // Breaking getters
  int get wetBreaks => _wetBreaks;
  int get dryBreaks => _dryBreaks;
  int get foulBreaks => _foulBreaks;
  int get totalBreaks => wetBreaks + dryBreaks + foulBreaks;

  // Breaking rate getters
  double get wetBreakRate => StatsCalculator.getRate(wetBreaks, totalBreaks);
  double get dryBreakRate => StatsCalculator.getRate(dryBreaks, totalBreaks);
  double get foulBreakRate => StatsCalculator.getRate(foulBreaks, totalBreaks);

  // Increments 

  void addWetBreaks(int value) {
    _checkIncrement(value, 'wetBreaks');
    _wetBreaks += value; 
    _checkInvariants();
  }

  void addDryBreaks(int value) {
    _checkIncrement(value, 'dryBreaks');
    _dryBreaks += value; 
    _checkInvariants();
  } 

  void addFoulBreaks(int value) {
    _checkIncrement(value, 'foulBreaks');
    _foulBreaks += value; 
    _checkInvariants();
  } 
}
