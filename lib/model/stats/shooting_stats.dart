/* 
ShootingStats.dart 
Purpose: Interface for single game shooting stats.
*/

// import 'package:pool_shark/model/stats/shooting_stats.dart';
abstract class ShootingStats {
    // General shooting stats
    int get potted;
    int get missed;
    int get fouls; 
    int get safeties;
    
    // Shooting rates
    double get pottingRate;
    double get missedRate;
    double get foulRate; 
    double get safetyRate;
}
