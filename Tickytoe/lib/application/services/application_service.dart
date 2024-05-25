import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikytoe/application/constants/const_text_sizes.dart';
import 'package:tikytoe/application/models/model_game_score.dart';
import 'package:tikytoe/application/services/game_score_bloc.dart';

class AppServices {
  final String userMove;
  AppServices(this.userMove);

  // Show Dialog
  void _showResultDialog(String text, ValueNotifier gameStateNotifier,
      ValueNotifier playerTurnNotifier) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.dialog(Dialog(
        child: Container(
          width: 300,
          height: 100,
          color: Colors.white,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: heading),
          ),
        ),
      )).then((value){
        gameStateNotifier.value = ['', '', '', '', '', '', '', '', ''];
      });
    });
  }

  // Make move for human
  void makeHumanMove(int index, ValueNotifier gameStateNotifier,
      ValueNotifier playerTurnNotifier, GameScoreBloc _scoreBloc) {
    if (gameStateNotifier.value[index] == '') {
      gameStateNotifier.value[index] = userMove;
    }
    if (gameStateNotifier.value.contains('')) {
      playerTurnNotifier.value = true;
      playerTurnNotifier.notifyListeners();
    }
    String result = checkWinner(gameStateNotifier.value);
    if (result == userMove) {
      _showResultDialog("Congratulations you won! 🥳", gameStateNotifier, playerTurnNotifier);
      gameStateNotifier.notifyListeners();
      _scoreBloc.gameScoreSink
          .add(GameScore(scorePlayerOne: 0, scorePlayerTwo: 1));
    }

    if (result == "tie") {
      _showResultDialog("Well done! it's a tie 😏", gameStateNotifier, playerTurnNotifier);
      gameStateNotifier.notifyListeners();
      _scoreBloc.gameScoreSink
          .add(GameScore(scorePlayerOne: 0, scorePlayerTwo: 0));
    }
    gameStateNotifier.notifyListeners();
  }

  // Make move for AI
  void makeBotMove(
      ValueNotifier gameStateNotifier, GameScoreBloc _scoreBloc, ValueNotifier playerTurnNotifier) async {
    int _bestScore = -999999;
    int _bestMove = 0;
    for (int i = 0; i < 9; i++) {
      // If the spot is available;
      if (gameStateNotifier.value[i] == "") {
        gameStateNotifier.value[i] = userMove == 'x' ? 'o' : 'x';
        int _score = minimax(gameStateNotifier.value, 0, false);
        gameStateNotifier.value[i] = '';
        if (_score > _bestScore) {
          _bestScore = _score;
          _bestMove = i;
        }
      }
    }
    gameStateNotifier.value[_bestMove] = userMove == 'x' ? 'o' : 'x';
    String result = checkWinner(gameStateNotifier.value);
    if (result != userMove && result != "TBD" && result != "tie") {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _showResultDialog("Winner is AI! 🥳",gameStateNotifier, playerTurnNotifier);
        gameStateNotifier.notifyListeners();
        _scoreBloc.gameScoreSink
            .add(GameScore(scorePlayerOne: 1, scorePlayerTwo: 0));
      });
    } else if (result == "tie") {
      _showResultDialog("Well done! it's a tie 😏", gameStateNotifier, playerTurnNotifier);
      gameStateNotifier.notifyListeners();
      _scoreBloc.gameScoreSink
          .add(GameScore(scorePlayerOne: 0, scorePlayerTwo: 0));
    }
    gameStateNotifier.notifyListeners();
  }

  // Returns the appropriate length of the game tile.
  double getGameTileEdgeLength(Size _size) {
    return (_size.width - 80) / 3;
  }

  bool equals3(a, b, c) {
    return (a == b && b == c && a != '');
  }

  // Returns 0 if there is no winner.
  // Returns 1 if bot wins
  // Returns -1 if bot looses
  // Returns null if game still on.
  String checkWinner(List<String> currentGameState) {
    // Horizontal
    if (equals3(
        currentGameState[0], currentGameState[1], currentGameState[2])) {
      return currentGameState[0];
    } else if (equals3(
        currentGameState[3], currentGameState[4], currentGameState[5])) {
      return currentGameState[3];
    } else if (equals3(
        currentGameState[6], currentGameState[7], currentGameState[8])) {
      return currentGameState[6];
    }

    // Vertical
    else if (equals3(
        currentGameState[0], currentGameState[3], currentGameState[6])) {
      return currentGameState[0];
    } else if (equals3(
        currentGameState[1], currentGameState[4], currentGameState[7])) {
      return currentGameState[1];
    } else if (equals3(
        currentGameState[2], currentGameState[5], currentGameState[8])) {
      return currentGameState[2];
    }

    // Diagonal
    else if (equals3(
        currentGameState[0], currentGameState[4], currentGameState[8])) {
      return currentGameState[0];
    } else if (equals3(
        currentGameState[2], currentGameState[4], currentGameState[6])) {
      return currentGameState[2];
    } else if (!currentGameState.contains('')) {
      return "tie";
    } else {
      return "TBD";
    }
  }

  // Minimax algorithm from game-theory,
  // only run on bots' turn to return score.
  int minimax(List<String> currentGameState, int depth, bool isMaximizing) {
    String result = checkWinner(currentGameState);
    if (result != "TBD" && result != "") {
      if (result != userMove) {
        return 1;
      }
      if (result == userMove) {
        return -1;
      }
      return 0;
    }

    if (isMaximizing) {
      int _bestScore = -999999;
      for (int i = 0; i < 9; i++) {
        if (currentGameState[i] == "") {
          currentGameState[i] = userMove == 'x' ? 'o' : 'x';
          int _score = minimax(currentGameState, depth + 1, false);
          currentGameState[i] = '';
          _bestScore = max(_score, _bestScore);
        }
      }
      return _bestScore;
    } else {
      int _bestScore = 999999;
      for (int i = 0; i < 9; i++) {
        if (currentGameState[i] == "") {
          currentGameState[i] = userMove;
          int _score = minimax(currentGameState, depth + 1, true);
          currentGameState[i] = '';
          _bestScore = min(_score, _bestScore);
        }
      }
      return _bestScore;
    }
  }
}
