/* 
game.dart

purpose: Hold data for a game of pool

Notes:
1) _playerBreaking, _winner, _gameTimeSeconds are made private so setters can be 
  denfinded as they need to have preconditons, rather than using default setters 

2) This class updated as a Game goes on 

3) GameID -> gameId is the number of which game has been played within a match. 
   For example the first game played will have an ID of 1, and the second an ID 
   of 2.

*/
import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';
import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/stats/game_stats.dart';
import 'package:pool_shark/model/match/game_team.dart';
import 'package:pool_shark/model/enums/game_type.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';
import 'package:pool_shark/model/enums/outcome.dart';



final class Game {
  final noScoreSystemFlag = - 1;
  final GameType gameType;
  final GameTeam team1; 
  final GameTeam team2;
  final ScoringSystem? scoringSystem;
  final int gameId;

  TeamBreaking teamBreaking;
  bool isGameFinised = false;
  bool isBeingPlayed = false;

  Player? _playerBreaking;
  GameTeam? _winner;

  int _gameTimeSeconds = 0;


  Game({
    required this.gameType,
    required this.teamBreaking,
    required this.team1,
    required this.team2,
    required this.scoringSystem,
    required this.gameId
  }) {
    team1.initAllPlayerStats(gameType, teamBreaking);
    team2.initAllPlayerStats(gameType, teamBreaking);
    _checkInvariants();
  }  

  @override
  String toString() =>
    'Game(id: $gameId, type: $gameType, '
    'team1: ${team1.team.name}, team2: ${team2.team.name}, '
    'winner: ${_winner?.team.name ?? 'none'}, '
    'finished: $isGameFinised, playing: $isBeingPlayed, '
    'time: $_gameTimeSeconds s)';

  void _checkInvariants() {
    _checkPlayerBreaking(_playerBreaking);
    _checkGameTime(_gameTimeSeconds);
    _checkWinner(_winner);
  }

  void _checkPlayerBreaking(Player? playerBreaking) {
    if (playerBreaking != null) {
      assert(
        team1.players.contains(playerBreaking) || team2.players.contains(playerBreaking),
        'Game: player assigned as breaking is not part either team playing'  
      );
    }
  }

  void _checkGameTime(int gameTime) {
    assert(gameTime > 0, 'Game: game time cannot be negative. Time = $gameTime');
  }

  void _checkWinner(GameTeam? winningTeam) {
    assert(isGameFinised && winningTeam != null, "Game: game cannot be finised and winner be null");
  } 

  // Getters

  Player? get playerBreaking => _playerBreaking;

  GameTeam? get winner => _winner;

  int get gameTimeSeconds => _gameTimeSeconds;

  int get team1FinalScore {
    int potted = _teamPotted(team1);
    int opponentPotted = _teamPotted(team2);
    Outcome outcome = (_winner == team1) ? Outcome.win : Outcome.loss;
    return _score(outcome, potted, opponentPotted);
  } 

  int get team2FinalScore {
    int potted = _teamPotted(team2);
    int opponentPotted = _teamPotted(team1);
    Outcome outcome = (_winner == team2) ? Outcome.win : Outcome.loss;
    return _score(outcome, potted, opponentPotted);
  }

  int _teamPotted(GameTeam team) {
    int potted = 0;

    for (Player p in team.players) {
      GameStats? stats = team.allPlayerStats[p];

      if (stats == null) {
          throw ArgumentError('Game: geTeamPotted, stats cannot be null');
        }

      potted += stats.shootingStats.potted;
    }

    return potted;
  } 

  /// score 
  /// Gets the score of a team or player(team of 1)
  /// [outcome] and [potted] -> Are from the team or player your looking to get 
  /// the score of

  int _score(Outcome outcome, int potted, int opponentPotted) {
    return scoringSystem?.calculateGameScore(outcome, potted, opponentPotted) ?? noScoreSystemFlag; 
  } 

  // Setters

  set playerBreaking(Player playerBreaking) {
    _checkPlayerBreaking(playerBreaking);
    _playerBreaking = playerBreaking;
    _checkInvariants();
  }

  set winner(GameTeam winningTeam) {
    _checkWinner(winningTeam);
    _winner = winningTeam;
    _checkInvariants(); 
  }

  set gameTimeSeconds(int gameTimeSeconds) {
    _checkGameTime(gameTimeSeconds);
    _gameTimeSeconds = gameTimeSeconds;
    _checkInvariants();
  }

}
