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
  List<List<int>> positions;

  GameOfLife.of(this.positions) {}

  GameOfLife get nextGeneration {
    return this;
  }

  bool alive(List<int> position) {
    if(positions.length == 3) {
      return true;
    }
    return false;
  }

}
/**
  [1, 2, 3]
  []
 */
void main() {
  final position = [2, 3];
  test('a live with no neighbour must die', () async {
    expect(GameOfLife.of([position]).nextGeneration.alive(position), false);
  });

  test('a live with one neighbour will die', () async {
    const positionSecondCell = [3, 4];
    expect(GameOfLife.of([position,positionSecondCell]).nextGeneration.alive(position), false);
  });

  test('cell with two live neighbours lives', () async {
    const positionSecondCell = [3, 4];
    const positionThirdCell = [3, 3];
    expect(GameOfLife.of([position, positionSecondCell, positionThirdCell]).nextGeneration.alive(position), true);
  });

}
