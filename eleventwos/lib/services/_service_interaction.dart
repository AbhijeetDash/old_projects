abstract class InteractionService {
  /// Swipe the tiles on the board in Right direction.
  List<List<int>> rightSwipe(List<List<int>> matrix, int boardSize);

  /// Swipe the tiles on the board in Left direction.
  List<List<int>> leftSwipe(List<List<int>> matrix, int boardSize);

  /// Swipe the tiles on the board in Up direction.
  List<List<int>> upSwipe(List<List<int>> matrix, int boardSize);

  /// Swipe the tiles on the board in Down direction.
  List<List<int>> downSwipe(List<List<int>> matrix, int boardSize);

  /// Check if we can do right swipe.
  bool canRightSwipe(List<List<int>> matrix);

  /// Check if we can do left swipe.
  bool canLeftSwipe(List<List<int>> matrix);

  /// Check if we can do up swipe.
  bool canUpSwipe(List<List<int>> matrix);

  /// Check if we can do down swipe.
  bool canDownSwipe(List<List<int>> matrix);
}

class InteractionServiceImpl extends InteractionService {
  @override
  List<List<int>> rightSwipe(List<List<int>> matrix, int boardSize) {
    // iterate through each row of the matrix
    for (int i = 0; i < boardSize; i++) {
      // create a new row to hold the swiped values
      List<int> newRow = [];
      // iterate through each element in the row, starting from the right
      for (int j = boardSize - 1; j >= 0; j--) {
        // if the element is not zero, add it to the new row
        if (matrix[i][j] != 0) {
          newRow.add(matrix[i][j]);
        }
      }

      // merge adjacent equal values in the new row
      for (int j = newRow.length - 1; j > 0; j--) {
        if (newRow[j] == newRow[j - 1]) {
          newRow[j] *= 2;
          newRow[j - 1] = 0;
        }
      }

      // shift the merged row to the right
      List<int> shiftedRow = [];
      for (int j = boardSize - 1; j >= 0; j--) {
        if (newRow.isNotEmpty) {
          shiftedRow.insert(0, newRow.removeLast());
        } else {
          shiftedRow.insert(0, 0);
        }
      }

      // update the original matrix with the shifted row
      matrix[i] = shiftedRow;
    }

    // return the updated matrix
    return matrix;
  }

  @override
  List<List<int>> leftSwipe(List<List<int>> matrix, int boardSize) {
    // iterate through each row of the matrix
    for (int i = 0; i < boardSize; i++) {
      // create a new row to hold the swiped values
      List<int> newRow = [];
      // iterate through each element in the row, starting from the left
      for (int j = 0; j < boardSize; j++) {
        // if the element is not zero, add it to the new row
        if (matrix[i][j] != 0) {
          newRow.add(matrix[i][j]);
        }
      }

      // merge adjacent equal values in the new row
      for (int j = 0; j < newRow.length - 1; j++) {
        if (newRow[j] == newRow[j + 1]) {
          newRow[j] *= 2;
          newRow[j + 1] = 0;
        }
      }

      // shift the merged row to the left
      List<int> shiftedRow = [];
      for (int j = 0; j < boardSize; j++) {
        if (newRow.isNotEmpty) {
          shiftedRow.add(newRow.removeAt(0));
        } else {
          shiftedRow.add(0);
        }
      }

      // update the original matrix with the shifted row
      matrix[i] = shiftedRow;
    }

    // return the updated matrix
    return matrix;
  }

  @override
  List<List<int>> upSwipe(List<List<int>> matrix, int boardSize) {
    // iterate through each column of the matrix
    for (int j = 0; j < boardSize; j++) {
      // create a new column to hold the swiped values
      List<int> newColumn = [];
      // iterate through each element in the column, starting from the top
      for (int i = 0; i < boardSize; i++) {
        // if the element is not zero, add it to the new column
        if (matrix[i][j] != 0) {
          newColumn.add(matrix[i][j]);
        }
      }

      // merge adjacent equal values in the new column
      for (int i = 0; i < newColumn.length - 1; i++) {
        if (newColumn[i] == newColumn[i + 1]) {
          newColumn[i] *= 2;
          newColumn[i + 1] = 0;
        }
      }

      // shift the merged column up
      List<int> shiftedColumn = [];
      for (int i = 0; i < boardSize; i++) {
        if (newColumn.isNotEmpty) {
          shiftedColumn.add(newColumn.removeAt(0));
        } else {
          shiftedColumn.add(0);
        }
      }

      // update the original matrix with the shifted column
      for (int i = 0; i < boardSize; i++) {
        matrix[i][j] = shiftedColumn[i];
      }
    }

    // return the updated matrix
    return matrix;
  }

  @override
  List<List<int>> downSwipe(List<List<int>> matrix, int boardSize) {
    // iterate through each column of the matrix
    for (int j = 0; j < boardSize; j++) {
      // create a new column to hold the swiped values
      List<int> newColumn = [];
      // iterate through each element in the column, starting from the bottom
      for (int i = boardSize - 1; i >= 0; i--) {
        // if the element is not zero, add it to the new column
        if (matrix[i][j] != 0) {
          newColumn.add(matrix[i][j]);
        }
      }

      // merge adjacent equal values in the new column
      for (int i = newColumn.length - 1; i > 0; i--) {
        if (newColumn[i] == newColumn[i - 1]) {
          newColumn[i] *= 2;
          newColumn[i - 1] = 0;
        }
      }

      // shift the merged column down
      List<int> shiftedColumn = [];
      for (int i = 0; i < boardSize; i++) {
        if (newColumn.isNotEmpty) {
          shiftedColumn.insert(0, newColumn.removeLast());
        } else {
          shiftedColumn.insert(0, 0);
        }
      }

      // update the original matrix with the shifted column
      for (int i = 0; i < boardSize; i++) {
        matrix[i][j] = shiftedColumn[i];
      }
    }

    // return the updated matrix
    return matrix;
  }

  @override
  bool canDownSwipe(List<List<int>> matrix) {
    // Go through the
    return true;
  }

  @override
  bool canLeftSwipe(List<List<int>> matrix) {
    // TODO: implement canLeftSwipe
    throw UnimplementedError();
  }

  @override
  bool canRightSwipe(List<List<int>> matrix) {
    // TODO: implement canRightSwipe
    throw UnimplementedError();
  }

  @override
  bool canUpSwipe(List<List<int>> matrix) {
    // TODO: implement canUpSwipe
    throw UnimplementedError();
  }
}
