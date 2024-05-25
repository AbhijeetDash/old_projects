import 'package:equatable/equatable.dart';

import '_model_tile.dart';

class Board extends Equatable {
  // The Size of the board and the current Score.
  final int size, score;
  // We should first generate the list of blocks that should be on the board.
  final List<List<Tile>> blocks;

  // The const constructor
  const Board({
    required this.size,
    required this.score,
    required this.blocks,
  });

  // Adds Equality check for this instance of the class
  @override
  List<Object?> get props => [size, score, blocks];
}
