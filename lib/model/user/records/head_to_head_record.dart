import 'package:pool_shark/model/stats/match_stats.dart';
import 'package:pool_shark/model/user/user.dart';
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

  void updateRecord(MatchStats matchStats) {
    _gamesWon += matchStats.gamesWon;
    _gamesLost += matchStats.gamesLost;

    assert(
      matchStats.matchOutcome != Outcome.undecided,
      'match outcome cannot be undecided when updating HeadToHeadRecord'
    );

    if (matchStats.matchOutcome == Outcome.win) {
      _matchesWon++;
    }
    else if (matchStats.matchOutcome == Outcome.loss) {
      _matchesLost++;
    }

   _checkInvariants();
  }

}
