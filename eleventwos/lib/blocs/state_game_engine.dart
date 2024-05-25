part of 'bloc_game_engine.dart';

abstract class GameState {}

class GameStateInitial extends GameState {}

// We need this cause same state can't be emmited twice.
class GameStateLoading extends GameState {}

class GameStateOver extends GameState {
  final Board board;

  GameStateOver({
    required this.board,
  });
}

class GameStatePlaying extends GameState {
  final Board board;
  final int score;

  GameStatePlaying({
    required this.board,
    required this.score,
  });
}

class GameStateNewGame extends GameState {
  final Board board;
  final int score;

  GameStateNewGame({
    required this.board,
    required this.score,
  });
}

class GameStateWon extends GameState {
  final Board board;
  final int score;

  GameStateWon({
    required this.board,
    required this.score,
  });
}
