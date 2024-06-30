import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key, required this.text, required this.isActive});
  final String text;
  final isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          color: isActive ? Colors.teal : Colors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
        ));
  }
}
