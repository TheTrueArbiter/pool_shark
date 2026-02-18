/* 

round_distribution.dart 

purpose: Hold payouts per round, along with first and second place payout.

Payouts can be based on what round you made it to this could be round of 16 player, 
or round of 8 players. Notice that the final round will have 2 players so first 
and second place payouts must be listed aswell.

*/
import 'package:pool_shark/model/tournament/prizeMoney/money_distribution.dart';

final class RoundDistribution implements MoneyDistribution {
  @override
  final double firstPlacePay;

  @override
  final double secondPlacePay;

  final Map<int, double> roundPayouts;

  RoundDistribution({
    required this.firstPlacePay,
    required this.secondPlacePay,
    required this.roundPayouts
  }) {

    _checkInvariants();

  }

  void _checkInvariants() {
    _checkNotNegative(firstPlacePay, 'firstPlacePay');
    _checkNotNegative(secondPlacePay, 'secondPlacePay');

    _checkGreaterThan(firstPlacePay, secondPlacePay, 'firstPlacePay', 'secondPlacePay');

  }

  void _checkNotNegative(double val, String variableName) {
    assert(val >= 0, '$variableName must be positive: value = $val'); 
  }

  void _checkGreaterThan(double val, double other, String valName, String otherName) {
    assert(val > other, '$valName is not greater than $otherName. $valName = $val\n'
      '$otherName =  $other'
    );
  }

}
