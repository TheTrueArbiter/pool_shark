/* 
scoring_system.dart 

purpose: interface for scoring systems. The main purpose of this is to use 
          polymorphism to be able to refer to differnt scoring system classes  
          as a scoring system object
*/

import 'package:pool_shark/model/enums/outcome.dart';

abstract class ScoringSystem {
  // String get displayName;
  int calculateGameScore(Outcome outcome, int potted, int opponentPotted);
}
