import 'package:pool_shark/model/enums/ranking/apa_eight_ball_rank.dart';
import 'package:pool_shark/model/enums/ranking/apa_nine_ball_rank.dart';
import 'package:pool_shark/model/enums/outcome.dart';


const noFargoRankFlag = -1;

final class Rank {
  // IMPORTANT: this values are just rough ranges atm
  final minFargoRating = 200;
  final maxFargoRating = 1000;

  ApaNineBallRank apaNineBallRank;
  ApaEightBallRank apaEightBallRank;
  int _fargoRating;

  Rank() 
    : apaEightBallRank = ApaEightBallRank.none,
    apaNineBallRank = ApaNineBallRank.none,
    _fargoRating = noFargoRankFlag;



  int get fargoRating => _fargoRating;

  set fargoRating(int fargoRating) {
    assert(
      fargoRating <= maxFargoRating && fargoRating >= minFargoRating, 
      "class: Ranking: method: set fargotRating, fargot rating is not withen\n"
      "the possible range. min = $minFargoRating, max = $maxFargoRating, fargo = $fargoRating"
    );

    _fargoRating = fargoRating;
  }

  // TODO: Read below. 
  // Fargo rating system formula is kept secret, so we need to implement our own.
  void updateFargoRating(Outcome outcome, int opponentsFargo) {}
}
