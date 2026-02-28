import 'package:flutter_test/flutter_test.dart';
import 'package:pool_shark/model/stats/shooting_stats.dart';

void main() {

  group("Shooting stats", () {
    group("Class invariants & preconditons", () {

      test("addPotted throws when passing negative value",() {
        final stats = ShootingStats();
        expect( () => stats.addPotted(-1), throwsA(isA<AssertionError>()));
      });

      test("addMissed throws when passing negative value",() {
        final stats = ShootingStats();
        expect( () => stats.addMissed(-10), throwsA(isA<AssertionError>()));
      });

      test("addFouls throws when passing negative value",() {
        final stats = ShootingStats();
        expect( () => stats.addFouls(-2), throwsA(isA<AssertionError>()));
      });

      test("safeties throws when passing negative value",() {
        final stats = ShootingStats();
        expect( () => stats.addSafeties(-3), throwsA(isA<AssertionError>()));
      });
    });
    
    group("instance variable getters return correctly", () {
      
      test("potted getter returns correct", () {
        final stats = ShootingStats();
        final expectedValue = 10;
        stats.addPotted(expectedValue);
        expect(stats.potted, expectedValue);
      });

      test("missed getter returns correct", () {
        final stats = ShootingStats();
        final expectedValue = 22;
        stats.addMissed(expectedValue);
        expect(stats.missed, expectedValue);
      });

      test("foul getter returns correct", () {
        final stats = ShootingStats();
        final expectedValue = 7;
        stats.addFouls(expectedValue);
        expect(stats.fouls, expectedValue);
      });

      test("safeties getter returns correct", () {
        final stats = ShootingStats();
        final expectedValue = 19;
        stats.addSafeties(expectedValue);
        expect(stats.safeties, expectedValue);
      });
    });

    group("Total shots summing", () {
      test("All shot types added", (){
        final stats = ShootingStats();
        final expectedAnswer = 14;
        stats.addPotted(8);
        stats.addMissed(3);
        stats.addSafeties(2);
        stats.addFouls(1);

        expect(stats.totalShots, expectedAnswer);
      });

      test("3 of 4 shot types added", (){
        final stats = ShootingStats();
        final expectedAnswer = 12;
        stats.addPotted(8);
        stats.addMissed(2);
        stats.addFouls(2);

        expect(stats.totalShots, expectedAnswer);
      });

      test("2 of 4 shot types added", (){
        final stats = ShootingStats();
        final expectedAnswer = 7;
        stats.addPotted(6);
        stats.addMissed(1);

        expect(stats.totalShots, expectedAnswer);
      });

      test("1 of 4 shot types added", (){
        final stats = ShootingStats();
        final expectedAnswer = 2;
        stats.addMissed(2);

        expect(stats.totalShots, expectedAnswer);
      });

      test("no shot types added", (){
        final stats = ShootingStats();
        final expectedAnswer = 0;

        expect(stats.totalShots, expectedAnswer);
      });
    });

    group("Shooting rates", () {
      
      // PottingRate

      test('get pottedRate is correct value', () {
        final stats = ShootingStats();
        stats.addPotted(8);
        stats.addMissed(1);
        stats.addSafeties(1);

        final expectedAnswer = 0.8;
        expect(stats.pottingRate, expectedAnswer);
      });

      test('pottingRate should return 100%', () {
        final stats = ShootingStats();
        stats.addPotted(8);

        final expectedAnswer = 1; 
        expect(stats.pottingRate, expectedAnswer);
      });

      test('pottingRate is 0 when no breaks recorded', () {
        final stats = ShootingStats();
        stats.addMissed(3);
        stats.addFouls(1);

        final expectedAnswer = 0;
        expect(stats.pottingRate, expectedAnswer);
      });

      test('pottingRate handles repeating decimals', () {
        final stats = ShootingStats();
        stats.addPotted(1);
        stats.addMissed(2);

        expect(stats.pottingRate, closeTo(0.3333, 0.0001));
      });

      // Missed rate

      test('get missedRate is correct value', () {
        final stats = ShootingStats();
        stats.addMissed(4);
        stats.addSafeties(1);

        final expectedAnswer = 0.8;
        expect(stats.missedRate, expectedAnswer);
      });

      test('missedRate should return 100%', () {
        final stats = ShootingStats();
        stats.addMissed(1);

        final expectedAnswer = 1; 
        expect(stats.missedRate, expectedAnswer);
      });

      test('missedRate is 0 when no breaks recorded', () {
        final stats = ShootingStats();
        stats.addPotted(8);

        final expectedAnswer = 0;
        expect(stats.missedRate, expectedAnswer);
      });

      test('missedRate handles repeating decimals', () {
        final stats = ShootingStats();
        stats.addMissed(2);
        stats.addPotted(1);

        expect(stats.missedRate, closeTo(0.66666, 0.0001));
      });


      // foul rate

      test('get foulRate is correct value', () {
        final stats = ShootingStats();
        stats.addPotted(3);
        stats.addFouls(1);

        final expectedAnswer = 0.25;
        expect(stats.foulRate, expectedAnswer);
      });

      test('foulRate should return 100%', () {
        final stats = ShootingStats();
        stats.addFouls(2);

        final expectedAnswer = 1; 
        expect(stats.foulRate, expectedAnswer);
      });

      test('foulRate is 0 when no breaks recorded', () {
        final stats = ShootingStats();
        stats.addPotted(8);

        final expectedAnswer = 0;
        expect(stats.foulRate, expectedAnswer);
      });

      test('missedRate handles repeating decimals', () {
        final stats = ShootingStats();
        stats.addMissed(9);
        stats.addFouls(2);

        expect(stats.foulRate, closeTo(0.181818, 0.0001));
      });

      // safty rate

      test('get saftyRate is correct value', () {
        final stats = ShootingStats();
        stats.addPotted(4);
        stats.addSafeties(1);

        final expectedAnswer = 0.2;
        expect(stats.safetyRate, expectedAnswer);
      });

      test('safetyRate should return 100%', () {
        final stats = ShootingStats();
        stats.addSafeties(2);

        final expectedAnswer = 1; 
        expect(stats.safetyRate, expectedAnswer);
      });

      test('safetyRate is 0 when no breaks recorded', () {
        final stats = ShootingStats();
        stats.addPotted(8);

        final expectedAnswer = 0;
        expect(stats.safetyRate, expectedAnswer);
      });

      test('safetyRate handles repeating decimals', () {
        final stats = ShootingStats();
        stats.addPotted(8);
        stats.addSafeties(1);

        expect(stats.safetyRate, closeTo(0.1111111, 0.0001));
      });


  
    });


  });

}
