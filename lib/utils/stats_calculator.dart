class StatsCalculator {
  static const decimalPlaces = 2;

  static double getRate(int dividend, int divisor) {
    return divisor != 0 
      ? dividend / divisor 
      : 0;
  }

  static double getAverage(int x, int n) {
    return n != 0 
      ? x / n
      : 0;
  }

}
