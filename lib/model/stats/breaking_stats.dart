/*

breaking_stats.dart 
Purpose: Interface for breaking stats.

*/
abstract class BreakingStats {
  // General Breaking stats 
  int get totalBreaks;
  int get wetBreaks;
  int get dryBreaks;
  int get foulBreaks;

  // Breaking rates
  int get wetBreakRate;
  int get dryBreakRate;
  int get foulBreakRate;

  // Breaking averages 
  double get pottedOnBreakAvg;
}
