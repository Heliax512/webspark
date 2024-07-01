import 'package:webspark/data/strings.dart';
import 'package:webspark/logic/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logic {
  static List<Task> tasks = [];
   static late SharedPreferences preferences;

  static void setTasks(List<Task> newTasks) {
    tasks = newTasks;
  }

  static Future<void> saveLink(String link) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(Strings.pref_link, link);
  }

  static String getLink() {
    return preferences.getString(Strings.pref_link)!;
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
