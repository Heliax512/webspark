import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webspark/data/strings.dart';
import 'package:webspark/gui/screens/result_list_screen.dart';
import 'package:webspark/gui/widgets/send_button.dart';
import 'package:webspark/logic/logic.dart';
import 'package:webspark/logic/task.dart';
import 'package:webspark/network/requests.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool activeButton = false;
  bool isCalculating = true;
  int progress = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 3));
      int taskCount = Logic.tasks.length;
      for (int i = 0; i < Logic.tasks.length; i++) {
        Logic.tasks[i].countWay();
        progress = ((i + 1) / taskCount * 100).toInt();
        setState(() {});
      }
      isCalculating = false;
      activeButton = true;
      setState(() {});
    });
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
            Strings.progress_screen,
            style: TextStyle(color: Colors.white),
          )),
      body: SafeArea(
          child: Stack(children: [
        Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isCalculating
                  ? Strings.calculating
                  : Strings.all_calculation_has_finished,
              style: TextStyle(color: Colors.black, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "$progress %",
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            SizedBox(
              height: 8,
            ),
            isShowProgress()
          ],
        )),
        GestureDetector(
            onTap: () {
              activeButton = false;
              setState(() {});
              for (int i = 0; i < Logic.tasks.length - 1; i++) {
                Reguests.postRequest(lastCallback, Strings.link, Logic.tasks);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SendButton(
                  text: Strings.send_result_to_server,
                  isActive: activeButton,
                ),
              ),
            ))
      ])),
    );
  }

  Widget isShowProgress() {
    if (activeButton) {
      return Container();
    } else {
      return LoadingAnimationWidget.flickr(
          leftDotColor: Colors.red, rightDotColor: Colors.teal, size: 50);
    }
  }


  void lastCallback(String error) {
    activeButton = true;
    setState(() {});
    if (error != "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
      ));
    } else {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => ResultListScreen()),
      );
    }
  }
}
