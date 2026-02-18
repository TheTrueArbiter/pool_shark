/* 

prize_money.dart 

purpose: Hold data about the prize money for tournament or league.

*/
import 'package:pool_shark/model/enums/tournament/money_distribution_type.dart';
import 'package:pool_shark/model/tournament/prizeMoney/money_distribution.dart';

final class PrizeMoney {
  final double prizePoolDollars;
  final MoneyDistributionType moneyDistributionType;
  final MoneyDistribution moneyDistribution;

  PrizeMoney({
    required this.prizePoolDollars,
    required this.moneyDistribution,
    required this.moneyDistributionType

  }) {
    _checkInvariants();
  }


  void _checkInvariants() {

  }
}
