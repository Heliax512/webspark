import 'package:flutter/material.dart';
import 'package:webspark/data/strings.dart';
import 'package:webspark/logic/task.dart';

class ResultItem extends StatefulWidget {
  const ResultItem({super.key, required this.task});
  final Task task;
  @override
  _ResultItemState createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        child: Stack(children: [
          Center(
              child: Text(
            getText(),
            style: TextStyle(color: Colors.black, fontSize: 20),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 1,
              color: Colors.black,
            ),
          )
        ]));
  }

  String getText() {
    if (widget.task.results.isEmpty) {
      return Strings.way_not_founded;
    } else {
      String result = widget.task.results[0].getName();
      for (int i = 1; i < widget.task.results.length; i++) {
        result += "->${widget.task.results[i].getName()}";
      }
      return result;
    }
  }
}
