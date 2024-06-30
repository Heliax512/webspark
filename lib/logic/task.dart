import 'package:webspark/logic/way_part.dart';

class Task {
  String id;
  List<String> field;
  int startX;
  int startY;
  int finishX;
  int finishY;
  List<WayPart> results = [];
  List<List<bool>> matrix = [];
  Task(this.id, this.field, this.startX, this.startY, this.finishX,
      this.finishY);

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        field = List<String>.from(json['field'] as List),
        startX = json['start']['x'],
        startY = json['start']['y'],
        finishX = json['end']['x'],
        finishY = json['end']['y'];


  List<WayPart> getAllSteps(List<List<bool>> matrix, WayPart parent) {
    List<WayPart> result = [];
    if (parent.x - 1 >= 0) {
      if (matrix[parent.x - 1][parent.y]) {
        result.add(WayPart(parent, parent.x - 1, parent.y));
      }
      if (parent.y - 1 >= 0) {
        if (matrix[parent.x - 1][parent.y - 1]) {
          result.add(WayPart(parent, parent.x - 1, parent.y - 1));
        }
      }
      if (parent.y + 1 < matrix[parent.x - 1].length) {
        if (matrix[parent.x - 1][parent.y + 1]) {
          result.add(WayPart(parent, parent.x - 1, parent.y + 1));
        }
      }
    }
    if (parent.y - 1 >= 0) {
      if (matrix[parent.x][parent.y - 1]) {
        result.add(WayPart(parent, parent.x, parent.y - 1));
      }
    }
    if (parent.y + 1 < matrix[parent.x].length) {
      if (matrix[parent.x][parent.y + 1]) {
        result.add(WayPart(parent, parent.x, parent.y + 1));
      }
    }
    if (parent.x + 1 < matrix.length) {
      if (matrix[parent.x + 1][parent.y]) {
        result.add(WayPart(parent, parent.x + 1, parent.y));
      }
      if (parent.y - 1 >= 0) {
        if (matrix[parent.x + 1][parent.y - 1]) {
          result.add(WayPart(parent, parent.x + 1, parent.y - 1));
        }
      }
      if (parent.y + 1 < matrix[parent.x + 1].length) {
        if (matrix[parent.x + 1][parent.y + 1]) {
          result.add(WayPart(parent, parent.x + 1, parent.y + 1));
        }
      }
    }
    return result;
  }

  void countWay() {
    bool wayFound = false;
    List<WayPart> way = [];
    WayPart lastPart = WayPart(null, finishX, finishY);
    way.add(WayPart(null, startX, startY));
    int i = 0;
    matrix = listToMatrix();
    while (i < way.length && !wayFound) {
      List<WayPart> steps = getAllSteps(matrix, way[i]);
      for (WayPart step in steps) {
        if (!way.contains(step)) {
          way.add(step);
        }
        if (step.getName() == lastPart.getName()) {
          wayFound = true;
          break;
        }
      }
      i++;
    }
    if (wayFound) {
      List<WayPart> finalSteps = [];
      WayPart? finalPart = way.last;
      while (finalPart != null) {
        finalSteps.add(finalPart);
        finalPart = finalPart.parent;
      }
      results = finalSteps.reversed.toList();
    }
  }

  List<List<bool>> listToMatrix() {
    List<List<bool>> matrix = [];
    for (int i = 0; i < field.length; i++) {
      List<bool> row = [];
      for (int j = 0; j < field[i].length; j++) {
        row.add(field[i][j] == ".");
      }
      matrix.add(row);
    }
    return matrix;
  }
}
