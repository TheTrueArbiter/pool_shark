/* 
podium_distribution.dart 

purpose: Hold podium styled payouts.

Podium payouts means only first, second and third place get paid

*/
import 'package:pool_shark/model/tournament/prizeMoney/money_distribution.dart';

class PodiumDistribution implements MoneyDistribution {

  @override
  final double firstPlacePay;

  @override
  final double secondPlacePay;

  final double thirdPlacePay; 

  PodiumDistribution({
    required this.firstPlacePay,
    required this.secondPlacePay, 
    required this.thirdPlacePay,
  }) {
    _checkInvariants();
  }

  void _checkInvariants() {
    _checkNotNegative(firstPlacePay, 'firstPlacePay');
    _checkNotNegative(secondPlacePay, 'secondPlacePay');
    _checkNotNegative(thirdPlacePay, 'thirdPlacePay');

    _checkGreaterThan(firstPlacePay, secondPlacePay, 'firstPlacePay', 'secondPlacePay');

    if (secondPlacePay != 0 ) {
      _checkGreaterThan(secondPlacePay, thirdPlacePay,'secondPlacePay', 'thirdPlacePay');
    } 
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
