import 'dart:async';

import 'package:tikytoe/application/models/model_game_score.dart';

class GameScoreBloc {
  final StreamController<GameScore> _gameScoreController = StreamController<GameScore>();
  Stream get gameScoreStream => _gameScoreController.stream;
  Sink get gameScoreSink => _gameScoreController.sink;
}