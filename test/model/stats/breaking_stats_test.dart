import 'package:flutter_test/flutter_test.dart';
import 'package:pool_shark/model/stats/breaking_stats.dart';

void main() {

  group('breakingStats class', () {

    group('Class invariants & preconditions', () {

      test('addWetBreaks throws when trying to add negative value', () {
        final stats = BreakingStats();
        expect( () => stats.addWetBreaks(-1), throwsA(isA<AssertionError>()));
      
      });

    test('addDryBreaks throws when trying to add negative value', () {
        final stats = BreakingStats();
        expect( () => stats.addDryBreaks(-1), throwsA(isA<AssertionError>()));
      
      });

    test('addFoulBreaks throws when trying to add negative value', () {
        final stats = BreakingStats();
        expect( () => stats.addFoulBreaks(-1), throwsA(isA<AssertionError>()));
      });
    });

    group('totalBreaks', () {

      test('returns sum of wet, dry, and foul breaks', () {
        final stats = BreakingStats();
        stats.addWetBreaks(10);
        stats.addDryBreaks(5);
        stats.addFoulBreaks(1);

        expect(stats.totalBreaks, 16);
      });

      test('returns correct total when only foul breaks added', () {
        final stats = BreakingStats();
        stats.addFoulBreaks(10);

        expect(stats.totalBreaks, 10);
      });

      test('returns correct total when only wet and dry breaks added', () {
        final stats = BreakingStats();
        stats.addWetBreaks(10);
        stats.addDryBreaks(5);

        expect(stats.totalBreaks, 15);
      });

    });

    group('break rates', () {

      test('get wetBreakRate returns correct value', () {
        final stats = BreakingStats();
        stats.addWetBreaks(10);
        stats.addDryBreaks(10);

        expect(stats.wetBreakRate, 0.5);
      });

      test('wetBreakRate can return 100%', () {
        final stats = BreakingStats();
        stats.addWetBreaks(1);

        expect(stats.wetBreakRate, 1);
      });

      test('wetBreakRate is 0 when no breaks recorded', () {
        final stats = BreakingStats();
        expect(stats.wetBreakRate, 0);
      });

      test('wetBreakRate handles repeating decimals', () {
        final stats = BreakingStats();
        stats.addWetBreaks(1);
        stats.addDryBreaks(2);

        expect(stats.wetBreakRate, closeTo(0.3333, 0.0001));
      });
      
      test('get dryBreakRate returns correct value', () {
        final stats = BreakingStats();
        stats.addDryBreaks(25);
        stats.addWetBreaks(70);
        stats.addFoulBreaks(5);

        expect(stats.dryBreakRate, 0.25);
      });

      test('dryBreakRate can return 100%', () {
        final stats = BreakingStats();
        stats.addDryBreaks(1);

        expect(stats.dryBreakRate, 1);
      });



      test('dryBreakRate is 0 when no breaks recorded', () {
        final stats = BreakingStats();
        expect(stats.dryBreakRate, 0);
      });

      test('dryBreakRate handles repeating decimals', () {
        final stats = BreakingStats();
        stats.addDryBreaks(1);
        stats.addWetBreaks(8);

        expect(stats.dryBreakRate, closeTo(0.11111, 0.0001));
      });


      test('foulBreakRate returns correct value', () {
        final stats = BreakingStats();
        stats.addFoulBreaks(4);
        stats.addDryBreaks(6);

        expect(stats.foulBreakRate, 0.4);
      });

      test('foulBreakRate can return 100%', () {
        final stats = BreakingStats();
        stats.addFoulBreaks(1);

        expect(stats.foulBreakRate, 1);
      });

      test('foulBreakRate is 0 when no breaks recorded', () {
        final stats = BreakingStats();
        expect(stats.foulBreakRate, 0);
      });

      test('foulBreakRate handles repeating decimals', () {
        final stats = BreakingStats();
        stats.addFoulBreaks(2);
        stats.addWetBreaks(1);

        expect(stats.foulBreakRate, closeTo(0.66666, 0.0001));
      });





    });

  });

}
