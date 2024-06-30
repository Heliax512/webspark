import 'package:flutter/material.dart';
import 'package:webspark/logic/task.dart';

class PreviewItem extends StatefulWidget {
  const PreviewItem({super.key, required this.task, required this.index});
  final Task task;
  final int index;
  @override
  _PreviewItemState createState() => _PreviewItemState();
}

class _PreviewItemState extends State<PreviewItem> {
  late int x;
  late int y;
  @override
  void initState() {
    x = widget.index ~/ widget.task.field.length;
    y = widget.index % widget.task.field.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: getColor(), border: Border.all(color: Colors.black)),
        child: Stack(children: [
          Center(
              child: Text(
            "($x,$y)",
            style: TextStyle(
                color: widget.task.matrix[x][y] ? Colors.black : Colors.white,
                fontSize: 20),
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

  Color getColor() {
    if (!widget.task.matrix[x][y]) {
      return Colors.black;
    }
    if (widget.task.results.first.x == x && widget.task.results.first.y == y) {
      return const Color(0xFF64FFDA);
    }
    if (widget.task.results.last.x == x && widget.task.results.last.y == y) {
      return const Color(0xFF009688);
    }
    for (int i = 1; i < widget.task.results.length - 1; i++) {
      if (widget.task.results[i].x == x && widget.task.results[i].y == y) {
        return const Color(0xFF4CAF50);
      }
    }
    return Colors.white;
  }
}
