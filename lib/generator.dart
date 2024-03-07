import 'dart:math';

class Generator {
  static String getStringBeforeLastSpace(StringBuffer stringBuffer) {
    String reversedString =
        stringBuffer.toString().split('').reversed.join().trim();
    int indexOfSpace = reversedString.indexOf(' ');

    if (indexOfSpace != -1) {
      // Lấy chuỗi từ dưới lên trên cho đến khoảng trắng đầu tiên
      String result = reversedString.substring(0, indexOfSpace);

      return result
          .split('')
          .reversed
          .join(); // Đảo ngược lại chuỗi để có kết quả đúng
    } else {
      // Không có khoảng trắng, trả về toàn bộ chuỗi
      return stringBuffer.toString();
    }
  }

  static String generate3x3Scramble() {
    List<String> moves = [
      'U',
      'D',
      'R',
      'L',
      'F',
      'B'
    ]; // Up, Down, Right, Left, Front, Back

    // Optional: You can add move modifiers (e.g., '2' for a 180-degree turn, "'" for a counter-clockwise turn)
    List<String> modifiers = ['', '2', "'"];

    Random random = Random();
    StringBuffer scramble = StringBuffer();

    // Generate 20 random moves
    for (int i = 0; i < 20; i++) {
      String move = moves[random.nextInt(moves.length)];
      String modifier = modifiers[random.nextInt(modifiers.length)];
      String lastMove = getStringBeforeLastSpace(scramble);
      if (!lastMove.contains(move)) {
        scramble.write('$move$modifier ');
      } else {
        i -= 1;
      }
      ;
    }

    return scramble.toString().trim();
  }

  static List<String> moves = ["U", "D", "F", "B", "R", "L"];
  static List<String> directions = ["", "'", "2"];

  static int generateRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  static List<List<String>> generateScrambleList(int length) {
    List<List<String>> scrambleList = [];
    for (int i = 0; i < length; i++) {
      String move = moves[generateRandomInt(0, moves.length - 1)];
      String direction =
          directions[generateRandomInt(0, directions.length - 1)];
      scrambleList.add([move, direction]);
    }
    return scrambleList;
  }

  static List<List<String>> validateScramble(List<List<String>> moves) {
    for (int i = 1; i < moves.length; i++) {
      while (moves[i][0] == moves[i - 1][0]) {
        moves[i][0] = moves[generateRandomInt(0, moves.length - 1)][0];
      }
    }
    for (int i = 2; i < moves.length; i++) {
      while (moves[i][0] == moves[i - 2][0] || moves[i][0] == moves[i - 1][0]) {
        moves[i][0] = moves[generateRandomInt(0, moves.length - 1)][0];
      }
    }
    return moves;
  }

  static String generateScrambleString(List<List<String>> moves) {
    return moves.map((move) => '${move[0]}${move[1]} ').join();
  }

  static String scramble() {
    int scrambleLength = generateRandomInt(25, 28);
    List<List<String>> scrambleMoves =
        validateScramble(generateScrambleList(scrambleLength));
    String scramble = generateScrambleString(scrambleMoves);
    return scramble;
  }
}
