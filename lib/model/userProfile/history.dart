import 'package:pool_shark/model/league/leauge.dart';
import 'package:pool_shark/model/tournament/tournament.dart';

final class History {
  final List<Match> matches = [];
  final List<Tournament> tournaments = [];
  final List<Leauge> leagues = [];

  History();

  addToList<T>(List<T> list, T object) {
    list.add(object);
  }

  // TODO: decide how match, tournaments, and leagues will be found by


}
