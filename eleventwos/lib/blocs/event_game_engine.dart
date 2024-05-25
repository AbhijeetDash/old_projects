part of 'bloc_game_engine.dart';

abstract class EventGameEngine {}

class EventNewGame extends EventGameEngine {
  final int boardSize;

  EventNewGame({this.boardSize = 4});
}

class EventGameOver extends EventGameEngine {}

class EventMove extends EventGameEngine {
  final SwipeDirection direction;

  EventMove({required this.direction});
}
