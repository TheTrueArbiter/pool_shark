/* 
podium_distribution.dart 

purpose: Hold podium styled payouts.

Podium payouts means only first, second and third place get paid

*/
import 'package:pool_shark/model/tournament/prizeMoney/money_distribution.dart';

class PodiumDistribution implements MoneyDistribution {

  @override
  final double firstPlacePercent;

  @override
  final double secondPlacePercent;

  final double thirdPlacePercent; 

  PodiumDistribution({
    required this.firstPlacePercent,
    required this.secondPlacePercent, 
    required this.thirdPlacePercent,
  }) {
    _checkInvariants();
  }

  void _checkInvariants() {
    _checkNotNegative(firstPlacePercent, 'firstPlacePercent');
    _checkNotNegative(secondPlacePercent, 'secondPlacePercent');
    _checkNotNegative(thirdPlacePercent, 'thirdPlacePercent');

    _checkGreaterThan(firstPlacePercent, secondPlacePercent, 'firstPlacePercent', 'secondPlacePercent');

    if (secondPlacePercent != 0 ) {
      _checkGreaterThan(secondPlacePercent, thirdPlacePercent,'secondPlacePercent', 'thirdPlacePercent');
    } 

    assert(
      firstPlacePercent + secondPlacePercent + thirdPlacePercent == 1,
      'The total of first second and third place percent cut should be equal to 1'
    ); 
  }

  void _checkNotNegative(double val, String variableName) {
    assert(val >= 0, '$variableName must be positive: value = $val'); 
  }

  void _checkGreaterThan(double val, double other, String valName, String otherName) {
    assert(val > other, '$valName is not greater than $otherName. $valName = $val\n'
      '$otherName =  $other'
    );
  }

  double winnersPay(double prizePoolDollars) {
    return prizePoolDollars * firstPlacePercent;
  }

  double secondPlacePay(double prizePoolDollars) {
    return prizePoolDollars * secondPlacePercent;
  }

  double thirdPlacePay(double prizePoolDollars) {
    return prizePoolDollars * thirdPlacePercent;
  }
}
