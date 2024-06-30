import 'package:webspark/data/strings.dart';
import 'package:webspark/logic/task.dart';

class Logic {
  static List<Task> tasks = [];

  static void setTasks(List<Task> newTasks) {
    tasks = newTasks;
  }

  static List<Task> getTasks() {
    return tasks;
  }

  static String getText(Task task) {
    if (task.results.isEmpty) {
      return Strings.way_not_founded;
    } else {
      String result = task.results[0].getName();
      for (int i = 1; i < task.results.length; i++) {
        result += "->${task.results[i].getName()}";
      }
      return result;
    }
  }
}
