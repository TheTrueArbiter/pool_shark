import 'package:pool_shark/model/constants/name_lengths.dart';
import 'package:pool_shark/model/tournament/phases/knockOutPhase/knock_out_phase.dart';
import 'package:pool_shark/model/tournament/phases/roundRobinPhase/round_robin_phase.dart';
import 'package:pool_shark/model/tournament/tournament_settings.dart';
import 'package:pool_shark/model/user/user.dart';
import 'package:pool_shark/utils/check_length.dart';

final class Tournament {
  final String name;
  final User organizer;
  final TournamentSettings settings;
  final RoundRobinPhase? roundRobin;
  final KnockOutPhase knockOutPhase;
  final DateTime startDate;
  final DateTime endDate;

  bool isComplete = false;

  Tournament({
    required this.name,
    required this.organizer,
    required this.settings,
    required this.roundRobin,
    required this.knockOutPhase,
    required this.startDate,
    required this.endDate
  }) {

    _checkInvariants();

  }

  void _checkInvariants() {
    _checkTournamentName(name);

  }

  void _checkTournamentName(String name) {
    CheckLength.checkLength(
      name, 'tournamentName', NameLengths.tournanmentMin, NameLengths.tournanmentMax
    );
  }
}
