import 'package:flutter/material.dart';
import 'package:webspark/data/strings.dart';
import 'package:webspark/gui/widgets/preview_item.dart';

import 'package:webspark/logic/logic.dart';
import 'package:webspark/logic/task.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key, required this.task});
  final Task task;
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal,
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: false,
            title: const Text(
              Strings.preview_screen,
              style: TextStyle(color: Colors.white),
            )),
        body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: SafeArea(
                child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: widget.task.field.length,
                      children: List.generate(
                          widget.task.field.length * widget.task.field.length,
                          (index) {
                        return PreviewItem(
                          task: widget.task,
                          index: index,
                        );
                      }))),
              SizedBox(
                height: 4,
              ),
              Text(
                Logic.getText(widget.task),
                style: TextStyle(color: Colors.black, fontSize: 22),
              )
            ])))));
  }
}
