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

  String render(int width, int height) {
    if(lives.length == 0) {
      return 'O' * width;
    }

    return ('O' * width).replaceRange(lives[0].x, lives[0].x + 1, 'X');

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
  final subject = Cell(1, 2);
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

  test('render a game', () async {
    expect(GameOfLife.of([Cell(0, 0)]).render(1, 1), 'X');
  });

  test('render a game without any alive cells', () async {
    expect(GameOfLife.of([]).render(1, 1), 'O');
  });

  test('render a game without any alive cells but on bigger canvas', () async {
    expect(GameOfLife.of([]).render(2, 1), 'OO');
  });

  test('render a game without any alive cells but on bigger canvas', () async {
    expect(GameOfLife.of([]).render(3, 1), 'OOO');
  });

  test('render a game without any alive cells but on bigger canvas', () async {
    expect(GameOfLife.of([Cell(0, 0)]).render(3, 1), 'XOO');
  });

  test('render a game without any alive cells but on bigger canvas', () async {
    expect(GameOfLife.of([Cell(1, 0)]).render(3, 1), 'OXO');
  });

   test('render a game without any alive cells but on bigger canvas - 1', () async {
    expect(GameOfLife.of([Cell(2, 0)]).render(3, 1), 'OOX');
  });

}
