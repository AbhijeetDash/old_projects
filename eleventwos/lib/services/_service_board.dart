import 'package:eleventwos/utils/_util_game.dart';

import '../models/models.dart';

abstract class BoardService {
  /// Genetate an empty board.
  Board generateEmptyBoard(int boardSize);

  /// Get all the Empty tiles on the board
  List<Tile> getEmptyTiles(Board board);

  /// Gives a 2d matrix of the values of the tiles on the board.
  List<List<int>> getDataMatrix(Board board);

  /// Gives a board from the given data matrix.
  Board getBoardFromDataMatrix(List<List<int>> dataMatrix);

  /// Add a tile on the given position.
  Board addTile(Board board);

  /// Check if Game is Over
  bool isGameOver(List<List<int>> matrix);

  /// Check if Game is Won
  bool isGameWon(List<List<int>> matrix);

  /// Get the score of the board.
  int getScore(List<List<int>> matrix);
}

class BoardServiceImpl extends BoardService {
  @override
  Board generateEmptyBoard(int boardSize) {
    // Create an empty board.
    List<List<Tile>> emptyBoard = List.generate(
      boardSize,
      (x) => List.generate(
        boardSize,
        (y) => Tile(
          xPosition: x,
          yPosition: y,
          value: 0,
          canMerge: false,
          isNew: false,
        ),
      ),
    );

    // Return the empty board.
    return Board(
      size: boardSize,
      score: 0,
      blocks: emptyBoard,
    );
  }

  @override
  List<Tile> getEmptyTiles(Board board) {
    // Create an empty list of tiles.
    List<Tile> emptyTiles = [];

    // Loop through the board and add all the empty tiles to the list.
    for (List<Tile> row in board.blocks) {
      for (Tile tile in row) {
        if (tile.isEmpty()) {
          emptyTiles.add(tile);
        }
      }
    }

    // Return the list of empty tiles.
    return emptyTiles;
  }

  @override
  Board addTile(Board board) {
    // Get the empty tiles on the board.
    List<Tile> emptyTiles = getEmptyTiles(board);

    int index = GameUtil.getRandomNumber(emptyTiles.length);

    // Get a random empty tile.
    Tile randomEmptyTile = emptyTiles[index];

    randomEmptyTile.canMerge = true;
    randomEmptyTile.isNew = true;

    // Add the tile to the board.
    board.blocks[randomEmptyTile.xPosition][randomEmptyTile.yPosition].value =
        // Gets 4 with a probability of 10% and 2 with a probability of 90%.
        GameUtil.getRandomNumber(10) == 1 ? 4 : 2;

    // Return the board.
    return board;
  }

  @override
  List<List<int>> getDataMatrix(Board board) {
    // Create an empty list of lists.
    List<List<int>> dataMatrix = [];

    // Loop through the board and add all the values to the list.
    for (List<Tile> row in board.blocks) {
      List<int> rowValues = [];
      for (Tile tile in row) {
        rowValues.add(tile.value);
      }
      dataMatrix.add(rowValues);
    }

    // Return the list of values.
    return dataMatrix;
  }

  @override
  Board getBoardFromDataMatrix(List<List<int>> dataMatrix) {
    // Create an empty board.
    List<List<Tile>> emptyBoard = [];
    int score = 0;

    // Loop through the data matrix and add all the values to the board.
    for (int x = 0; x < dataMatrix.length; x++) {
      List<Tile> row = [];
      for (int y = 0; y < dataMatrix[x].length; y++) {
        if (dataMatrix[x][y] > score) {
          score = dataMatrix[x][y];
        }

        row.add(Tile(
          xPosition: x,
          yPosition: y,
          value: dataMatrix[x][y],
          canMerge: false,
          isNew: false,
        ));
      }
      emptyBoard.add(row);
    }

    // Return the board.
    return Board(
      size: dataMatrix.length,
      score: score,
      blocks: emptyBoard,
    );
  }

  @override
  bool isGameOver(List<List<int>> matrix) {
    // iterate through each element in the matrix
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        int currentValue = matrix[i][j];

        // check if the current value is zero
        if (currentValue == 0) {
          return false;
        }

        // check if the current value can be merged with the value to the right
        if (j < 3 && currentValue == matrix[i][j + 1]) {
          return false;
        }

        // check if the current value can be merged with the value below
        if (i < 3 && currentValue == matrix[i + 1][j]) {
          return false;
        }
      }
    }

    // if no adjacent blocks can be merged in any direction, the game is over
    return true;
  }

  @override
  bool isGameWon(List<List<int>> matrix) {
    // iterate through each element in the matrix
    for (List<int> row in matrix) {
      for (int value in row) {
        // check if the current value is 2048
        if (value == 2048) {
          return true;
        }
      }
    }

    // if no element in the matrix is 2048, the game is not won
    return false;
  }

  @override
  int getScore(List<List<int>> matrix) {
    // iterate through each element in the matrix
    int score = 0;
    for (List<int> row in matrix) {
      for (int value in row) {
        if (value > score) score = value;
      }
    }

    // if no element in the matrix is 2048, the game is not won
    return score;
  }
}
