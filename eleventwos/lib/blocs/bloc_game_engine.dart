import 'package:eleventwos/services/_service_interaction.dart';
import 'package:eleventwos/utils/_util_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums/enums.dart';
import '../models/models.dart';
import '../services/services.dart';

part './event_game_engine.dart';
part './state_game_engine.dart';

/// This bloc takes care of the Game State and Data.
class BlocGameEngine extends Bloc<EventGameEngine, GameState> {
  // All the variables that need to be stored in the state.
  late Board board;
  late BoardService boardService;
  late InteractionService interactionService;

  BlocGameEngine() : super(GameStateInitial()) {
    boardService = locator.get<BoardService>();
    interactionService = locator.get<InteractionService>();

    on<EventNewGame>((event, emit) => _onEventNewGame(event, emit));
    on<EventMove>((event, emit) => _onEventMove(event, emit));
  }

  void _onEventNewGame(EventNewGame event, Emitter<GameState> emit) {
    board = boardService.generateEmptyBoard(event.boardSize);
    _addTiles(2);

    emit(GameStateNewGame(board: board, score: 0));
  }

  void _onEventMove(EventMove event, Emitter<GameState> emit) {
    emit(GameStateLoading());
    List<List<int>> dataMatrix = boardService.getDataMatrix(board);
    List<List<int>> updatedState = [];

    switch (event.direction) {
      case SwipeDirection.left:
        updatedState = interactionService.leftSwipe(dataMatrix, board.size);
        board = boardService.getBoardFromDataMatrix(updatedState);
        break;
      case SwipeDirection.right:
        updatedState = interactionService.rightSwipe(dataMatrix, board.size);
        board = boardService.getBoardFromDataMatrix(updatedState);
        break;
      case SwipeDirection.up:
        updatedState = interactionService.upSwipe(dataMatrix, board.size);
        board = boardService.getBoardFromDataMatrix(updatedState);
        break;
      case SwipeDirection.down:
        updatedState = interactionService.downSwipe(dataMatrix, board.size);
        board = boardService.getBoardFromDataMatrix(updatedState);
        break;
    }
    if (boardService.isGameOver(updatedState)) {
      emit(GameStateOver(board: board));
      return;
    }

    int score = boardService.getScore(updatedState);
    if (boardService.isGameWon(updatedState)) {
      emit(GameStateWon(board: board, score: score));
      return;
    }

    _addTiles(1);
    emit(GameStatePlaying(board: board, score: score));
  }

  void _addTiles(int tileCount) {
    for (int i = 0; i < tileCount; i++) {
      board = boardService.addTile(board);
    }
  }
}
