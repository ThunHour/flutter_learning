import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String quesdionText;
  // ignore: use_key_in_widget_constructors
  Question(this.quesdionText);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(50),
        child: Text(
          quesdionText,
          style: const TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }
}
