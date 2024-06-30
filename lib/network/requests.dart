import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http_response;
import 'package:webspark/logic/logic.dart';
import 'package:webspark/logic/task.dart';
import 'package:webspark/logic/way_part.dart';

class Reguests {
  static void get(Function(String) callback, String link) async {
    List<Task> tasks = [];
    http_response.Client client = http_response.Client();
    try {
      final response = await client.get(Uri.parse(link));

      final body = json.decode(response.body);
      if (body["error"]) {
        callback(body["message"]);
        return;
      } else {
        List<dynamic> list = body["data"];
        for (int i = 0; i < list.length; i++) {
          tasks.add(Task.fromJson(list[i]));
        }
        Logic.setTasks(tasks);
      }
    } on Exception catch (_) {
      callback(_.toString());
      return;
    }
    callback("");
  }

  static void postRequest(
      Function(String) callback, String link, List<Task> tasks) async {
    http_response.Client client = http_response.Client();

    List<dynamic> tasksJson = [];
    for (int j = 0; j < tasks.length; j++) {
      List<dynamic> steps = [];
      for (WayPart wayPart in tasks[j].results) {
        steps.add({"x": wayPart.x, "y": wayPart.y});
      }
      Map result = {'steps': steps, 'path': Logic.getText(tasks[j])};
      Map data = {
        'id': tasks[j].id,
        'result': result,
      };
      tasksJson.add(data);
    }
    try {
      var body = json.encode(tasksJson);

      var response = await client.post(Uri.parse(link),
          headers: {"Content-Type": "application/json"}, body: body);
      final response_body = json.decode(response.body);
      if (response_body["error"]) {
        callback(response_body["message"]);
        return;
      }
    } on Exception catch (_) {
      callback(_.toString());
      return;
    }
    callback("");
  }
}
