import 'dart:math';

class GameUtil {
  // Generate a random number between 0 and length
  // and return the number.
  static int getRandomNumber(int length) {
    final index = Random().nextInt(length);
    return index;
  }
}
