import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webspark/data/strings.dart';
import 'package:webspark/gui/screens/progress_screen.dart';
import 'package:webspark/gui/widgets/send_button.dart';
import 'package:webspark/logic/logic.dart';
import 'package:webspark/network/requests.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool activeButton = true;
  final TextEditingController linkController = TextEditingController();
  @override
  void initState() {
    linkController.text = Strings.link;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: false,
          title: const Text(
            Strings.home_screen,
            style: TextStyle(color: Colors.white),
          )),
      body: SafeArea(
          child: Stack(children: [
        Column(children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              Strings.set_valid_url,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: linkController,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Link',
                    hintStyle: TextStyle(color: Colors.grey)),
              ))
        ]),
        Center(
          child: isShowProgress(),
        ),
        GestureDetector(
            onTap: () {
              if (activeButton) {
                Logic.saveLink(linkController.text);
                Reguests.get(callback, linkController.text);
                activeButton = false;
                setState(() {});
              }
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SendButton(
                    text: Strings.start_counting,
                    isActive: activeButton,
                  )),
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

  void callback(String error) {
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
            builder: (BuildContext context) => ProgressScreen()),
      );
    }
  }
}
