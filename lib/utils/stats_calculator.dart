class StatsCalculator {
  static const decimalPlaces = 2;

  static double getRate(int dividend, int divisor) {
    return divisor != 0 
      ? double.parse((dividend / divisor).toStringAsFixed(decimalPlaces)) * 100 
      : 100;
  }

}
