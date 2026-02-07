/* 
match.dart 

purpose: Hold data for a pool match 

notes: 

1) This is a statefull mutable class. upon creation the class is incomplete.
   the class updates as the match progresses and is considered complete once the 
   match is finished

*/

import 'package:pool_shark/model/enums/game/team_breaking.dart';
import 'package:pool_shark/model/enums/match/breaking_format.dart';
import 'package:pool_shark/model/enums/match/match_type.dart';
import 'package:pool_shark/model/match/match_settings.dart';
import 'package:pool_shark/model/match/game_team.dart';
import 'package:pool_shark/model/match/team.dart';
import 'package:pool_shark/model/match/game.dart';
import 'package:pool_shark/model/user/user.dart';


final class Match {
  final User admin; 
  final DateTime matchDateUTC;
  final MatchSettings matchSettings;
  final String matchId;
  final Team team1;
  final Team team2;
  final List<Game> games = [];
  
  Team? winner;
  int team1Score = 0;
  int team2Score = 0;
  int matchTimeSeconds = 0;
  bool isBeingPlayed = false;
  bool isMatchFinished = false;

  Match({
    required this.admin, 
    required this.matchDateUTC,
    required this.matchSettings,
    required this.matchId, 
    required this.team1, 
    required this.team2, 
  }) {
    _initGames();
    _checkInvariants();
    
  }

  @override
  String toString() =>
    'Match(matchId: $matchId, admin: $admin, teams: [$team1, $team2], '
    'score: $team1Score-$team2Score, winner: $winner, '
    'games: $games, time: $matchTimeSeconds s, '
    'isBeingPlayed: $isBeingPlayed, isFinished: $isMatchFinished)';

  // Class invariants and pre-conditions
  // TODO: add matchId invariants

  void _checkInvariants() {
    _checkTeamScore(team1Score, 1);
    _checkTeamScore(team2Score, 2);
    _checkMatchTime(matchTimeSeconds);
  }

  void _checkTeamScore(int teamScore, int teamNumber) {
    int scoreLimit = (teamNumber == 1) 
      ? matchSettings.team1WinTarget 
      : matchSettings.team2WinTarget;

    assert(
      teamScore >= 1 && teamScore <= scoreLimit, 
      'Match: team $teamNumber score is either less than 1 or greater than win\n'
      'win target. teamScore = $teamScore, scoreLimit = $scoreLimit'
    );
  }

  void _checkMatchTime(int matchTimeSeconds) {
    assert(
      matchTimeSeconds >= 0,
      'Match: matchTimeSeconds is negative'
    );
  }

  // Inits

  void _initGames() {
    const noWinTargetMinGames = 1;
    int minWinsNeeded;

    if (matchSettings.isWinTarget) {
      int team1WinTarget = matchSettings.team1WinTarget;
      int team2WinTarget = matchSettings.team2WinTarget;

      minWinsNeeded = (team1WinTarget < team2WinTarget) 
        ? team1WinTarget 
        : team2WinTarget; 
    }
    else {
        minWinsNeeded = noWinTargetMinGames;
    } 

    for (int i = 0; i < minWinsNeeded; i++) {
    Game game = Game(
      gameId: i + 1,
      gameType: matchSettings.gameType,
      teamBreaking: TeamBreaking.undecided,
      team1: _initGameTeam(team1),
      team2: _initGameTeam(team2),
      scoringSystem: matchSettings.scoringSystem,
      );
      games.add(game);
    } 
  } 

  GameTeam _initGameTeam(Team team) {
    bool isTeamMatch = matchSettings.matchType == MatchType.teamSingles 
    || matchSettings.matchType == MatchType.teamDoubles;

    if (isTeamMatch) {
      return GameTeam([], team);
    }
    else {
      return GameTeam(team.players, team);
    }
  }


  // Getters 

  int get gamesPlayed => games.where((g) => g.isGameFinised).length;

  DateTime get matchTimeLocal => matchDateUTC.toLocal();
  DateTime get matchTimeUTC => matchDateUTC;


  // Behavoirs 


  TeamBreaking nextTeamBreaking(Game previousGame) {
    BreakingFormat breakingFormat = matchSettings.breakingFormat;
    TeamBreaking previousBreaking = previousGame.teamBreaking;

    switch(breakingFormat) {
      case BreakingFormat.winner: 
        return previousBreaking;
      case BreakingFormat.loser:
      case BreakingFormat.alternate:
        return _switchBreakers(previousBreaking);
    }
  }

  TeamBreaking _switchBreakers(TeamBreaking previousBreaking) {
    return (previousBreaking == TeamBreaking.team1) 
      ? TeamBreaking.team2
      : TeamBreaking.team1;
  }

  void addGame(Game game) {
    games.add(game);
  }
  
  Game getGame(int gameId) {
    int index = gameId - 1; // gameId is index +1
    return games[index];
  }
}
