import 'package:flutter_test/flutter_test.dart';
import 'package:pool_shark/model/enums/game/break_result.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/outcome.dart';
import 'package:pool_shark/model/players/guest_player.dart';
import 'package:pool_shark/model/stats/game_stats.dart';
import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/stats/match_stats.dart';
void main() {

  late MatchStats matchStats;
  late Player player;
  final expectedWins = 3; 
  final expectedLosses = 2; 
  final expectedGamesPlayed = 5; 
  final expectedBreakAndRuns = 2;
  final expectedWetBreaks = 2;
  final expectedDryBreaks = 1;
  final expectedFoulBreaks = 1;
  

  setUp(() {
    player = GuestPlayer(
      firstName: 'Andy',
      lastName: 'kool guy',
      nickname: 'the very',
      displayName: 'kool guy andy',
      rank: null,
      team: null
    );

    matchStats = MatchStats(player);

    final gameStats_1 = GameStats(GameType.eightBall, TeamBreaking.team1);
    final gameStats_2 = GameStats(GameType.eightBall, TeamBreaking.team2);
    final gameStats_3 = GameStats(GameType.eightBall, TeamBreaking.team1);
    final gameStats_4 = GameStats(GameType.eightBall, TeamBreaking.team1);
    final gameStats_5 = GameStats(GameType.eightBall, TeamBreaking.team1);

    gameStats_1.breakResult = BreakResult.wet;
    gameStats_2.breakResult = BreakResult.notBreaking;
    gameStats_3.breakResult = BreakResult.wet;
    gameStats_4.breakResult = BreakResult.dry;
    gameStats_5.breakResult = BreakResult.foul;

    gameStats_1.outcome = Outcome.win;
    gameStats_2.outcome = Outcome.win;
    gameStats_3.outcome = Outcome.loss;
    gameStats_4.outcome = Outcome.win;
    gameStats_5.outcome = Outcome.loss;

    // Adds up to 29
    gameStats_1.shootingStats.addPotted(7);
    gameStats_2.shootingStats.addPotted(6);
    gameStats_3.shootingStats.addPotted(3);
    gameStats_4.shootingStats.addPotted(5);
    gameStats_5.shootingStats.addPotted(8);

    // Adds up 7
    gameStats_1.shootingStats.addMissed(1);
    gameStats_2.shootingStats.addMissed(3);
    gameStats_3.shootingStats.addMissed(2);
    gameStats_4.shootingStats.addMissed(1);
    gameStats_5.shootingStats.addMissed(0);

    // Adds up to 4
    gameStats_1.shootingStats.addFouls(0);
    gameStats_2.shootingStats.addFouls(1);
    gameStats_3.shootingStats.addFouls(0);
    gameStats_4.shootingStats.addFouls(3);
    gameStats_5.shootingStats.addFouls(0);

    // Adds up to 7
    gameStats_1.shootingStats.addSafeties(1);
    gameStats_2.shootingStats.addSafeties(3);
    gameStats_3.shootingStats.addSafeties(0);
    gameStats_4.shootingStats.addSafeties(3);
    gameStats_5.shootingStats.addSafeties(0);

    gameStats_1.isBreakAndRun = true;
    gameStats_2.isBreakAndRun = true;

    matchStats.updateStats(gameStats_1);
    matchStats.updateStats(gameStats_2);
    matchStats.updateStats(gameStats_3);
    matchStats.updateStats(gameStats_4);
    matchStats.updateStats(gameStats_5);


  });

  group("MatchStats testing:", () {

    // Nothing to test here atm
    // group("Class invariants & preconditions:", () {
    //   
    // });

    group("set/get opponent: ", () {
      test("Assertion triggers when passed empty list for opponent param.", () {
        List<Player> opps = [];
        expect( () => matchStats.opponent = opps, throwsA(isA<AssertionError>()));
      });

      test("Assertion triggers player whomes matchStats belongs to is on the opponent team.", () {
        List<Player> opps = [player];
        expect( () => matchStats.opponent = opps, throwsA(isA<AssertionError>()));
      });

      test("Get opponent return correctly.", () {
        
        Player other = GuestPlayer(
          firstName: 'Ron',
          lastName: 'crazy guy',
          nickname: 'the insane',
          displayName: 'crazy',
          rank: null,
          team: null 
        );

        List<Player> opps = [other];
        matchStats.opponent = opps;
        expect(matchStats.opponent, opps);

      });

    });

    group("UpdateStats works correctly:", () {
      test("gamePlayed returns expected value", () {
        expect(matchStats.gamesPlayed, expectedGamesPlayed); 
      });
        
      test("gameWon returns expected value", () {
        expect(matchStats.gamesWon, expectedWins); 
      });   

      test("gameLost returns expected value", () {
        expect(matchStats.gamesLost, expectedLosses); 
      });

      test("breakAndRuns returns expect value", () {
        expect(matchStats.breakAndRuns, expectedBreakAndRuns);
      });

      test("Breaking stats wet breaks updated correctly", () {
        expect(matchStats.breakingStats.wetBreaks, expectedWetBreaks);
      });

      test("Breaking stats dry breaks updated correctly", () {
        expect(matchStats.breakingStats.dryBreaks, expectedDryBreaks);
      });

      test("Breaking stats foul breaks updated correctly", () {
        expect(matchStats.breakingStats.foulBreaks, expectedFoulBreaks);
      });

      test("UpdateStats fails when passed a game that is not finished", () {
        final gameStats = GameStats(GameType.eightBall, TeamBreaking.team1);
        gameStats.outcome = Outcome.undecided;
        expect( () => matchStats.updateStats(gameStats), throwsA(isA<AssertionError>()));
      });

    });

    group('Shooting averages', () {

      test('pottingAverage is calculated correctly', () {
        // Total potted = 7 + 6 + 3 + 5 + 8 = 29
        // Games played = 5
        // 29 / 5 = 5.8
        expect(matchStats.pottingAverage, closeTo(5.8, 0.0001));
      });

      test('missedAverage is calculated correctly', () {
        // Total missed = 1 + 3 + 2 + 1 + 0 = 7
        // Games played = 5
        // 7 / 5 = 1.4
        expect(matchStats.missedAverage, closeTo(1.4, 0.0001));
      });

      test('foulAverage is calculated correctly', () {
        // Total fouls = 0 + 1 + 0 + 3 + 0 = 4
        // Games played = 5
        // 4 / 5 = 0.8
        expect(matchStats.foulAverage, closeTo(0.8, 0.0001));
      });

      test('safetyAverage is calculated correctly', () {
        // Total safeties = 1 + 3 + 0 + 3 + 0 = 7
        // Games played = 5
        // 7 / 5 = 1.4
        expect(matchStats.safetyAverage, closeTo(1.4, 0.0001));
      });

    });
  });

}
