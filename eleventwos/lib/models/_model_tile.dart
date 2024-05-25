import 'package:equatable/equatable.dart';

class Tile extends Equatable {
  int xPosition, yPosition, value;
  bool canMerge, isNew;

  Tile({
    required this.xPosition,
    required this.yPosition,
    required this.value,
    required this.canMerge,
    required this.isNew,
  });

  bool isEmpty() => value == 0;

  @override
  List<Object?> get props => [xPosition, yPosition, value, canMerge, isNew];
}
