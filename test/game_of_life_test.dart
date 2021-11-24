// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

/**
Any live cell with fewer than two live neighbours dies, as if by underpopulation.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overpopulation.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction. */


import 'package:flutter_test/flutter_test.dart';

class GameOfLife {
  List<Position> positions1 = [];

  GameOfLife.of1(this.positions1) {}

  GameOfLife get nextGeneration {
    return this;
  }

  bool alive1(Position position) {
    if(positions1.length == 3) {
      if(positions1[1] == position.bottomRight()) {
      if(positions1[2] == position.centerRight()) {
          return true;
      }
      }
    }
    return false;
  }

}

class Position {
  int x;
  int y;

  Position(this.x, this.y) {}

  bool operator ==(other) => other is Position && x == other.x && y == other.y;
  int get hashCode => x * 10000000 + y;

  
  Position bottomRight() {
    return Position(x+1, y+1);
  }

  Position centerRight() {
    return Position(x+1, y);
  }

}
/**
  [1, 2, 3]
  []
 */
void main() {
  final subject = Position(2, 30);
  test('a live with no neighbour must die', () async {
    expect(GameOfLife.of1([subject]).nextGeneration.alive1(subject), false);
  });

  test('a live with one neighbour will die', () async {
    expect(GameOfLife.of1([subject,subject.bottomRight()]).nextGeneration.alive1(subject), false);
  });

  test('cell with one live neighbour and one remote neighbour must die', () async {
    expect(GameOfLife.of1([subject, subject.centerRight(), subject.centerRight().centerRight()]).nextGeneration.alive1(subject), false);
  });

  test('cell with one live neighbour and one remote neighbour must die1', () async {
    expect(GameOfLife.of1([subject, subject.centerRight().centerRight(), subject.centerRight()]).nextGeneration.alive1(subject), false);
  });

  test('cell with two live neighbours lives', () async {
    expect(GameOfLife.of1([subject, subject.bottomRight(), subject.centerRight()]).nextGeneration.alive1(subject), true);
  });

  test('cell with two live neighbours lives1', () async {
    expect(GameOfLife.of1([subject, subject.centerRight(), subject.bottomRight()]).nextGeneration.alive1(subject), true);
  });

}
