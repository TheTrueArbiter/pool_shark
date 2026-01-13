class StatsCalculator {
  static const decimalPlaces = 2;

  static double getRate(int dividend, int divisor) {
    return divisor != 0 
      ? double.parse((dividend / divisor).toStringAsFixed(decimalPlaces)) * 100 
      : 100;
  }

  static double getAverage(int x, int n) {
    return n != 0 
      ? double.parse((x / n).toStringAsFixed(decimalPlaces)) * 100
      : 0;
 
  }

}
