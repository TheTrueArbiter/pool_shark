import 'package:pool_shark/model/userProfile/user.dart';
import 'package:pool_shark/model/match/game.dart';
import 'package:pool_shark/model/players/user_player.dart';
import 'package:pool_shark/model/players/player.dart';
import 'package:pool_shark/model/match/game_team.dart';
import 'package:pool_shark/utils/stats_calculator.dart';
import 'package:pool_shark/model/enums/outcome.dart';

final class HeadToHeadRecord {
  final User user;
  final User opponent;

  int _gamesWon = 0;
  int _gamesLost = 0;
  int _matchesWon = 0;
  int _matchesLost = 0;

  HeadToHeadRecord(this.user, this.opponent) {
    _checkInvariants();
  }

  // Class invariants

  void _checkInvariants() {
    assert(user != opponent, "HeadToHeadRecord: User cannot be the same as opponent");

    assert(_gamesLost >= 0, "HeadToHeadRecord: gamesLost cannot be negative");
    assert(_gamesWon >= 0, "HeadToHeadRecord: gamesWon cannot be negative");
    assert(_matchesWon >= 0, "HeadToHeadRecord: matchesWon cannot be negative");
    assert(_matchesLost >= 0, "HeadToHeadRecord: matchesLost cannot be negative");
  }

  // Getters

  int get gamesWon => _gamesWon; 
  int get gamesLost => _gamesLost;
  int get gamesPlayed => _gamesWon + _gamesLost;

  int get matchesWon => _matchesWon;
  int get matchesLost => _matchesLost;
  int get matchesPlayed => _matchesWon + _matchesLost;

  double get winGameWinRate => StatsCalculator.getRate(_gamesWon, gamesPlayed);
  double get matchWinRate => StatsCalculator.getRate(_matchesWon, matchesPlayed);

  // Logic

  void updateRecord(Outcome matchOutcome, List<Game> games) {

    if (matchOutcome == Outcome.win) { _matchesWon++; }
    else { _matchesLost++; }

    for (Game g in games) {
      if ( _isGameWon(g) ) {
        _gamesWon++; 
      }
      else {
        _gamesLost++; 
      }
    }
    _checkInvariants();
  }

  bool _isGameWon(Game game) {
    assert(game.winner != null, "HeadToHeadRecord, _isGameWon, game obj passed cannot be null"); 

    bool isMatchWon = false;
    GameTeam? winningTeam = game.winner;
      
    if (winningTeam == null) {
      throw ArgumentError("HeadToHeadRecord, isGameWon(), winning team cannot be null"); 
    }

    for (Player p in winningTeam.players) {
      if (p is UserPlayer && p.user == user) { 
        isMatchWon == true;
        break;
      }
    }
    return isMatchWon;
  }
}
