class GameScore {
  final int scorePlayerOne;
  final int scorePlayerTwo;

  GameScore({
    required this.scorePlayerOne,
    required this.scorePlayerTwo,
  });

  factory GameScore.fromData(Map<String, dynamic> data) {
    return GameScore(
      scorePlayerOne: data['scorePlayerOne'],
      scorePlayerTwo: data['scorePlayerTwo'],
    );
  }

  Map<String, int> toJson() {
    return {
      "scorePlayerOne": scorePlayerOne,
      "scorePlayerTwo": scorePlayerTwo,
    };
  }
}
