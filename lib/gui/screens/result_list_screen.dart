import 'package:flutter/material.dart';
import 'package:webspark/data/strings.dart';
import 'package:webspark/gui/screens/preview_screen.dart';
import 'package:webspark/gui/widgets/results_item.dart';
import 'package:webspark/logic/logic.dart';

class ResultListScreen extends StatefulWidget {
  const ResultListScreen({super.key});
  @override
  _ResultListScreenState createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
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
              Strings.result_list_screen,
              style: TextStyle(color: Colors.white),
            )),
        body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(
                        right: 16, left: 16, top: 16, bottom: 68),
                    child: ListView.builder(
                        itemCount: Logic.getTasks().length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          PreviewScreen(
                                              task: Logic.getTasks()[index])),
                                );
                              },
                              child: ResultItem(task: Logic.getTasks()[index]));
                        })))));
  }
}
