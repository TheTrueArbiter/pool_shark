/* 
game_stats.dart 

purpose: Hold stats for a single game of pool

Notes: 
  1) (Dart newbie) non private instance variables will automatically have getters and 
     setters. final non private instance variables will only have getter
*/
import 'package:pool_shark/model/constants/max_pottable.dart';
import 'package:pool_shark/model/enums/game/break_result.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';
import 'package:pool_shark/model/stats/shooting_stats.dart';

final class GameStats {

  final GameType gameType;
  final TeamBreaking teamBreakin;

  final ShootingStats shootingStats = ShootingStats();

  Outcome gameResult = Outcome.undecided;
  BreakResult breakResult = BreakResult.notTaken;

  bool isBreakAndRun = false;

  GameStats(this.gameType, this.teamBreakin) {
    

    _checkInvariants(); 
  }
  
   static int _maxPottable(GameType gameType) {
    switch (gameType) {
      case GameType.eightBall:
        return MaxPottable.eightBall;
      case GameType.nineBall:
        return MaxPottable.nineBall;
      case GameType.tenBall:
        return MaxPottable.tenBall;
    }
  }


  void _checkInvariants() {}

}

