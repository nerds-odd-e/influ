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
  List<Cell> lives = [];

  GameOfLife.of(this.lives) {}

  bool survive(Cell cell) {
    int neighboursCount = cell.adjacentCells.intersection(lives.toSet()).length;
    if(lives.contains(cell) && neighboursCount == 2) return true;
    return neighboursCount == 3;
  }
}

class Cell {
  int x;
  int y;

  Cell(this.x, this.y) {}

  bool operator ==(other) => other is Cell && x == other.x && y == other.y;
  int get hashCode => x * 10000000 + y;

  Cell get topRight {
    return Cell(x+1, y+1);
  }

  Cell get bottomLeft {
    return Cell(x-1, y-1);
  }

  Cell get bottomRight {
    return Cell(x+1, y-1);
  }

  Cell get centerRight {
    return Cell(x+1, y);
  }

  Set<Cell> get adjacentCells {
    return {topRight, bottomRight, centerRight, bottomLeft};
  }

}
/**
  [1, 2, 3]
  []
 */
void main() {
  final subject = Cell(2, 30);
  test('a cell with no neighbour must die', () async {
    expect(GameOfLife.of([subject]).survive(subject), false);
  });

  test('a cell with one neighbour must die', () async {
    expect(GameOfLife.of([subject,subject.bottomRight]).survive(subject), false);
  });

  test('a cell with one neighbour and one remote neighbour must die', () async {
    expect(GameOfLife.of([subject, subject.centerRight, subject.centerRight.centerRight]).survive(subject), false);
  });

  test('a cell with two neighbours must survive', () async {
    expect(GameOfLife.of([subject, ...subject.adjacentCells.take(2)]).survive(subject), true);
  });

  test('a cell with three neighbours must survive', () async {
    expect(GameOfLife.of([subject, ...subject.adjacentCells.take(3)]).survive(subject), true);
  });

  test('a cells top-right is bottom-left return to the same cell', () async {
    expect(subject.topRight.bottomLeft, equals(subject));
  });

  test('a cell with four neighbours must die', () async {
    expect(GameOfLife.of([subject, ...subject.adjacentCells.take(4)]).survive(subject), false);
  });

  test('a cell with three neighbours will revive', () async {
    expect(GameOfLife.of([...subject.adjacentCells.take(3)]).survive(subject), true);
  });

  test('a cell with two neighbours must not revive', () async {
    expect(GameOfLife.of([...subject.adjacentCells.take(2)]).survive(subject), false);
  });

}
