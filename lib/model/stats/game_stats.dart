/* 
game_stats.dart 

purpose: Hold stats for a single game of pool

Notes: 
*/

import 'package:pool_shark/model/enums/game/break_result.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';
import 'package:pool_shark/model/stats/shooting_stats.dart';

final class GameStats {

  final GameType gameType;
  final TeamBreaking teamBreaking;

  final ShootingStats shootingStats = ShootingStats();

  Outcome outcome = Outcome.undecided;
  BreakResult _breakResult = BreakResult.notTaken;

  bool isBreakAndRun = false;

  GameStats(this.gameType, this.teamBreaking) {
    // _checkInvariants(); 
  }

  // Getters 

  BreakResult get breakResult => _breakResult;

  // Setters

  set breakResult(BreakResult breakResult) {
    assert(
      teamBreaking != TeamBreaking.undecided,
      "Cannot set break result without having declared which team is breaking"
    );

    _breakResult = breakResult;
  }
 
  // This method allows gets the max pottable balls for a givin game type
  //  static int _maxPottable(GameType gameType) {
  //   switch (gameType) {
  //     case GameType.eightBall:
  //       return MaxPottable.eightBall;
  //     case GameType.nineBall:
  //       return MaxPottable.nineBall;
  //     case GameType.tenBall:
  //       return MaxPottable.tenBall;
  //   }
  // }
  //

  // void _checkInvariants() {}

}

