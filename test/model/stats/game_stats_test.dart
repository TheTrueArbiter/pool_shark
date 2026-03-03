import 'package:flutter_test/flutter_test.dart';
import 'package:pool_shark/model/enums/game/break_result.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/stats/game_stats.dart';

void main() {
  group("Game stats test", (){
    group("Getters", () {
      test("GameType getter returns correctly", (){
        final gameType = GameType.eightBall;
        final gameStats = GameStats(gameType, TeamBreaking.team1);
        expect(gameStats.gameType, gameType);
      });

      test("TeamBreaking getter returns correctly", (){
        final teamBreaking = TeamBreaking.team1;
        final gameStats = GameStats(GameType.eightBall, teamBreaking);
        expect(gameStats.teamBreaking, teamBreaking);
      });
    });

    group("Setters", () {

      test("break result assertion triggers", () {
        final stats = GameStats(GameType.tenBall, TeamBreaking.undecided);
        expect( () => stats.breakResult = BreakResult.foul, throwsA(isA<AssertionError>()));

      });
    });
  }); 

}
