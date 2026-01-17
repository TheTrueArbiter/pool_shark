/* 

*/

import 'package:pool_shark/model/enums/scoringSystems/scoring_system.dart';
import 'package:pool_shark/model/stats/game_stats.dart';
import 'package:pool_shark/model/userProfile/user_profile.dart';
import 'package:pool_shark/model/enums/game_type.dart';
// import 'package:pool_shark/model/enums/match/match_type.dart';
import 'package:pool_shark/model/enums/game/team_breaking.dart';

final class Game {

  final GameType gameType;
  final List<UserProfile> team2;
  final List<UserProfile> team1; 
  final Map<UserProfile, GameStats> playerStats = {};
  final ScoringSystem scoringSystem;

  TeamBreaking teamBreaking;
  UserProfile? playerBreaking;

  List<UserProfile>? winner;

  bool isGameFinised = false;

  int team1Score = 0; 
  int team2Score = 0;
  int gameTimeSeconds = 0;

  Game(this.gameType, this.teamBreaking, this.team1, this.team2, this.scoringSystem) { 
    _initPlayerStats(team1, team2);
    _checkInvariants();
  }

  // Class invariants & pre condtions

  void _checkInvariants() {
    _checkPlayerStats();
    _checkTeamScore(team1Score, 1);
    _checkTeamScore(team2Score, 2);
    _checkPlayerBreaking(playerBreaking);
    _checkGameTime(gameTimeSeconds);
    _checkWinner();
  }

  void _checkPlayerStats() {
    assert(
      playerStats.length == team2.length + team1.length,
      'Game: playerStats must have size of team2.lenght + team2.length, but doesnt\n'
      'playerStats.length = ${playerStats.length}, team2.lenght + team2.length = '
      '${team2.length + team2.length},'
    );

    for (UserProfile user in [...team1, ...team2]) {
      assert(
        playerStats[user] != null,
        'Game: Not all players have GameStats. UserProfile ${user.name}'
      );
    }
  }

  void _checkPlayerBreaking(UserProfile? playerBreaking) {
    if (playerBreaking != null) {
      assert(
        team1.contains(playerBreaking) || team2.contains(playerBreaking),
        'Game: player assigned as breaking is not part either team playing'  
      );
    }
  }

  void _checkTeamScore(int teamScore, int teamNumber) {
    assert(
      teamScore >= 0,
      'Team $teamNumber score cannot be negative. score = $teamScore'
    );
  } 

  void _checkGameTime(int gameTime) {
    assert(gameTime > 0, 'Game: game time cannot be negative. Time = $gameTime');
  }

  void _checkWinner() {
    assert(isGameFinised && winner != null, "Game: game cannot be finised and winner be null");
  } 

  void _initPlayerStats(List<UserProfile> team1, List<UserProfile> team2) {
    List<UserProfile> allPlayers = [...team1, ...team2]; // adds lists

    for (UserProfile player in allPlayers) {
      GameStats gameStats = GameStats(gameType, teamBreaking);
      playerStats[player] = gameStats;
    
    }
  }

  GameStats? getPlayerStats(UserProfile user) {
    return playerStats[user];
  }


  int playerScore(UserProfile player, int opponentPotted) {
    GameStats? gameStats = playerStats[player];
    int score = scoringSystem.calculateGameScore(gameStats, opponentPotted);
    return score;
  }


}
